import 'dart:async';

import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

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

  Future<void> _fetchAbsenceList(
    FetchAbsenceListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    emitter(
      AbsenceListLoading(
        absenceList: state.absenceList,
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
          errorMessage: error.errorStatus,
          userMap: state.userMap,
        ),
      ),
      (success) => emitter(
        AbsenceListLoaded(
          absenceList: success,
          userMap: state.userMap,
        ),
      ),
    );
  }

  Future<void> _fetchUserList(
    FetchUserListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    emitter(
      AbsenceListLoading(
        absenceList: state.absenceList,
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
            userMap: userMap,
          ),
        );
      },
    );
  }
}
