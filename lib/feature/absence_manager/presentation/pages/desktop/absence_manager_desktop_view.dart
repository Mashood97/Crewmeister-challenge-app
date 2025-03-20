import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/widgets/data_table/absence_list_data_table.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/utils/extensions/context_extensions.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text("Mashood's Crew"),
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
      body: BlocProvider.value(
        value: absenceListBloc,
        child: BlocConsumer<AbsenceListBloc, AbsenceListState>(
          listener: (ctx, state) {
            if (state is AbsenceListFailure) {
              AppSnackBar()
                  .showErrorSnackBar(context: ctx, error: state.errorMessage);
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
            );

            //   ListView.builder(
            //   itemBuilder: (ctx, index) => ListTile(
            //     title: Text(
            //       state.absenceList[index].userId.toString(),
            //     ),
            //   ),
            //   itemCount: state.absenceList.length,
            // );
          },
        ),
      ),
    );
  }
}
