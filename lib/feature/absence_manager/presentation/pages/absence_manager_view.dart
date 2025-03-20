import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/pages/desktop/absence_manager_desktop_view.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/pages/mobile/absence_manager_mobile_view.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceManagerView extends StatefulWidget {
  const AbsenceManagerView({super.key});

  @override
  State<AbsenceManagerView> createState() => _AbsenceManagerViewState();
}

class _AbsenceManagerViewState extends State<AbsenceManagerView> {
  late AbsenceListBloc absenceListBloc;

  @override
  void initState() {
    super.initState();
    absenceListBloc = getItInstance.get<AbsenceListBloc>();
    absenceListBloc
      ..add(const FetchAbsenceListEvent())
      ..add(const FetchUserListEvent());
  }

  @override
  void dispose() {
    absenceListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveView(
      mobile: AbsenceManagerMobileView(
        absenceListBloc: absenceListBloc,
      ),
      desktop: AbsenceManagerDesktopView(
        absenceListBloc: absenceListBloc,

      ),
    );
  }
}
