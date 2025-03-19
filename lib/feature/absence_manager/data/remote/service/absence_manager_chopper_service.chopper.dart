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
    final Uri $url = Uri.parse('/8c3cbc94-d330-45fb-9431-9856df605706');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
