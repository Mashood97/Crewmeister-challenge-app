// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_manager_chopper_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AbsenceManagerChopperService
    extends AbsenceManagerChopperService {
  _$AbsenceManagerChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AbsenceManagerChopperService;

  @override
  Future<Response<Map<String, dynamic>>> fetchAbsenceListFromServer() {
    final Uri $url = Uri.parse('/99b8c986-ba27-4fd7-9df4-9e3b57dedd1d');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> fetchUserListFromServer() {
    final Uri $url = Uri.parse('/5d854afb-0f55-4c83-af35-b999c9ce2bee');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
