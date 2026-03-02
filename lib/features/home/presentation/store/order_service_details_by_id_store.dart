import 'package:mobx/mobx.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';

import 'package:service_orders_app/features/home/data/repositories/i_order_service_store_depository.dart';
import 'package:service_orders_app/shared/errors/exceptions.dart';

part 'order_service_details_by_id_store.g.dart';

class OrderServiceDetailsByIdStore = _OrderServiceDetailsByIdStore
    with _$OrderServiceDetailsByIdStore;

abstract class _OrderServiceDetailsByIdStore with Store {
  final IOrderServiceRepository repository;

  _OrderServiceDetailsByIdStore({required this.repository});

  @observable
  bool isLoading = false;

  @observable
  ServiceOrderDetailsModel? state;

  @observable
  String error = '';

  @action
  Future<void> getServiceOrderById({required String orderId}) async {
    isLoading = true;
    error = '';

    try {
      final result = await repository.getServiceOrderById(orderId: orderId);

      state = result;
    } on NotFoundException catch (e) {
      print("rro");
      print(e);
      error = e.message;
    } catch (e) {
      print("rro");
      print(e);
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
