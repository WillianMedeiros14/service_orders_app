import 'package:mobx/mobx.dart';
import 'package:service_orders_app/features/home/data/model/service_order_model.dart';
import 'package:service_orders_app/features/home/data/repositories/i_order_service_store_depository.dart';
import 'package:service_orders_app/shared/errors/exceptions.dart';

part 'order_service_store.g.dart';

class OrderServiceStore = _OrderServiceStore with _$OrderServiceStore;

abstract class _OrderServiceStore with Store {
  final IOrderServiceRepository repository;

  _OrderServiceStore({required this.repository});

  @observable
  bool isLoading = false;

  @observable
  List<ServiceOrderModel> state = ObservableList<ServiceOrderModel>();

  @observable
  String error = '';

  @action
  Future<void> getServiceOrders() async {
    isLoading = true;
    error = '';

    try {
      final result = await repository.getServiceOrders();

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
