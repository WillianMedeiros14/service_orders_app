class TechnicianModel {
  final String id;
  final String userName;

  TechnicianModel({required this.id, required this.userName});

  factory TechnicianModel.fromMap(Map<String, dynamic> map) {
    return TechnicianModel(id: map['id'], userName: map['userName']);
  }
}
