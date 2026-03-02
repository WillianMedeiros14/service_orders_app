// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service_details_by_id_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderServiceDetailsByIdStore on _OrderServiceDetailsByIdStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_OrderServiceDetailsByIdStore.isLoading',
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

  late final _$stateAtom = Atom(
    name: '_OrderServiceDetailsByIdStore.state',
    context: context,
  );

  @override
  ServiceOrderDetailsModel? get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ServiceOrderDetailsModel? value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorAtom = Atom(
    name: '_OrderServiceDetailsByIdStore.error',
    context: context,
  );

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$getServiceOrderByIdAsyncAction = AsyncAction(
    '_OrderServiceDetailsByIdStore.getServiceOrderById',
    context: context,
  );

  @override
  Future<void> getServiceOrderById({required String orderId}) {
    return _$getServiceOrderByIdAsyncAction.run(
      () => super.getServiceOrderById(orderId: orderId),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
state: ${state},
error: ${error}
    ''';
  }
}
