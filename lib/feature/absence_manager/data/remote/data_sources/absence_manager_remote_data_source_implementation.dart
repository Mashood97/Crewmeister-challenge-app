import 'dart:convert';

import 'package:absence_manager_app/core/error/response_error.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
      import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/user_response_model.dart';
      import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart';
      import 'package:absence_manager_app/feature/absence_manager/data/remote/service/absence_manager_chopper_service.dart';
      import 'package:absence_manager_app/utils/chopper_client/chopper_client.dart';
      import 'package:absence_manager_app/utils/constant/app_constant.dart';
      import 'package:absence_manager_app/utils/extensions/string_extensions.dart';

    class AbsenceManagerRemoteDataSourceImplementation
    implements AbsenceManagerRemoteDataSource {
    final AbsenceManagerChopperService absenceManagerChopperService =
    AbsenceManagerChopperService.create(ChopperClientInstance.client);

    @override
    Future<List<AbsenceResponseModel>> fetchAbsenceListFromServer() async {
    final response =
    await absenceManagerChopperService.fetchAbsenceListFromServer();
    if (response.isSuccessful) {
    final body = response.bodyString;
    final decodedBody = jsonDecode(body);
    final items = decodedBody['payload'] as List<dynamic>;
    if (items.isNotEmpty) {
    return items
        .map(
    (e) => AbsenceResponseModel.fromJson(
    e as Map<String, dynamic>,
    ),
    )
        .toList();
    }
    }

    /// Mocking the local response to get the app work (Just for the test) to
    /// fix the mock api issue.
    else {
      final result = await MockLocalData().absences();
      if (result.isNotEmpty) {
        return result
            .map(
              (e) => AbsenceResponseModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    }

    if (response.error != null) {
      final body = response.error as String?;
      var errorMsg = 'No Record Found';
      if (body?.isTextNotNullAndNotEmpty == true) {
        errorMsg = body ?? 'No Record Found';
      }

      throw ResponseError(errorStatus: errorMsg);
    }
    return [];
  }

  @override
  Future<List<UserResponseModel>> fetchUserListFromServer() async {
    final response =
        await absenceManagerChopperService.fetchUserListFromServer();
    if (response.isSuccessful) {
      final body = response.bodyString;
      final decodedBody = jsonDecode(body);
      final items = decodedBody['payload'] as List<dynamic>;
      if (items.isNotEmpty) {
        return items
            .map(
              (e) => UserResponseModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    }

    /// Mocking the local response to get the app work (Just for the test) to
    /// fix the mock api issue.
    else {
      final result = await MockLocalData().members();
      if (result.isNotEmpty) {
        return result
            .map(
              (e) => UserResponseModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      }
    }

    if (response.error != null) {
      final body = response.error as String?;
      var errorMsg = 'No Record Found';
      if (body?.isTextNotNullAndNotEmpty == true) {
        errorMsg = body ?? 'No Record Found';
      }

      throw ResponseError(errorStatus: errorMsg);
    }
    return [];
  }
}
