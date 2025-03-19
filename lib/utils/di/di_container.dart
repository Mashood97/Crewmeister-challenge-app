import 'package:absence_manager_app/utils/internet_checker/network_bloc.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

void initializeDependencies() {
  _registerBlocAndCubits();
  _registerRepositories();
  _registerExternalPackages();
}

void _registerBlocAndCubits() {
  getItInstance
    ..registerLazySingleton(
      NetworkBloc.new,
    )
    ..registerLazySingleton(
      ThemeCubit.new,
    );
}

void _registerRepositories() {}

void _registerExternalPackages() {}
