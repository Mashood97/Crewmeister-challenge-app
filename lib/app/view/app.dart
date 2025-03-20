import 'package:absence_manager_app/l10n/l10n.dart';
import 'package:absence_manager_app/utils/di/di_container.dart';
import 'package:absence_manager_app/utils/internet_checker/network_bloc.dart';
import 'package:absence_manager_app/utils/internet_checker/network_event.dart';
import 'package:absence_manager_app/utils/navigation/go_router_navigation_delegate.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

final _router = GoRouterNavigationDelegate();

final internetConnection = getItInstance.get<NetworkBloc>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    themeCubit = getItInstance.get<ThemeCubit>();
    internetConnection.add(const NetworkObserve());
  }

  @override
  void dispose() {
    themeCubit.close();
    internetConnection.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: themeCubit,
        ),
        BlocProvider.value(
          value: internetConnection,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: state.lightTheme,
            darkTheme: state.darkTheme,
            routerConfig: _router.router,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(
                  start: 0,
                  end: 746,
                  name: MOBILE,
                ),
                const Breakpoint(
                  start: 747,
                  end: 1000,
                  name: TABLET,
                ),
                const Breakpoint(
                  start: 1001,
                  end: double.infinity,
                  name: DESKTOP,
                ),
              ],
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
