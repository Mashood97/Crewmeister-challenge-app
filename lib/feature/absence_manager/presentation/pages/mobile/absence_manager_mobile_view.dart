import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/absence_list_view.dart';
import 'package:absence_manager_app/utils/constant/app_constant.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/navigation/app_navigations.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AbsenceManagerMobileView extends StatelessWidget {
  const AbsenceManagerMobileView({
    required this.absenceListBloc,
    super.key,
  });

  final AbsenceListBloc absenceListBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: absenceListBloc,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('CrewAbsence'),
          centerTitle: false,
          actions: [
            // FloatingActionButton.small(
            //   onPressed: () {
            //     getItInstance.get<ThemeCubit>().changeThemeMode(ThemeMode.light);
            //   },
            //   child: const Icon(
            //     Icons.settings,
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Mashood Siddiquie',
              style: context.theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(AppConstant.kAppSidePadding),
          child: SizedBox(
            width: double.infinity,
            height: getResponsiveValue(context, 75),
            child: Card(
              color: context.theme.colorScheme.primary,
              elevation: 0,
              child: BlocSelector<AbsenceListBloc, AbsenceListState, int>(
                selector: (state) {
                  return state.absenceList.length;
                },
                builder: (context, state) {
                  return ListTile(
                    title: Text(
                      'Total Absences: ',
                      style: context.theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    trailing: Text(
                      '$state',
                      style: context.theme.textTheme.titleLarge,
                    )
                        .animate()
                        .fade(
                          duration: 500.ms,
                          delay: 2.seconds,
                        )
                        .slideX(
                          duration: 600.ms,
                          delay: 3.seconds,
                        ),
                  );
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstant.kAppSidePadding),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                  ),
                  icon: BlocSelector<AbsenceListBloc, AbsenceListState, bool>(
                    selector: (state) {
                      return state.hasFiltersApplied;
                    },
                    builder: (ctx, state) {
                      return !state
                          ? getFilterIcon(context: ctx, isFilterApplied: state)
                          : Badge(
                              smallSize: 10,
                              largeSize: 15,
                              child: getFilterIcon(
                                context: ctx,
                                isFilterApplied: state,
                              ),
                            );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<AbsenceListBloc, AbsenceListState>(
                listener: (ctx, state) {
                  if (state is AbsenceListFailure) {
                    AppSnackBar().showErrorSnackBar(
                        context: ctx, error: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is AbsenceListLoading) {
                    return const AppLoader();
                  }
                  if (state is AbsenceListLoaded) {
                    return state.absenceList.isEmpty
                        ? const AppError(
                            errorMessage: 'No Record Found',
                          )
                        : AbsenceListView(
                            absenceList: state.absenceList,
                            userMap: state.userMap,
                          ).animate().fade(
                              duration: 2.seconds,
                            );
                  }
                  if (state is AbsenceListFailure) {
                    return AppError(
                      errorMessage: state.errorMessage,
                    );
                  }
                  return const AppError(
                    errorMessage: 'Unable to fetch the records',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getFilterIcon({
    required BuildContext context,
    required bool isFilterApplied,
  }) {
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
                        value: state.selectedAbsenceTypeFilter,
                        onChanged: (value) {
                          if (value != null) {
                            /// This will apply the absence type filter to fetch
                            /// data as per the user selected absence type.
                            AppNavigations().navigateBack(context: ctx);
                            absenceListBloc.add(
                              FetchAbsenceListEvent(
                                selectedAbsenceType: value,
                              ),
                            );
                          }
                        },
                        items: state.absenceTypeList
                            .map<DropdownMenuItem<String>>((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
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
                    final result = await showDatePicker(
                      context: ctx,
                      firstDate: DateTime(1900),
                      currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(5000),
                    );
                    if (result != null) {
                      /// This will apply the date filter to fetch
                      /// data as per the user selected date.
                      absenceListBloc.datePickerTextEditingController.text =
                          DateFormat.yMEd().format(result);
                      AppNavigations().navigateBack(context: ctx);
                      absenceListBloc.add(
                        FetchAbsenceListEvent(
                          selectedDateTime: result.toIso8601String(),
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
