import 'package:service_orders_app/features/auth/data/model/login_model.dart';
import 'package:service_orders_app/features/auth/data/model/signUp_model.dart';

abstract class IAuthRepository {
  Future login({required LoginModel dataLogin});
  Future signUp({required SignUpModel dataSignUp});
}
