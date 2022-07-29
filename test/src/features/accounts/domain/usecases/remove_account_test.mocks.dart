// Mocks generated by Mockito 5.2.0 from annotations
// in worknotes/test/src/features/accounts/domain/usecases/remove_account_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:ui' as _i8;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:objectid/objectid.dart' as _i7;
import 'package:worknotes/src/core/error/failure.dart' as _i5;
import 'package:worknotes/src/features/accounts/domain/entities/account.dart'
    as _i6;
import 'package:worknotes/src/features/accounts/domain/repositories/account_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AccountRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAccountRepository extends _i1.Mock implements _i3.AccountRepository {
  MockAccountRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Account>> add(_i6.Account? item) =>
      (super.noSuchMethod(Invocation.method(#add, [item]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Account>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Account>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Account>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Account>> remove(_i6.Account? item) =>
      (super.noSuchMethod(Invocation.method(#remove, [item]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Account>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Account>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Account>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Account>> update(
          int? index, _i6.Account? item) =>
      (super.noSuchMethod(Invocation.method(#update, [index, item]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Account>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Account>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Account>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Account>>> getAll() =>
      (super.noSuchMethod(Invocation.method(#getAll, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Account>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Account>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Account>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Account>> findById(
          _i7.ObjectId? objectId) =>
      (super.noSuchMethod(Invocation.method(#findById, [objectId]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Account>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Account>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Account>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Account>> findByName(String? name) =>
      (super.noSuchMethod(Invocation.method(#findByName, [name]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.Account>>.value(
                  _FakeEither_0<_i5.Failure, _i6.Account>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.Account>>);
  @override
  void addListener(_i8.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i8.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
