import 'package:absence_manager_app/feature/absence_manager/presentation/pages/absence_manager_view.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:absence_manager_app/utils/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterNavigationDelegate {
  factory GoRouterNavigationDelegate() {
    return _singleton;
  }

  GoRouterNavigationDelegate._internal();

  static final GoRouterNavigationDelegate _singleton =
      GoRouterNavigationDelegate._internal();

  final parentNavigationKey = GlobalKey<NavigatorState>();
  late final GoRouter router = GoRouter(
    navigatorKey: parentNavigationKey,
    debugLogDiagnostics: true,
    redirect: (ctx, state) async {
      return null;
    },
    initialLocation: NavigationRouteNames.initialRoute,
    routes: [
      GoRoute(
        parentNavigatorKey: parentNavigationKey,
        path: NavigationRouteNames.initialRoute,
        name: NavigationRouteNames.initialRoute,
        builder: (BuildContext ctx, GoRouterState state) =>
            const AbsenceManagerView(),
        // routes: [
          //
          // GoRoute(
          //     path: NavigationRouteNames
          //         .weatherDetailsPage.convertRoutePathToRouteName,
          //     name: NavigationRouteNames
          //         .weatherDetailsPage.convertRoutePathToRouteName,
          //     pageBuilder: (BuildContext ctx, GoRouterState state) {
          //       final routeItem = state.uri.queryParameters;
          //       return MaterialPage(
          //         fullscreenDialog: true,
          //         child: WeatherDetailsPage(
          //           queryParams: routeItem,
          //         ),
          //       );
          //     }),
        // ],
      ),
    ],
  );
}
