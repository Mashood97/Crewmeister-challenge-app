import 'package:absence_manager_app/core/error/response_error.dart';
import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';

class FetchUserListUseCase
    implements UseCase<List<UserResponseEntity>, NoParams> {
  const FetchUserListUseCase({required this.absenceManagerRepository});

  final AbsenceManagerRepository absenceManagerRepository;

  @override
  Future<Either<ResponseError, List<UserResponseEntity>>> call(
    NoParams params,
  ) async {
    return absenceManagerRepository.fetchUserList();
  }
}
