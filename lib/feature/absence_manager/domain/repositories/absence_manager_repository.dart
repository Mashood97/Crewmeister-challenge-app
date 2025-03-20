import 'package:absence_manager_app/core/error/response_error.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AbsenceManagerRepository {
  Future<Either<ResponseError, List<AbsenceResponseEntity>>> fetchAbsenceList();
  Future<Either<ResponseError, List<UserResponseEntity>>> fetchUserList();
}
