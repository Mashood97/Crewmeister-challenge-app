import 'package:absence_manager_app/core/platform/network_information.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/user_response_model.dart';
import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart';
import 'package:absence_manager_app/feature/absence_manager/data/repositories/absence_manager_repository_implementation.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockAbsenceManagerRemoteDataSource extends Mock
    implements AbsenceManagerRemoteDataSource {}

void main() {
  late AbsenceManagerRepositoryImplementation
      absenceManagerRepositoryImplementation;
  late MockAbsenceManagerRemoteDataSource mockAbsenceManagerRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAbsenceManagerRemoteDataSource = MockAbsenceManagerRemoteDataSource();
    absenceManagerRepositoryImplementation =
        AbsenceManagerRepositoryImplementation(
      absenceManagerRemoteDataSource: mockAbsenceManagerRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestIfDeviceIsOnline(Function body) {
    group('Device is online', () {
      setUp(
        () {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        },
      );
      body();
    });
  }

  group('Get Absence List', () {
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

    const absenceEntity = absenceList;

    test('Should check if device is connected to internet...', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockAbsenceManagerRemoteDataSource.fetchAbsenceListFromServer(),
      ).thenAnswer((_) async => absenceList);

      await absenceManagerRepositoryImplementation.fetchAbsenceList();

      verify(() => mockNetworkInfo.isConnected);
    });

    runTestIfDeviceIsOnline(() {
      test(
        'Should return remote data when the call to remote data is success:',
        () async {
          when(() => mockAbsenceManagerRemoteDataSource
                  .fetchAbsenceListFromServer())
              .thenAnswer((_) async => absenceList);

          final result =
              await absenceManagerRepositoryImplementation.fetchAbsenceList();

          expect(
            result,
            equals(
              const Right(absenceEntity),
            ),
          );
        },
      );
    });
  });

  group('Get User List', () {
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

    const userEntity = userList;

    test('Should check if device is connected to internet...', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockAbsenceManagerRemoteDataSource.fetchUserListFromServer(),
      ).thenAnswer((_) async => userList);

      await absenceManagerRepositoryImplementation.fetchUserList();

      verify(() => mockNetworkInfo.isConnected);
    });

    runTestIfDeviceIsOnline(() {
      test(
        'Should return remote data when the call to remote data is success:',
        () async {
          when(() =>
                  mockAbsenceManagerRemoteDataSource.fetchUserListFromServer())
              .thenAnswer((_) async => userList);

          final result =
              await absenceManagerRepositoryImplementation.fetchUserList();

          expect(
            result,
            equals(
              const Right(
                userEntity,
              ),
            ),
          );
        },
      );
    });
  });
}
