import 'package:dio/dio.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';
import 'package:service_orders_app/features/home/data/model/service_order_model.dart';
import 'package:service_orders_app/features/home/data/model/service_order_update_model%20.dart';
import 'package:service_orders_app/features/home/data/repositories/i_order_service_store_depository.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';
import 'package:service_orders_app/shared/errors/exceptions.dart';

class OrderRepository implements IOrderServiceRepository {
  final IHttpCharacterClient client;

  OrderRepository({required this.client});

  @override
  Future<List<ServiceOrderModel>> getServiceOrders() async {
    final response = await client.getServiceOrders(endpoint: "/service-orders");

    if (response.statusCode == 200) {
      final body = response.data;

      final List<ServiceOrderModel> orders = (body['data'] as List).map((item) {
        return ServiceOrderModel.fromMap(item);
      }).toList();

      return orders;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar as informações');
    }
  }

  @override
  Future<ServiceOrderDetailsModel> getServiceOrderById({
    required String orderId,
  }) async {
    final response = await client.getServiceOrderById(
      endpoint: '/service-orders/$orderId',
    );

    if (response.statusCode == 200) {
      final body = response.data;

      final ServiceOrderDetailsModel order = ServiceOrderDetailsModel.fromMap(
        body,
      );

      return order;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar os dados');
    }
  }

  @override
  Future<Response<dynamic>> updateServiceOrder({
    required String orderId,
    required ServiceOrderUpdateModel data,
  }) async {
    return await client.updateServiceOrder(
      endpoint: '/service-orders/$orderId/execute',
      data: data.toJson(),
    );
  }

  @override
  Future<String> uploadServiceOrderPhoto({
    required String orderId,
    required String filePath,
  }) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath, filename: 'photo.jpg'),
    });

    final response = await client.uploadServiceOrderPhoto(
      endpoint: '/service-orders/$orderId/photo',
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data['photoUrl'];
    } else {
      throw Exception('Erro ao enviar foto');
    }
  }
}
