part of 'absence_list_bloc.dart';

sealed class AbsenceListEvent extends Equatable {
  const AbsenceListEvent();
}

final class FetchAbsenceListEvent extends AbsenceListEvent {
  const FetchAbsenceListEvent({
    this.selectedAbsenceType = '',
    this.selectedDateTime = '',
  });

  final String selectedAbsenceType;
  final String selectedDateTime;

  @override
  List<Object?> get props => [
        selectedAbsenceType,
        selectedDateTime,
      ];
}

final class FetchMoreAbsenceListEvent extends AbsenceListEvent {
  const FetchMoreAbsenceListEvent({
    this.selectedAbsenceType = '',
    this.selectedDateTime = '',
  });

  final String selectedAbsenceType;
  final String selectedDateTime;

  @override
  List<Object?> get props => [
    selectedAbsenceType,
    selectedDateTime,
  ];
}

final class FetchUserListEvent extends AbsenceListEvent {
  const FetchUserListEvent();

  @override
  List<Object?> get props => [];
}
