import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';

abstract class AbsenceManagerRemoteDataSource {
  Future<List<AbsenceResponseModel>> fetchAbsenceListFromServer();
}
