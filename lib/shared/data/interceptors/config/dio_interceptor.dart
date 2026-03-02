import 'package:dio/dio.dart';
import 'package:service_orders_app/shared/data/interceptors/functions/dio_http_log_interceptor.dart';

class DioInterceptors {
  final DioHttpLogInterceptor loggerInterceptor;

  DioInterceptors({required this.loggerInterceptor});

  Interceptor get dioInterceptors => InterceptorsWrapper(
    onRequest: (options, handler) {
      loggerInterceptor.onRequest(options, handler);
      return handler.next(options);
    },
    onResponse: (response, handler) {
      loggerInterceptor.onResponse(response, handler);
      return handler.next(response);
    },
    onError: (error, handler) {
      loggerInterceptor.onError(error, handler);
      return handler.next(error);
    },
  );
}
