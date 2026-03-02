import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioAuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('accessToken');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      print("Token enviado no header: $token");
    } else {
      print("Nenhum token encontrado");
    }

    return handler.next(options);
  }
}
