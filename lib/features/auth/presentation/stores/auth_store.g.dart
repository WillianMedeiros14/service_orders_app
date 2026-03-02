// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$userAtom = Atom(name: '_AuthStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingCepAtom = Atom(
    name: '_AuthStore.isLoadingCep',
    context: context,
  );

  @override
  bool get isLoadingCep {
    _$isLoadingCepAtom.reportRead();
    return super.isLoadingCep;
  }

  @override
  set isLoadingCep(bool value) {
    _$isLoadingCepAtom.reportWrite(value, super.isLoadingCep, () {
      super.isLoadingCep = value;
    });
  }

  late final _$isLoadingTokenAtom = Atom(
    name: '_AuthStore.isLoadingToken',
    context: context,
  );

  @override
  bool get isLoadingToken {
    _$isLoadingTokenAtom.reportRead();
    return super.isLoadingToken;
  }

  @override
  set isLoadingToken(bool value) {
    _$isLoadingTokenAtom.reportWrite(value, super.isLoadingToken, () {
      super.isLoadingToken = value;
    });
  }

  late final _$isLoggedAtom = Atom(
    name: '_AuthStore.isLogged',
    context: context,
  );

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    '_AuthStore.login',
    context: context,
  );

  @override
  Future<bool?> login(LoginModel dataLogin) {
    return _$loginAsyncAction.run(() => super.login(dataLogin));
  }

  late final _$signUpAsyncAction = AsyncAction(
    '_AuthStore.signUp',
    context: context,
  );

  @override
  Future<bool?> signUp(SignUpModel dataSignUp) {
    return _$signUpAsyncAction.run(() => super.signUp(dataSignUp));
  }

  late final _$saveUserDataAsyncAction = AsyncAction(
    '_AuthStore.saveUserData',
    context: context,
  );

  @override
  Future<bool> saveUserData(String token, String userName) {
    return _$saveUserDataAsyncAction.run(
      () => super.saveUserData(token, userName),
    );
  }

  late final _$logOutAsyncAction = AsyncAction(
    '_AuthStore.logOut',
    context: context,
  );

  @override
  Future<void> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  late final _$verifyTokenAsyncAction = AsyncAction(
    '_AuthStore.verifyToken',
    context: context,
  );

  @override
  Future<dynamic> verifyToken() {
    return _$verifyTokenAsyncAction.run(() => super.verifyToken());
  }

  @override
  String toString() {
    return '''
user: ${user},
isLoading: ${isLoading},
isLoadingCep: ${isLoadingCep},
isLoadingToken: ${isLoadingToken},
isLogged: ${isLogged}
    ''';
  }
}
