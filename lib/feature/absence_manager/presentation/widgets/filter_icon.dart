import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/utils/constant/app_constant.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/navigation/app_navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    required this.absenceListBloc,
    required this.isFilterApplied,
    super.key,
  });

  final bool isFilterApplied;
  final AbsenceListBloc absenceListBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        /// We don't return anything that's why we have used the type void.
        await showModalBottomSheet<void>(
          context: context,
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(
              AppConstant.kAppSidePadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Filters',
                    style: ctx.theme.textTheme.titleMedium,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: IconButton(
                    onPressed: () {
                      AppNavigations().navigateBack(context: ctx);
                    },
                    icon: const Icon(
                      Icons.cancel,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Pick Absence Type:',
                  style: ctx.theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocProvider.value(
                  value: absenceListBloc,
                  child: BlocBuilder<AbsenceListBloc, AbsenceListState>(
                    builder: (context, state) {
                      return DropdownButtonFormField<String>(
                        value: state.selectedAbsenceTypeFilter.isEmpty
                            ? null
                            : state.selectedAbsenceTypeFilter,
                        hint: Text(
                          'Select Absence Type',
                          style: context.theme.textTheme.bodyMedium,
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            /// This will apply the absence type filter to fetch
                            /// data as per the user selected absence type.
                            AppNavigations().navigateBack(context: ctx);
                            absenceListBloc.add(
                              FetchAbsenceListEvent(
                                selectedAbsenceType: value,
                                selectedDateTime:
                                    absenceListBloc.state.selectedDateFilter,
                              ),
                            );
                          }
                        },
                        items: state.absenceTypeList
                            .map<DropdownMenuItem<String>>((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: context.theme.textTheme.bodyMedium,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Pick Date:',
                  style: ctx.theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: absenceListBloc.datePickerTextEditingController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Pick Date',
                    hintText: 'e.g. 2025-01-01',
                    suffixIcon: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                  onTap: () async {
                    final result = await showDateRangePicker(
                      context: ctx,
                      firstDate: DateTime(1900),
                      currentDate: DateTime.now(),
                      initialDateRange: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(
                          const Duration(days: 5),
                        ),
                      ),
                      lastDate: DateTime(5000),
                    );
                    if (result != null) {
                      /// This will apply the date filter to fetch
                      /// data as per the user selected date.
                      absenceListBloc.datePickerTextEditingController.text =
                          '${DateFormat.yMEd().format(result.start)}-${DateFormat.yMEd().format(result.end)}';
                      AppNavigations().navigateBack(context: ctx);
                      absenceListBloc.add(
                        FetchAbsenceListEvent(
                          selectedAbsenceType:
                              absenceListBloc.state.selectedAbsenceTypeFilter,
                          selectedDateTime:
                              '${result.start.toIso8601String()},${result.end.toIso8601String()}',
                        ),
                      );
                    }
                  },
                ),
                const Spacer(),
                if (!isFilterApplied)
                  const SizedBox.shrink()
                else
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        /// This will clear all the filters and
                        /// will fetch all the absence list.
                        absenceListBloc.datePickerTextEditingController.clear();
                        AppNavigations().navigateBack(context: ctx);
                        absenceListBloc.add(
                          const FetchAbsenceListEvent(),
                        );
                      },
                      child: const Text('Clear Filters'),
                    ),
                  ),
                if (!isFilterApplied)
                  const SizedBox.shrink()
                else
                  const SizedBox(
                    height: 10,
                  ),
              ],
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.filter_list,
      ),
    );
  }
}
