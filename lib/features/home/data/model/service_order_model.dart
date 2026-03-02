class ServiceOrderModel {
  final String id;
  final String title;
  final String problemDescription;
  final String status;
  final DateTime createdAt;
  final DateTime? finishedAt;

  ServiceOrderModel({
    required this.id,
    required this.title,
    required this.problemDescription,
    required this.status,
    required this.createdAt,
    this.finishedAt,
  });

  factory ServiceOrderModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderModel(
      id: map['id'] as String,
      title: map['title'] as String? ?? '',
      problemDescription: map['problemDescription'] as String,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      finishedAt: map['finishedAt'] != null
          ? DateTime.parse(map['finishedAt'])
          : null,
    );
  }
}
