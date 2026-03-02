import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_orders_app/features/auth/data/repositories/auth_repository.dart';
import 'package:service_orders_app/features/auth/presentation/stores/auth_store.dart';
import 'package:service_orders_app/features/myApp/presentation/pages/my_app.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';
import 'package:service_orders_app/shared/data/interceptors/config/dio_interceptor.dart';
import 'package:service_orders_app/shared/data/interceptors/functions/dio_http_log_interceptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loggerInterceptor = DioHttpLogInterceptor();
  final dioInterceptors = DioInterceptors(loggerInterceptor: loggerInterceptor);
  final dioClient = DioClientHttp(
    interceptors: dioInterceptors.dioInterceptors,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthStore>(
          create: (_) =>
              AuthStore(authRepository: AuthRepository(client: dioClient)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
