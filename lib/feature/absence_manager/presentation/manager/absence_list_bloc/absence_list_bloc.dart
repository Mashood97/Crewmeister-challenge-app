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
import 'package:intl/intl.dart';

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
    on<FetchUserListEvent>(
      _fetchUserList,
      transformer: sequential(),
    );
  }

  final FetchAbsenceListUseCase absenceListUseCase;
  final FetchUserListUseCase fetchUserListUseCase;

  final TextEditingController datePickerTextEditingController =
      TextEditingController();

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
        return emitter(
          AbsenceListLoaded(
            absenceList: absenceList,
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
