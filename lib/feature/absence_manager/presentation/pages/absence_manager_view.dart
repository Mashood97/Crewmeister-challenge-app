import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/pages/desktop/absence_manager_desktop_view.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/pages/mobile/absence_manager_mobile_view.dart';
import 'package:absence_manager_app/utils/constant/app_snackbar.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:absence_manager_app/widget/error/app_error.dart';
import 'package:absence_manager_app/widget/loader/app_loader.dart';
import 'package:absence_manager_app/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AbsenceManagerView extends StatefulWidget {
  const AbsenceManagerView({super.key});

  @override
  State<AbsenceManagerView> createState() => _AbsenceManagerViewState();
}

class _AbsenceManagerViewState extends State<AbsenceManagerView> {
  late AbsenceListBloc absenceListBloc;
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    absenceListBloc = getItInstance.get<AbsenceListBloc>();
    themeCubit = getItInstance.get<ThemeCubit>();
    absenceListBloc
      ..add(const FetchAbsenceListEvent())
      ..add(const FetchUserListEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ResponsiveBreakpoints.of(context).isDesktop) {
        absenceListBloc.attachListenerToScrollController();
      }
    });
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
        themeCubit: themeCubit,
      ),
      desktop: AbsenceManagerDesktopView(
        absenceListBloc: absenceListBloc,
        themeCubit: themeCubit,
      ),
    );
  }
}
