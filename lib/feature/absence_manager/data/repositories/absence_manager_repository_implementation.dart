import 'package:absence_manager_app/core/error/response_error.dart';
import 'package:absence_manager_app/core/platform/network_information.dart';
import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';

class AbsenceManagerRepositoryImplementation
    implements AbsenceManagerRepository {
  const AbsenceManagerRepositoryImplementation({
    required this.absenceManagerRemoteDataSource,
    required this.networkInfo,
  });

  final AbsenceManagerRemoteDataSource absenceManagerRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<ResponseError, List<AbsenceResponseEntity>>>
      fetchAbsenceList() async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await absenceManagerRemoteDataSource.fetchAbsenceListFromServer();

        return Right(response);
      } on ResponseError catch (e) {
        return Left(e);
      }
    } else {
      return Left(
        ResponseError(
          errorStatus:
              'It seems that your device is not connected to the network.please check your internet connectivity or try again later.',
        ),
      );
    }
  }

  @override
  Future<Either<ResponseError, List<UserResponseEntity>>>
      fetchUserList() async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await absenceManagerRemoteDataSource.fetchUserListFromServer();

        return Right(response);
      } on ResponseError catch (e) {
        return Left(e);
      }
    } else {
      return Left(
        ResponseError(
          errorStatus:
              'It seems that your device is not connected to the network.please check your internet connectivity or try again later.',
        ),
      );
    }
  }
}
