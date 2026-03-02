import 'package:service_orders_app/features/auth/data/model/login_model.dart';
import 'package:service_orders_app/features/auth/data/model/login_response_model.dart';
import 'package:service_orders_app/features/auth/data/model/signUp_model.dart';
import 'package:service_orders_app/features/auth/data/repositories/i_auth_repository.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';

class AuthRepository implements IAuthRepository {
  final IHttpCharacterClient client;

  AuthRepository({required this.client});

  @override
  Future<LoginResponseModel?> login({required LoginModel dataLogin}) async {
    final response = await client.login(
      endpoint: "/auth/login",
      data: dataLogin.toJson(),
    );

    if (response.statusCode == 200) {
      final body = response.data;

      final LoginResponseModel dataLoginResponse = LoginResponseModel.fromMap(
        body,
      );

      return dataLoginResponse;
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponseModel?> signUp({required SignUpModel dataSignUp}) async {
    final response = await client.signUp(
      endpoint: "/auth/register/technician",
      data: dataSignUp.toJson(),
    );

    if (response.statusCode == 200) {
      final body = response.data;

      final LoginResponseModel dataLoginResponse = LoginResponseModel.fromMap(
        body,
      );

      return dataLoginResponse;
    } else if (response.statusCode == 404) {
      print(response);
      return null;
    } else {
      print(response);
      return null;
    }
  }
}
