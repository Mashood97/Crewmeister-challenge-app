import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

///Here we check the models inside data layer i.e extends entity, from json
///and to json methods for Absence Response Model.

void main() {
  const tAbsenceResponseModel = AbsenceResponseModel(
    userId: 5293,
    absenceEndDate: '2021-05-24',
    absenceStartDate: '2021-05-24',
    absenceType: 'vacation',
    admitterNote: '-',
    confirmedAt: '2021-05-22T08:50:28.000+02:00',
    createdAt: '2021-05-21T17:24:42.000+02:00',
    memberNote: '-',
    rejectedAt: null,
  );

  final _absenceJson = <String, dynamic>{
    'admitterNote': '-',
    'confirmedAt': '2021-05-22T08:50:28.000+02:00',
    'createdAt': '2021-05-21T17:24:42.000+02:00',
    'endDate': '2021-05-24',
    'memberNote': '-',
    'rejectedAt': null,
    'startDate': '2021-05-24',
    'type': 'vacation',
    'userId': 5293
  };

  test('should be a subclass of Absence Response Entity', () async {
    expect(tAbsenceResponseModel, isA<AbsenceResponseEntity>());
  });

  //here we will be test check if model returns a valid absence.

  group('fromJson', () {
    test(
      'Should return a valid Absence Response Model',
      () async {
        final jsonMap = _absenceJson;

        final result = AbsenceResponseModel.fromJson(jsonMap);

        expect(result, tAbsenceResponseModel);
      },
    );
  });

  group('ToJson', () {
    test('Should return a valid json on sending proper data', () async {
      final result = tAbsenceResponseModel.toJson();
      expect(
        result,
        {
          'type': 'vacation',
          'userId': 5293,
          'memberNote': '-',
          'rejectedAt': null,
          'confirmedAt': '2021-05-22T08:50:28.000+02:00',
          'admitterNote': '-',
          'startDate': '2021-05-24',
          'endDate': '2021-05-24',
          'createdAt': '2021-05-21T17:24:42.000+02:00',
        },
      );
    });
  });
}
