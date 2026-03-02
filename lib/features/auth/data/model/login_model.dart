class LoginModel {
  String username;
  String password;

  LoginModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {'usename': username, 'password': password};
  }

  bool isValid() {
    return username.isNotEmpty && password.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
