import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/user_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbsenceManagerRepository extends Mock
    implements AbsenceManagerRepository {}

void main() {
  late FetchUserListUseCase fetchUserListUseCase;
  late _MockAbsenceManagerRepository mockHomeRepository;

  setUp(() {
    //setup all objects here.
    mockHomeRepository = _MockAbsenceManagerRepository();
    fetchUserListUseCase = FetchUserListUseCase(
      absenceManagerRepository: mockHomeRepository,
    );
  });

  const userList = <UserResponseModel>[
    UserResponseModel(
      userId: 1001,
      userName: 'Max',
    ),
    UserResponseModel(
      userId: 1003,
      userName: 'Mashood',
    ),
  ];

  test('Should get user list from server', () async {
    when(
      () => mockHomeRepository.fetchUserList(),
    ).thenAnswer(
      (_) async => const Right(userList),
    );

    final result = await fetchUserListUseCase(NoParams());

    expect(
      result,
      const Right(
        userList,
      ),
    );

    verify(() => mockHomeRepository.fetchUserList());

    verifyNoMoreInteractions(mockHomeRepository);
  });
}
