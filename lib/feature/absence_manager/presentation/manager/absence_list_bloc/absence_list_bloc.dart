import 'dart:async';

import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'absence_list_event.dart';

part 'absence_list_state.dart';

class AbsenceListBloc extends Bloc<AbsenceListEvent, AbsenceListState> {
  AbsenceListBloc({
    required this.absenceListUseCase,
  }) : super(
          const AbsenceListInitial(
            absenceList: [],
          ),
        ) {
    on<FetchAbsenceListEvent>(
      _fetchAbsenceList,
    );
  }

  final FetchAbsenceListUseCase absenceListUseCase;

  Future<void> _fetchAbsenceList(
    FetchAbsenceListEvent event,
    Emitter<AbsenceListState> emitter,
  ) async {
    emitter(
      AbsenceListLoading(
        absenceList: state.absenceList,
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
        ),
      ),
      (success) => emitter(
        AbsenceListLoaded(
          absenceList: success,
        ),
      ),
    );
  }
}
