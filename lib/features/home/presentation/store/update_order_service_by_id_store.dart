import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:service_orders_app/features/home/data/model/service_order_update_model%20.dart';

import 'package:service_orders_app/features/home/data/repositories/i_order_service_store_depository.dart';

part 'update_order_service_by_id_store.g.dart';

class UpdateOrderServiceByStore = _UpdateOrderServiceByStore
    with _$UpdateOrderServiceByStore;

abstract class _UpdateOrderServiceByStore with Store {
  final IOrderServiceRepository repository;

  _UpdateOrderServiceByStore({required this.repository});

  @observable
  bool isLoading = false;

  @observable
  String error = '';

  @action
  Future<Response<dynamic>> updateServiceOrder({
    required String orderId,
    required ServiceOrderUpdateModel data,
  }) async {
    isLoading = true;
    error = '';

    final result = await repository.updateServiceOrder(
      orderId: orderId,
      data: data,
    );
    isLoading = false;
    return result;
  }
}
