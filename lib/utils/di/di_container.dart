import 'package:absence_manager_app/core/platform/network_information.dart';
import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart';
import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source_implementation.dart';
import 'package:absence_manager_app/feature/absence_manager/data/repositories/absence_manager_repository_implementation.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/utils/internet_checker/network_bloc.dart';
import 'package:absence_manager_app/utils/theme/cubit/cubit/theme_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.instance;

void initializeDependencies() {
  _registerBlocAndCubits();
  _registerUseCases();
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
    )
    ..registerFactory<AbsenceListBloc>(
      () => AbsenceListBloc(
        absenceListUseCase: getItInstance(),
        fetchUserListUseCase: getItInstance(),
      ),
    );
}

void _registerUseCases() {
  getItInstance
    ..registerLazySingleton(
      () => FetchAbsenceListUseCase(
        absenceManagerRepository: getItInstance(),
      ),
    )
    ..registerLazySingleton(
      () => FetchUserListUseCase(
        absenceManagerRepository: getItInstance(),
      ),
    );
}

void _registerRepositories() {
  getItInstance
    ..registerLazySingleton<AbsenceManagerRepository>(
      () => AbsenceManagerRepositoryImplementation(
        networkInfo: getItInstance(),
        absenceManagerRemoteDataSource: getItInstance(),
      ),
    )
    ..registerLazySingleton<AbsenceManagerRemoteDataSource>(
      AbsenceManagerRemoteDataSourceImplementation.new,
    );
}

void _registerExternalPackages() {
  getItInstance
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        networkConnectionCheck: getItInstance(),
      ),
    )
    ..registerLazySingleton(Connectivity.new);
}
