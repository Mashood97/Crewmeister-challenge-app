import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/absence_list_view.dart';
import 'package:absence_manager_app/utils/constant/app_constant.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceManagerMobileView extends StatelessWidget {
  const AbsenceManagerMobileView({
    required this.absenceListBloc,
    super.key,
  });

  final AbsenceListBloc absenceListBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absence Manager'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstant.kAppSidePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getResponsiveValue(context, 220),
                  height: getResponsiveValue(context, 50),
                  child: Card(
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Total Absences: ',
                          style: context.theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${absenceListBloc.state.absenceList.length}',
                              style: context.theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
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

                  return AbsenceListView(
                    absenceList: state.absenceList,
                    userMap: state.userMap,
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
