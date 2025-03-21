// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceResponseModel _$AbsenceResponseModelFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'AbsenceResponseModel',
      json,
      ($checkedConvert) {
        final val = AbsenceResponseModel(
          absenceType: $checkedConvert('type', (v) => v as String?),
          memberNote: $checkedConvert('memberNote', (v) => v as String?),
          rejectedAt: $checkedConvert('rejectedAt', (v) => v as String?),
          confirmedAt: $checkedConvert('confirmedAt', (v) => v as String?),
          admitterNote: $checkedConvert('admitterNote', (v) => v as String?),
          absenceStartDate: $checkedConvert('startDate', (v) => v as String?),
          absenceEndDate: $checkedConvert('endDate', (v) => v as String?),
          userId: $checkedConvert('userId', (v) => (v as num?)?.toInt()),
          createdAt: $checkedConvert('createdAt', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'absenceType': 'type',
        'absenceStartDate': 'startDate',
        'absenceEndDate': 'endDate'
      },
    );

Map<String, dynamic> _$AbsenceResponseModelToJson(
        AbsenceResponseModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'type': instance.absenceType,
      'memberNote': instance.memberNote,
      'rejectedAt': instance.rejectedAt,
      'confirmedAt': instance.confirmedAt,
      'admitterNote': instance.admitterNote,
      'startDate': instance.absenceStartDate,
      'endDate': instance.absenceEndDate,
      'createdAt': instance.createdAt,
    };
