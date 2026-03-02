class SignUpModel {
  String username;
  String email;
  String password;
  String rePassword;

  SignUpModel({
    required this.username,
    required this.email,
    required this.password,
    required this.rePassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'rePassword': rePassword,
    };
  }

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      rePassword: json['rePassword'],
    );
  }
}
