import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
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
            return ListView.builder(
              itemBuilder: (ctx, index) => ListTile(
                title: Text(
                  state.absenceList[index].userId.toString(),
                ),
              ),
              itemCount: state.absenceList.length,
            );
          },
        ),
      ),
    );
  }
}
