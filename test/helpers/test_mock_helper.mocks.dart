// Mocks generated by Mockito 5.4.4 from annotations
// in absence_manager_app/test/helpers/test_mock_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:absence_manager_app/core/error/response_error.dart' as _i6;
import 'package:absence_manager_app/core/usecase/usecase.dart' as _i8;
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/absence_response_model.dart'
    as _i12;
import 'package:absence_manager_app/feature/absence_manager/data/models/response_model/user_response_model.dart'
    as _i13;
import 'package:absence_manager_app/feature/absence_manager/data/remote/data_sources/absence_manager_remote_data_source.dart'
    as _i11;
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/absence_response_entity.dart'
    as _i7;
import 'package:absence_manager_app/feature/absence_manager/domain/entities/response_entity/user_response_entity.dart'
    as _i10;
import 'package:absence_manager_app/feature/absence_manager/domain/repositories/absence_manager_repository.dart'
    as _i2;
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_absence_list_usecase.dart'
    as _i4;
import 'package:absence_manager_app/feature/absence_manager/domain/use_cases/fetch_user_list_usecase.dart'
    as _i9;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAbsenceManagerRepository_0 extends _i1.SmartFake
    implements _i2.AbsenceManagerRepository {
  _FakeAbsenceManagerRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FetchAbsenceListUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchAbsenceListUseCase extends _i1.Mock
    implements _i4.FetchAbsenceListUseCase {
  @override
  _i2.AbsenceManagerRepository get absenceManagerRepository =>
      (super.noSuchMethod(
        Invocation.getter(#absenceManagerRepository),
        returnValue: _FakeAbsenceManagerRepository_0(
          this,
          Invocation.getter(#absenceManagerRepository),
        ),
        returnValueForMissingStub: _FakeAbsenceManagerRepository_0(
          this,
          Invocation.getter(#absenceManagerRepository),
        ),
      ) as _i2.AbsenceManagerRepository);

  @override
  _i5.Future<
      _i3.Either<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i7.AbsenceResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i7.AbsenceResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<
          _i3.Either<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>>);
}

/// A class which mocks [FetchUserListUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFetchUserListUseCase extends _i1.Mock
    implements _i9.FetchUserListUseCase {
  @override
  _i2.AbsenceManagerRepository get absenceManagerRepository =>
      (super.noSuchMethod(
        Invocation.getter(#absenceManagerRepository),
        returnValue: _FakeAbsenceManagerRepository_0(
          this,
          Invocation.getter(#absenceManagerRepository),
        ),
        returnValueForMissingStub: _FakeAbsenceManagerRepository_0(
          this,
          Invocation.getter(#absenceManagerRepository),
        ),
      ) as _i2.AbsenceManagerRepository);

  @override
  _i5.Future<_i3.Either<_i6.ResponseError, List<_i10.UserResponseEntity>>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i10.UserResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i10.UserResponseEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i10.UserResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i10.UserResponseEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<
          _i3.Either<_i6.ResponseError, List<_i10.UserResponseEntity>>>);
}

/// A class which mocks [AbsenceManagerRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbsenceManagerRepository extends _i1.Mock
    implements _i2.AbsenceManagerRepository {
  @override
  _i5.Future<
      _i3.Either<_i6.ResponseError,
          List<_i7.AbsenceResponseEntity>>> fetchAbsenceList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAbsenceList,
          [],
        ),
        returnValue: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i7.AbsenceResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>(
          this,
          Invocation.method(
            #fetchAbsenceList,
            [],
          ),
        )),
        returnValueForMissingStub: _i5.Future<
                _i3.Either<_i6.ResponseError,
                    List<_i7.AbsenceResponseEntity>>>.value(
            _FakeEither_1<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>(
          this,
          Invocation.method(
            #fetchAbsenceList,
            [],
          ),
        )),
      ) as _i5.Future<
          _i3.Either<_i6.ResponseError, List<_i7.AbsenceResponseEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.ResponseError, List<_i10.UserResponseEntity>>>
      fetchUserList() => (super.noSuchMethod(
            Invocation.method(
              #fetchUserList,
              [],
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i6.ResponseError,
                        List<_i10.UserResponseEntity>>>.value(
                _FakeEither_1<_i6.ResponseError, List<_i10.UserResponseEntity>>(
              this,
              Invocation.method(
                #fetchUserList,
                [],
              ),
            )),
            returnValueForMissingStub: _i5.Future<
                    _i3.Either<_i6.ResponseError,
                        List<_i10.UserResponseEntity>>>.value(
                _FakeEither_1<_i6.ResponseError, List<_i10.UserResponseEntity>>(
              this,
              Invocation.method(
                #fetchUserList,
                [],
              ),
            )),
          ) as _i5.Future<
              _i3.Either<_i6.ResponseError, List<_i10.UserResponseEntity>>>);
}

/// A class which mocks [AbsenceManagerRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAbsenceManagerRemoteDataSource extends _i1.Mock
    implements _i11.AbsenceManagerRemoteDataSource {
  @override
  _i5.Future<List<_i12.AbsenceResponseModel>> fetchAbsenceListFromServer() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAbsenceListFromServer,
          [],
        ),
        returnValue: _i5.Future<List<_i12.AbsenceResponseModel>>.value(
            <_i12.AbsenceResponseModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i12.AbsenceResponseModel>>.value(
                <_i12.AbsenceResponseModel>[]),
      ) as _i5.Future<List<_i12.AbsenceResponseModel>>);

  @override
  _i5.Future<List<_i13.UserResponseModel>> fetchUserListFromServer() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserListFromServer,
          [],
        ),
        returnValue: _i5.Future<List<_i13.UserResponseModel>>.value(
            <_i13.UserResponseModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i13.UserResponseModel>>.value(
                <_i13.UserResponseModel>[]),
      ) as _i5.Future<List<_i13.UserResponseModel>>);
}
