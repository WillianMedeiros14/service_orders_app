// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_service_by_id_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpdateOrderServiceByStore on _UpdateOrderServiceByStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_UpdateOrderServiceByStore.isLoading',
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

  late final _$errorAtom = Atom(
    name: '_UpdateOrderServiceByStore.error',
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

  late final _$updateServiceOrderAsyncAction = AsyncAction(
    '_UpdateOrderServiceByStore.updateServiceOrder',
    context: context,
  );

  @override
  Future<Response<dynamic>> updateServiceOrder({
    required String orderId,
    required ServiceOrderUpdateModel data,
  }) {
    return _$updateServiceOrderAsyncAction.run(
      () => super.updateServiceOrder(orderId: orderId, data: data),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
