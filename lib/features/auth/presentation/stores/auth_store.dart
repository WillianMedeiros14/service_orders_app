import 'package:mobx/mobx.dart';
import 'package:service_orders_app/features/auth/data/model/login_model.dart';
import 'package:service_orders_app/features/auth/data/model/signUp_model.dart';
import 'package:service_orders_app/features/auth/data/repositories/auth_repository.dart';
import 'package:service_orders_app/shared/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final AuthRepository authRepository;

  _AuthStore({required this.authRepository}) {
    verifyToken();
  }

  @observable
  UserModel? user;

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingCep = false;

  @observable
  bool isLoadingToken = true;

  @observable
  bool isLogged = false;

  @action
  Future<bool?> login(LoginModel dataLogin) async {
    isLoading = true;
    final result = await authRepository.login(dataLogin: dataLogin);
    isLoading = false;
    if (result != null) {
      bool isValueSavedToken = await saveUserData(
        result.token,
        result.user.userName,
      );

      user = result.user;

      if (isValueSavedToken) {
        isLogged = true;
      }

      return true;
    } else {
      return null;
    }
  }

  @action
  Future<bool?> signUp(SignUpModel dataSignUp) async {
    isLoading = true;
    final result = await authRepository.signUp(dataSignUp: dataSignUp);
    isLoading = false;
    if (result != null) {
      bool isValueSavedToken = await saveUserData(
        result.token,
        result.user.userName,
      );

      user = result.user;

      if (isValueSavedToken) {
        isLogged = true;
      }

      return true;
    } else {
      return false;
    }
  }

  @action
  Future<bool> saveUserData(String token, String userName) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      bool tokenSuccess = await sharedPreferences.setString(
        "accessToken",
        token,
      );
      bool userNameSuccess = await sharedPreferences.setString(
        "userName",
        userName,
      );

      if (tokenSuccess && userNameSuccess) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Erro ao tentar salvar os dados do usuário: $e");
      return false;
    }
  }

  @action
  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("accessToken");
    await sharedPreferences.remove("userName");
    isLogged = false;
  }

  @action
  Future verifyToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString('accessToken');
    String? userName = sharedPreferences.getString('userName');

    if (token != null && userName != null) {
      user = UserModel(userName: userName, id: '', email: '');
      isLogged = true;
    } else {
      isLogged = false;
    }

    isLoadingToken = false;
  }
}
