// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserResponseModel',
      json,
      ($checkedConvert) {
        final val = UserResponseModel(
          userId: $checkedConvert('userId', (v) => (v as num?)?.toInt()),
          userName: $checkedConvert('name', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'userName': 'name'},
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.userName,
    };
