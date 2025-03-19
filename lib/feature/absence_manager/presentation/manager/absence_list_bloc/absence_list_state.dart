part of 'absence_list_bloc.dart';

abstract class AbsenceListState extends Equatable {
  const AbsenceListState({
    required this.absenceList,
  });

  final List<AbsenceResponseEntity> absenceList;
}

class AbsenceListInitial extends AbsenceListState {
  const AbsenceListInitial({
    required super.absenceList,
  });

  @override
  List<Object> get props => [
        super.absenceList,
      ];
}

class AbsenceListLoading extends AbsenceListState {
  const AbsenceListLoading({
    required super.absenceList,
  });

  @override
  List<Object> get props => [
        super.absenceList,
      ];
}

class AbsenceListLoaded extends AbsenceListState {
  const AbsenceListLoaded({
    required super.absenceList,
  });

  @override
  List<Object> get props => [
        super.absenceList,
      ];
}

class AbsenceListFailure extends AbsenceListState {
  const AbsenceListFailure({
    required super.absenceList,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
        super.absenceList,
        errorMessage,
      ];
}
