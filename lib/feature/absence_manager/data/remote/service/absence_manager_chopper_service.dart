import 'package:absence_manager_app/utils/constant/api_routes.dart';
import 'package:chopper/chopper.dart';

part 'absence_manager_chopper_service.chopper.dart';

@ChopperApi()
abstract class AbsenceManagerChopperService extends ChopperService {
  static AbsenceManagerChopperService create([ChopperClient? client]) =>
      _$AbsenceManagerChopperService(client);

  @GET(
    path: ApiRoutes.fetchAbsencesRoute,
  )
  Future<Response<Map<String, dynamic>>> fetchAbsenceListFromServer();

  @GET(
    path: ApiRoutes.fetchUsersRoute,
  )
  Future<Response<Map<String, dynamic>>> fetchUserListFromServer();
}
