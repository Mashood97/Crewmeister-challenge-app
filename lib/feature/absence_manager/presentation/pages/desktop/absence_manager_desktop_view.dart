import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/data_table/absence_list_data_table.dart';
import 'package:absence_manager_app/utils/constant/app_constant.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AbsenceManagerDesktopView extends StatelessWidget {
  const AbsenceManagerDesktopView({
    required this.absenceListBloc,
    super.key,
  });

  final AbsenceListBloc absenceListBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CrewAbsence'),
        centerTitle: false,
        actions: [
          FloatingActionButton.small(
            onPressed: () {
              getItInstance.get<ThemeCubit>().changeThemeMode(ThemeMode.light);
            },
            child: const Icon(
              Icons.settings,
            ),
          ),
          const SizedBox(
            width: 20,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstant.kAppSidePadding),
            child: SizedBox(
              width: double.infinity,
              // height: getResponsiveValue(context, 75),
              child: Card(
                color: context.theme.colorScheme.primary,
                elevation: 0,
                child: BlocProvider.value(
                  value: absenceListBloc,
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
          ),
          Expanded(
            child: BlocProvider.value(
              value: absenceListBloc,
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

                  if (state is AbsenceListFailure) {
                    return AppError(
                      errorMessage: state.errorMessage,
                    );
                  }
                  return AbsenceListDataTable(
                    absenceList: state.absenceList,
                    userMap: state.userMap,
                    absenceListBloc: absenceListBloc,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
