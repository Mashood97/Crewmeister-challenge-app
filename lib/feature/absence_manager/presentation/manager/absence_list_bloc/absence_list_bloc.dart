import 'dart:async';

import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
        final eventAbsenceType = event.selectedAbsenceType;
        if (eventAbsenceType.isNotEmpty) {
          absenceList = absenceList
              .where(
                (absence) =>
                    absence.absenceType?.toLowerCase() ==
                    eventAbsenceType.toLowerCase(),
              )
              .toList();
        }

        if (event.selectedDateTime.isNotEmpty) {
          final userSelectedDateTime = DateTime.parse(event.selectedDateTime);

          absenceList = absenceList.where(
            (absence) {
              final createdAt = DateTime.parse(
                absence.createdAt ?? DateTime.now().toString(),
              );

              return createdAt.year == userSelectedDateTime.year &&
                  createdAt.month == userSelectedDateTime.month &&
                  createdAt.day == userSelectedDateTime.day;
            },
          ).toList();
        }

        // **Pagination Logic: Load only 10 items**
        final paginatedList = absenceList.take(10).toList(); // First 10 items

        return emitter(
          AbsenceListLoaded(
            absenceList: paginatedList,
            selectedAbsenceTypeFilter:
                eventAbsenceType.isEmpty && success.isNotEmpty
                    ? success.first.absenceType ?? ''
                    : eventAbsenceType,
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
          selectedDateFilter: state.selectedDateFilter,
          selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
          errorMessage: error.errorStatus,
          hasFiltersApplied: state.hasFiltersApplied,
          userMap: state.userMap,
          currentPage: state.currentPage,
        ),
      ),
      (success) {
        final remainingItems = success.skip(state.absenceList.length).toList();
        var newItems = remainingItems.take(10).toList();

        final eventAbsenceType = state.selectedAbsenceTypeFilter;
        if (eventAbsenceType.isNotEmpty) {
          newItems = newItems
              .where(
                (absence) =>
                    absence.absenceType?.toLowerCase() ==
                    eventAbsenceType.toLowerCase(),
              )
              .toList();
        }

        if (state.selectedDateFilter.isNotEmpty) {
          final userSelectedDateTime = DateTime.parse(state.selectedDateFilter);

          newItems = newItems.where(
            (absence) {
              final createdAt = DateTime.parse(
                absence.createdAt ?? DateTime.now().toString(),
              );

              return createdAt.year == userSelectedDateTime.year &&
                  createdAt.month == userSelectedDateTime.month &&
                  createdAt.day == userSelectedDateTime.day;
            },
          ).toList();
        }

        emitter(
          AbsenceListLoaded(
            absenceList: [...state.absenceList, ...newItems],
            absenceTypeList: state.absenceTypeList,
            selectedAbsenceTypeFilter: state.selectedAbsenceTypeFilter,
            selectedDateFilter: state.selectedDateFilter,
            hasFiltersApplied: state.hasFiltersApplied,
            userMap: state.userMap,
            hasMore: remainingItems.length > 10,
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
