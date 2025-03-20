import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_model.g.dart';

@JsonSerializable(checked: true)
class UserResponseModel extends UserResponseEntity {
  const UserResponseModel({
    required this.userId,
    required this.userName,
  }) : super(
          userId: userId,
          userName: userName,
        );

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
  @override
  @JsonKey(name: 'userId')
  final int? userId;

  @override
  @JsonKey(name: 'name')
  final String? userName;
}
