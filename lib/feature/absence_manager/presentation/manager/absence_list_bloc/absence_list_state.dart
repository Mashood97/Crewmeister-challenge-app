part of 'absence_list_bloc.dart';

abstract class AbsenceListState extends Equatable {
  const AbsenceListState({
    required this.absenceList,
    required this.userMap,
    required this.absenceTypeList,
    this.hasFiltersApplied = false,
    this.selectedAbsenceTypeFilter = '',
  });

  final List<AbsenceResponseEntity> absenceList;
  final Map<int, String> userMap; // Maps userID -> userName
  final List<String> absenceTypeList;
  final String selectedAbsenceTypeFilter;
  final bool hasFiltersApplied;
}

class AbsenceListInitial extends AbsenceListState {
  const AbsenceListInitial({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
      ];
}

class AbsenceListLoading extends AbsenceListState {
  const AbsenceListLoading({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
      ];
}

class AbsenceListLoaded extends AbsenceListState {
  const AbsenceListLoaded({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
      ];
}

class AbsenceListFailure extends AbsenceListState {
  const AbsenceListFailure({
    required super.absenceList,
    required super.absenceTypeList,
    required this.errorMessage,
    required super.userMap,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
  });

  final String errorMessage;

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        errorMessage,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
      ];
}
