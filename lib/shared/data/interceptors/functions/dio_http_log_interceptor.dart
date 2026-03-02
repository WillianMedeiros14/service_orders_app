import 'dart:async';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

class DioHttpLogInterceptor extends Interceptor {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.t("Requisição para: ${options.baseUrl}\n${options.data}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.t(
      "Resposta de ${response.requestOptions.path}\n${response.headers}\n${response.statusCode}\n ${response.data}",
    );
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e(
      "Resposta de ${err.requestOptions.path}\n${err.response?.headers}\n${err.response?.statusCode}\n ${err.response?.data}",
    );
  }
}
