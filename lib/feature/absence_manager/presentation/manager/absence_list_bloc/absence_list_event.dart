part of 'absence_list_bloc.dart';

sealed class AbsenceListEvent extends Equatable {
  const AbsenceListEvent();
}

final class FetchAbsenceListEvent extends AbsenceListEvent {
  const FetchAbsenceListEvent();

  @override
  List<Object?> get props => [];
}

final class FetchUserListEvent extends AbsenceListEvent {
  const FetchUserListEvent();

  @override
  List<Object?> get props => [];
}
