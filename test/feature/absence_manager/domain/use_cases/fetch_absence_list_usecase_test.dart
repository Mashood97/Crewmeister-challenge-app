import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbsenceManagerRepository extends Mock
    implements AbsenceManagerRepository {}

void main() {
  late FetchAbsenceListUseCase fetchAbsenceListUseCase;
  late _MockAbsenceManagerRepository mockHomeRepository;

  setUp(() {
    //setup all objects here.
    mockHomeRepository = _MockAbsenceManagerRepository();
    fetchAbsenceListUseCase = FetchAbsenceListUseCase(
      absenceManagerRepository: mockHomeRepository,
    );
  });

  const absenceList = <AbsenceResponseModel>[
    AbsenceResponseModel(
      userId: 5293,
      absenceEndDate: '2021-05-24',
      absenceStartDate: '2021-05-24',
      absenceType: 'vacation',
      admitterNote: '-',
      confirmedAt: '2021-05-22T08:50:28.000+02:00',
      createdAt: '2021-05-21T17:24:42.000+02:00',
      memberNote: '-',
      rejectedAt: null,
    ),
    AbsenceResponseModel(
      userId: 1002,
      absenceEndDate: '2021-05-26',
      absenceStartDate: '2021-05-26',
      absenceType: 'sickness',
      admitterNote: '-',
      confirmedAt: '2021-05-23T08:50:28.000+02:00',
      createdAt: '2021-05-21T17:24:42.000+02:00',
      memberNote: '-',
      rejectedAt: null,
    ),
  ];

  test('Should get absence list from server', () async {
    when(
      () => mockHomeRepository.fetchAbsenceList(),
    ).thenAnswer(
      (_) async => const Right(absenceList),
    );

    final result = await fetchAbsenceListUseCase(NoParams());

    expect(result, const Right(absenceList));

    verify(() => mockHomeRepository.fetchAbsenceList());

    verifyNoMoreInteractions(mockHomeRepository);
  });
}
