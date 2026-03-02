import 'package:dio/dio.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';
import 'package:service_orders_app/features/home/data/model/service_order_model.dart';
import 'package:service_orders_app/features/home/data/model/service_order_update_model%20.dart';

abstract class IOrderServiceRepository {
  Future<List<ServiceOrderModel>> getServiceOrders();
  Future<ServiceOrderDetailsModel> getServiceOrderById({
    required String orderId,
  });
  Future<Response<dynamic>> updateServiceOrder({
    required String orderId,
    required ServiceOrderUpdateModel data,
  });
}
