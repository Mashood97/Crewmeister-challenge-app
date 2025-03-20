part of 'absence_list_bloc.dart';

abstract class AbsenceListState extends Equatable {
  const AbsenceListState({
    required this.absenceList,
    required this.userMap,
  });

  final List<AbsenceResponseEntity> absenceList;
  final Map<int, String> userMap; // Maps userID -> userName
}

class AbsenceListInitial extends AbsenceListState {
  const AbsenceListInitial({
    required super.absenceList,
    required super.userMap,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
      ];
}

class AbsenceListLoading extends AbsenceListState {
  const AbsenceListLoading({
    required super.absenceList,
    required super.userMap,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
      ];
}

class AbsenceListLoaded extends AbsenceListState {
  const AbsenceListLoaded({
    required super.absenceList,
    required super.userMap,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
      ];
}

class AbsenceListFailure extends AbsenceListState {
  const AbsenceListFailure({
    required super.absenceList,
    required this.errorMessage,
    required super.userMap,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        errorMessage,
      ];
}
