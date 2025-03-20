import 'package:equatable/equatable.dart';

class UserResponseEntity extends Equatable {
  const UserResponseEntity({
    required this.userId,
    required this.userName,
  });

  final int? userId;
  final String? userName;

  @override
  List<Object?> get props => [
        userId,
        userName,
      ];
}
