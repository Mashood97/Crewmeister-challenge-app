import 'dart:async';

import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'absence_list_event.dart';

part 'absence_list_state.dart';

class AbsenceListBloc extends Bloc<AbsenceListEvent, AbsenceListState> {
  AbsenceListBloc({
    required this.absenceListUseCase,
    required this.fetchUserListUseCase,
  }) : super(
          const AbsenceListInitial(
            absenceList: [],
            userMap: {},
            absenceTypeList: [],
          ),
        ) {
    on<FetchAbsenceListEvent>(
      _fetchAbsenceList,
      transformer: sequential(),
    );

    on<FetchMoreAbsenceListEvent>(
      _fetchMoreAbsenceList,
      transformer: droppable(),
    );
    on<FetchUserListEvent>(
      _fetchUserList,
      transformer: sequential(),
    );
  }

  final FetchAbsenceListUseCase absenceListUseCase;
  final FetchUserListUseCase fetchUserListUseCase;

  final TextEditingController datePickerTextEditingController =
      TextEditingController();

  final ScrollController scrollController = ScrollController();

  void attachListenerToScrollController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      add(
        FetchMoreAbsenceListEvent(
          selectedDateTime: state.selectedDateFilter,
          selectedAbsenceType: state.selectedAbsenceTypeFilter,
        ),
      );
    }
  }

  Future<void> _fetchAbsenceList(
    FetchAbsenceListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    emitter(
      AbsenceListLoading(
        absenceList: const [],
        absenceTypeList: state.absenceTypeList,
        hasFiltersApplied: state.hasFiltersApplied,
        selectedDateFilter: state.selectedDateFilter,
        selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
        userMap: state.userMap,
        hasMore: true,
      ),
    );
    final response = await absenceListUseCase.call(
      NoParams(),
    );

    response.fold(
      (error) => emitter(
        AbsenceListFailure(
          absenceList: state.absenceList,
          absenceTypeList: state.absenceTypeList,
          selectedDateFilter: event.selectedDateTime,
          selectedAbsenceTypeFilter: event.selectedAbsenceType,
          errorMessage: error.errorStatus,
          hasFiltersApplied: state.hasFiltersApplied,
          userMap: state.userMap,
          hasMore: false,
          currentPage: state.currentPage,
        ),
      ),
      (success) {
        var absenceList = success;

        /// Filter by Absence Type

        if (event.selectedAbsenceType.isNotEmpty) {
          absenceList = _getFilterByAbsenceType(
            absenceList: absenceList,
            selectedAbsenceType: event.selectedAbsenceType,
          );
        }

        /// Filter by DateTime
        if (event.selectedDateTime.isNotEmpty) {
          absenceList = _getFilterByDateTime(
            absenceList: absenceList,
            selectedDateTime: event.selectedDateTime,
          );
        }

        // **Pagination Logic: Load only 10 items**
        final paginatedList = absenceList.take(10).toList(); // First 10 items

        return emitter(
          AbsenceListLoaded(
            absenceList: paginatedList,
            selectedAbsenceTypeFilter: event.selectedAbsenceType,
            // eventAbsenceType.isEmpty && success.isNotEmpty
            //     ? success.first.absenceType ?? ''
            //     : eventAbsenceType,
            hasFiltersApplied: event.selectedAbsenceType.isNotEmpty ||
                event.selectedDateTime.isNotEmpty,
            selectedDateFilter: event.selectedDateTime,
            absenceTypeList:
                success.map((data) => data.absenceType ?? '').toSet().toList(),
            userMap: state.userMap,
            // If more than 10, there’s more data
            hasMore: absenceList.length > 10,
            currentPage: state.currentPage,
          ),
        );
      },
    );
  }

  List<AbsenceResponseEntity> _getFilterByAbsenceType({
    required String selectedAbsenceType,
    required List<AbsenceResponseEntity> absenceList,
  }) {
    return absenceList
        .where(
          (absence) =>
              absence.absenceType?.toLowerCase() ==
              selectedAbsenceType.toLowerCase(),
        )
        .toList();
  }

  List<AbsenceResponseEntity> _getFilterByDateTime({
    required String selectedDateTime,
    required List<AbsenceResponseEntity> absenceList,
  }) {
    final result = selectedDateTime.split(',');
    final userSelectedStartDate = DateTime.parse(result.first);
    final userSelectedEndDate = DateTime.parse(result.last);

    //TODO: FIX THIS FILTER TO STOP REBUILDING ITEMS.
    return absenceList.where((absence) {
      final startDate = DateTime.parse(
          absence.absenceStartDate ?? DateTime.now().toIso8601String());
      final endDate = DateTime.parse(absence.absenceEndDate ??
          DateTime.now().add(const Duration(days: 5)).toIso8601String());

      // Check if the absence fully falls within the selected range
      return (startDate.isAfter(userSelectedStartDate)) &&
          (endDate.isBefore(userSelectedEndDate));
    }).toList();
  }

  String getPeriods({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return '${endDate.difference(startDate).inDays} Days';
  }

  /// **Handles Loading More Data**
  Future<void> _fetchMoreAbsenceList(
    FetchMoreAbsenceListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    if (!state.hasMore) return; // No more data to load

    final nextPage = state.currentPage + 1;
    final response = await absenceListUseCase.call(NoParams());

    response.fold(
      (error) => emitter(
        AbsenceListFailure(
          absenceList: state.absenceList,
          absenceTypeList: state.absenceTypeList,
          selectedDateFilter: event.selectedDateTime,
          selectedAbsenceTypeFilter: event.selectedAbsenceType,
          errorMessage: error.errorStatus,
          hasFiltersApplied: state.hasFiltersApplied,
          userMap: state.userMap,
          currentPage: state.currentPage,
        ),
      ),
      (success) {
        var filteredItems = success;

        /// Filter by Absence Type

        if (event.selectedAbsenceType.isNotEmpty) {
          filteredItems = _getFilterByAbsenceType(
            absenceList: filteredItems,
            selectedAbsenceType: event.selectedAbsenceType,
          );
        }

        /// Filter by DateTime
        if (event.selectedDateTime.isNotEmpty) {
          filteredItems = _getFilterByDateTime(
            absenceList: filteredItems,
            selectedDateTime: event.selectedDateTime,
          );
        }

        final remainingItems =
            filteredItems.skip(state.absenceList.length).toList();

        final newItems = remainingItems.take(10).toList();
        print("LENGTH ISSS ${remainingItems.length}");

        /// **Step 4: Check if we are actually adding new items**
        final hasMore = newItems.isNotEmpty &&
            !listEquals(
              state.absenceList,
              [
                ...state.absenceList,
                ...newItems,
              ],
            );

        emitter(
          AbsenceListLoaded(
            absenceList: [...state.absenceList, ...newItems],
            absenceTypeList: state.absenceTypeList,
            selectedDateFilter: event.selectedDateTime,
            selectedAbsenceTypeFilter: event.selectedAbsenceType,
            hasFiltersApplied: state.hasFiltersApplied,
            userMap: state.userMap,
            hasMore: hasMore,
            currentPage: nextPage,
          ),
        );
      },
    );
  }

  Future<void> _fetchUserList(
    FetchUserListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    emitter(
      AbsenceListLoading(
        absenceList: state.absenceList,
        absenceTypeList: state.absenceTypeList,
        hasFiltersApplied: state.hasFiltersApplied,
        selectedDateFilter: state.selectedDateFilter,
        selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
        userMap: state.userMap,
      ),
    );
    final response = await fetchUserListUseCase.call(
      NoParams(),
    );

    response.fold(
      (error) => emitter(
        AbsenceListFailure(
          absenceList: state.absenceList,
          hasFiltersApplied: state.hasFiltersApplied,
          selectedDateFilter: state.selectedDateFilter,
          absenceTypeList: state.absenceTypeList,
          selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
          errorMessage: error.errorStatus,
          userMap: state.userMap,
        ),
      ),
      (success) {
        final userMap = <int, String>{};

        for (final user in success) {
          if (user.userId != null && user.userName.isTextNotNullAndNotEmpty) {
            userMap[user.userId ?? -1] = user.userName ?? '-';
          }
        }
        return emitter(
          AbsenceListLoaded(
            absenceList: state.absenceList,
            absenceTypeList: state.absenceTypeList,
            selectedDateFilter: state.selectedDateFilter,
            hasFiltersApplied: state.hasFiltersApplied,
            selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
            userMap: userMap,
          ),
        );
      },
    );
  }
}
