import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// rejectedAt,confirmedAt will be used to manage the Status
/// (can be 'Requested', 'Confirmed' or 'Rejected').

/// absenceStartDate,absenceEndDate will be used to manage the period/number of days

class AbsenceResponseEntity extends Equatable {
  const AbsenceResponseEntity({
    required this.absenceType,
    required this.memberNote,
    required this.rejectedAt,
    required this.confirmedAt,
    required this.admitterNote,
    required this.absenceStartDate,
    required this.absenceEndDate,
    required this.userId,
    required this.createdAt,
  });

  final int? userId;
  final String? absenceType;
  final String? memberNote;
  final String? rejectedAt;
  final String? confirmedAt;
  final String? admitterNote;
  final String? absenceStartDate;
  final String? absenceEndDate;
  final String? createdAt;

  @override
  List<Object?> get props => [
        absenceType,
        memberNote,
        rejectedAt,
        confirmedAt,
        admitterNote,
        absenceStartDate,
        absenceEndDate,
        userId,
    createdAt,
      ];

  String get absenceStatus => confirmedAt == null && rejectedAt == null
      ? 'Requested'
      : confirmedAt != null
          ? 'Confirmed'
          : 'Rejected';

  Color get absenceStatusColor => confirmedAt == null && rejectedAt == null
      ? Colors.amber
      : confirmedAt != null
          ? Colors.green
          : Colors.red;
}
