import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/user_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

///Here we check the models inside data layer i.e extends entity, from json
///and to json methods for Absence Response Model.

void main() {
  const tUserResponseModel = UserResponseModel(
    userId: 1001,
    userName: 'Max',
  );

  final _userJson = <String, dynamic>{
    'userId': 1001,
    'name': 'Max',
  };

  test('should be a subclass of User Response Entity', () async {
    expect(tUserResponseModel, isA<UserResponseEntity>());
  });

  //here we will be test check if model returns a valid user.

  group('fromJson', () {
    test(
      'Should return a valid User Response Model',
      () async {
        final jsonMap = _userJson;

        final result = UserResponseModel.fromJson(jsonMap);

        expect(result, tUserResponseModel);
      },
    );
  });

  group(
    'ToJson',
    () {
      test(
        'Should return a valid json on sending proper data',
        () async {
          final result = tUserResponseModel.toJson();
          expect(
            result,
            {
              'userId': 1001,
              'name': 'Max',
            },
          );
        },
      );
    },
  );
}
