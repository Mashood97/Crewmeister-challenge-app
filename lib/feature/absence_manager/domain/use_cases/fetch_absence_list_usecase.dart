import 'package:absence_manager_app/core/error/response_error.dart';
import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:dartz/dartz.dart';

class FetchAbsenceListUseCase
    implements UseCase<List<AbsenceResponseEntity>, NoParams> {
  const FetchAbsenceListUseCase({required this.absenceManagerRepository});

  final AbsenceManagerRepository absenceManagerRepository;

  @override
  Future<Either<ResponseError, List<AbsenceResponseEntity>>> call(
      NoParams params) async {
    return absenceManagerRepository.fetchAbsenceList();
  }
}
