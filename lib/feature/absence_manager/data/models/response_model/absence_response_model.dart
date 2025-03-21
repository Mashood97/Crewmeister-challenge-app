import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absence_response_model.g.dart';

@JsonSerializable(checked: true)
class AbsenceResponseModel extends AbsenceResponseEntity {
  const AbsenceResponseModel({
    required this.absenceType,
    required this.memberNote,
    required this.rejectedAt,
    required this.confirmedAt,
    required this.admitterNote,
    required this.absenceStartDate,
    required this.absenceEndDate,
    required this.userId,
    required this.createdAt,
  }) : super(
          absenceType: absenceType,
          memberNote: memberNote,
          rejectedAt: rejectedAt,
          confirmedAt: confirmedAt,
          admitterNote: admitterNote,
          absenceStartDate: absenceStartDate,
          absenceEndDate: absenceEndDate,
          userId: userId,
          createdAt: createdAt,
        );

  factory AbsenceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AbsenceResponseModelToJson(this);
  @override
  @JsonKey(name: 'userId')
  final int? userId;
  @override
  @JsonKey(name: 'type')
  final String? absenceType;
  @override
  @JsonKey(name: 'memberNote')
  final String? memberNote;
  @override
  @JsonKey(name: 'rejectedAt')
  final String? rejectedAt;
  @override
  @JsonKey(name: 'confirmedAt')
  final String? confirmedAt;
  @override
  @JsonKey(name: 'admitterNote')
  final String? admitterNote;
  @override
  @JsonKey(name: 'startDate')
  final String? absenceStartDate;
  @override
  @JsonKey(name: 'endDate')
  final String? absenceEndDate;

  @JsonKey(name: 'createdAt')
  final String? createdAt;
}
