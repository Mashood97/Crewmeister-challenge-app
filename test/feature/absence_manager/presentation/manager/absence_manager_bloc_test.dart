import 'package:absence_manager_app/core/usecase/usecase.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart';
import 'package:absence_manager_app/feature/absence_manager/presentation/manager/absence_list_bloc/absence_list_bloc.dart';
import 'package:absence_manager_app/utils/extensions/string_extensions.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_mock_helper.mocks.dart';

void main() async {
  late MockFetchAbsenceListUseCase mockFetchAbsenceListUseCase;
  late MockFetchUserListUseCase mockFetchUserListUseCase;
  late MockAbsenceManagerRepository mockAbsenceManagerRepository;

  late AbsenceListBloc bloc;

  setUp(() {
    mockAbsenceManagerRepository = MockAbsenceManagerRepository();

    mockFetchAbsenceListUseCase = MockFetchAbsenceListUseCase();
    mockFetchUserListUseCase = MockFetchUserListUseCase();
    bloc = AbsenceListBloc(
      fetchUserListUseCase: mockFetchUserListUseCase,
      absenceListUseCase: mockFetchAbsenceListUseCase,
    );

    /// Absence List Implementation
    ///  Stub the fetch absence list method from repository.
    when(mockAbsenceManagerRepository.fetchAbsenceList()).thenAnswer(
      (_) async => const Right(
        [
          AbsenceResponseEntity(
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
          AbsenceResponseEntity(
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
        ],
      ),
    );

    /// Stub the fetch absence list use case method

    when(mockFetchAbsenceListUseCase.call(NoParams())).thenAnswer(
      (_) async => const Right(
        [
          AbsenceResponseEntity(
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
          AbsenceResponseEntity(
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
        ],
      ),
    );

    /// User List Implementation
    ///  Stub the fetch user list method from repository.
    when(mockAbsenceManagerRepository.fetchUserList()).thenAnswer(
      (_) async => const Right(
        [
          UserResponseEntity(
            userId: 1001,
            userName: 'Max',
          ),
          UserResponseEntity(
            userId: 1003,
            userName: 'Mashood',
          ),
        ],
      ),
    );

    /// Stub the fetch user list use case method

    when(mockFetchUserListUseCase.call(NoParams())).thenAnswer(
      (_) async => const Right([
        UserResponseEntity(
          userId: 1001,
          userName: 'Max',
        ),
        UserResponseEntity(
          userId: 1003,
          userName: 'Mashood',
        ),
      ]),
    );
  });

  tearDown(() {
    bloc.close();
  });

  const absenceList = <AbsenceResponseEntity>[
    AbsenceResponseEntity(
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
    AbsenceResponseEntity(
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

  const userList = <UserResponseEntity>[
    UserResponseEntity(
      userId: 1001,
      userName: 'Max',
    ),
    UserResponseEntity(
      userId: 1003,
      userName: 'Mashood',
    ),
  ];

  /// Test initial state of a bloc.
  test('bloc initial state is empty', () {
    expect(
      bloc.state,
      const AbsenceListInitial(
        userMap: {},
        absenceList: [],
        absenceTypeList: [],
      ),
    );
  });

  ///Absence List Bloc Test

  blocTest<AbsenceListBloc, AbsenceListState>(
    'emits [Loading, Loaded] when fetch absence List is successful',
    build: () => bloc,
    act: (_) {
      return bloc.add(
        const FetchAbsenceListEvent(),
      );
    },
    expect: () => [
      const AbsenceListLoading(
        absenceTypeList: [],
        absenceList: [],
        userMap: {},
        hasMore: true,
      ),
      AbsenceListLoaded(
        absenceList: absenceList,
        selectedAbsenceTypeFilter: absenceList.first.absenceType ?? '',
        absenceTypeList:
            absenceList.map((data) => data.absenceType ?? '').toSet().toList(),
        userMap: {},
      ),
    ],
    verify: (_) {
      verify(mockFetchAbsenceListUseCase.call(NoParams())).called(1);
    },
  );

  /// User List Bloc Test
  blocTest<AbsenceListBloc, AbsenceListState>(
    'emits [Loading, Loaded] when fetch user List is successful',
    build: () => bloc,
    seed: () => AbsenceListLoaded(
      absenceList: absenceList,
      selectedAbsenceTypeFilter: absenceList.first.absenceType ?? '',
      absenceTypeList:
          absenceList.map((data) => data.absenceType ?? '').toSet().toList(),
      userMap: {},
      hasMore: true,
    ),
    act: (_) {
      return bloc.add(const FetchUserListEvent());
    },
    expect: () {
      final userMap = <int, String>{};

      for (final user in userList) {
        if (user.userId != null &&
            user.userName?.isTextNotNullAndNotEmpty == true) {
          userMap[user.userId ?? -1] = user.userName ?? '-';
        }
      }
      return [
        AbsenceListLoading(
          selectedAbsenceTypeFilter: absenceList.first.absenceType ?? '',
          absenceTypeList: absenceList
              .map((data) => data.absenceType ?? '')
              .toSet()
              .toList(),
          absenceList: absenceList,
          userMap: const {},
        ),
        AbsenceListLoaded(
          absenceList: absenceList,
          selectedAbsenceTypeFilter: absenceList.first.absenceType ?? '',
          absenceTypeList: absenceList
              .map((data) => data.absenceType ?? '')
              .toSet()
              .toList(),
          userMap: userMap,
        ),
      ];
    },
    verify: (_) {
      verify(mockFetchUserListUseCase.call(NoParams())).called(1);
    },
  );
}
