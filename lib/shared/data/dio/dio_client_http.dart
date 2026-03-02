import 'package:dio/dio.dart';

import 'package:service_orders_app/shared/data/interceptors/functions/dio_auth_interceptor.dart';

abstract class IHttpCharacterClient {
  Future login({required String endpoint, required Map<String, dynamic> data});
  Future signUp({required String endpoint, required Map<String, dynamic> data});
  Future getServiceOrders({required String endpoint});
  Future getServiceOrderById({required String endpoint});
  Future updateServiceOrder({
    required String endpoint,
    required Map<String, dynamic> data,
  });
}

class DioClientHttp implements IHttpCharacterClient {
  Dio dio = Dio();

  DioClientHttp({Interceptor? interceptors}) {
    dio.options.baseUrl = "https://serviceordersapi.onrender.com";

    dio.interceptors.add(DioAuthInterceptor());

    if (interceptors != null) {
      dio.interceptors.add(interceptors);
    }
  }

  @override
  Future<Response?> login({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<Response?> signUp({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<Response?> getServiceOrders({required String endpoint}) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<Response?> updateServiceOrder({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Response _handleDioError(DioException e) {
    return Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: e.response?.statusCode ?? 500,
      data: {'error': e.message},
    );
  }

  @override
  Future<Response> getServiceOrderById({required String endpoint}) async {
    return dio.get(endpoint);
  }
}
