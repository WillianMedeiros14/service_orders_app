import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:service_orders_app/features/auth/presentation/pages/login_page.dart';
import 'package:service_orders_app/features/auth/presentation/stores/auth_store.dart';
import 'package:service_orders_app/features/bottomNavigation/presentation/pages/BottomNavigationBar.dart';
import 'package:service_orders_app/shared/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final loginStore = Provider.of<AuthStore>(context);

    return MaterialApp(
      theme: myTheme,
      home: Observer(
        builder: (_) {
          if (loginStore.isLogged) {
            return BottomNavigationScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
