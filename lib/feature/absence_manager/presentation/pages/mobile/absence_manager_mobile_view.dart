import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/absence_list_view.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/filter_icon.dart';
import 'package:absence_manager_app/utils/constant/app_constant.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceManagerMobileView extends StatelessWidget {
  const AbsenceManagerMobileView({
    required this.absenceListBloc,
    required this.themeCubit,
    super.key,
  });

  final AbsenceListBloc absenceListBloc;
  final ThemeCubit themeCubit;

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
            FloatingActionButton.small(
              onPressed: () {
                if (themeCubit.state.themeMode == ThemeMode.light) {
                  themeCubit.changeThemeMode(ThemeMode.dark);
                } else {
                  themeCubit.changeThemeMode(ThemeMode.light);
                }
              },
              child: themeCubit.state.themeMode == ThemeMode.light
                  ? const Icon(Icons.dark_mode)
                  : const Icon(
                Icons.light_mode,
              ),
            ),
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
                  if (state is AbsenceListLoading &&
                      state.absenceList.isEmpty) {
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
                            scrollController: absenceListBloc.scrollController,
                            hasMoreItems: state.hasMore,

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
    return FilterIcon(
      absenceListBloc: absenceListBloc,
      isFilterApplied: isFilterApplied,
    );
  }
}
