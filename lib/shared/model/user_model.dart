class UserModel {
  final String id;
  final String userName;
  final String email;

  UserModel({required this.id, required this.userName, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      userName: map['userName'],
      email: map['email'],
    );
  }
}
