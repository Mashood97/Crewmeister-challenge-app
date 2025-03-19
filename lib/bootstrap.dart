import 'dart:async';
import 'dart:developer';

import 'package:absence_manager_app/utils/chopper_client/chopper_client.dart';
import 'package:absence_manager_app/utils/di/di_container.dart' as di;
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
// Add cross-flavor configuration here
  Bloc.observer = const AppBlocObserver();
  di.initializeDependencies();
  ChopperClientInstance.initializeChopperClient();


  runApp(await builder());
}
