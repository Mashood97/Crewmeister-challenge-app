part of 'absence_list_bloc.dart';

abstract class AbsenceListState extends Equatable {
  const AbsenceListState({
    required this.absenceList,
    required this.userMap,
    required this.absenceTypeList,
    this.hasFiltersApplied = false,
    this.selectedAbsenceTypeFilter = '',
    this.selectedDateFilter = '',
    this.hasMore = false,
    this.currentPage = 1,
  });

  final List<AbsenceResponseEntity> absenceList;
  final Map<int, String> userMap; // Maps userID -> userName
  final List<String> absenceTypeList;
  final String selectedAbsenceTypeFilter;
  final String selectedDateFilter;
  final bool hasFiltersApplied;
  final bool hasMore;
  final int currentPage;
}

class AbsenceListInitial extends AbsenceListState {
  const AbsenceListInitial({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
    super.selectedDateFilter,
    super.currentPage,
    super.hasMore,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
        super.selectedDateFilter,
        super.currentPage,
        super.hasMore,
      ];
}

class AbsenceListLoading extends AbsenceListState {
  const AbsenceListLoading({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
    super.selectedDateFilter,
    super.currentPage,
    super.hasMore,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
        super.selectedDateFilter,
        super.currentPage,
        super.hasMore,
      ];
}

class AbsenceListLoaded extends AbsenceListState {
  const AbsenceListLoaded({
    required super.absenceList,
    required super.userMap,
    required super.absenceTypeList,
    super.hasFiltersApplied,
    super.selectedAbsenceTypeFilter,
    super.selectedDateFilter,
    super.currentPage,
    super.hasMore,
  });

  @override
  List<Object> get props => [
        super.absenceList,
        super.userMap,
        super.absenceTypeList,
        super.hasFiltersApplied,
        super.selectedAbsenceTypeFilter,
        super.selectedDateFilter,
        super.currentPage,
        super.hasMore,
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
    super.selectedDateFilter,
    super.currentPage,
    super.hasMore,
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
        super.selectedDateFilter,
        super.currentPage,
        super.hasMore,
      ];
}
