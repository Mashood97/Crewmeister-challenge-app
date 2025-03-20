part of 'absence_list_bloc.dart';

sealed class AbsenceListEvent extends Equatable {
  const AbsenceListEvent();
}

final class FetchAbsenceListEvent extends AbsenceListEvent {
  const FetchAbsenceListEvent({
    this.selectedAbsenceType = '',
  });

  final String selectedAbsenceType;

  @override
  List<Object?> get props => [
        selectedAbsenceType,
      ];
}

final class FetchUserListEvent extends AbsenceListEvent {
  const FetchUserListEvent();

  @override
  List<Object?> get props => [];
}
