class ChecklistItemModel {
  final String id;
  final String description;
  final bool isRequired;

  ChecklistItemModel({
    required this.id,
    required this.description,
    required this.isRequired,
  });

  factory ChecklistItemModel.fromMap(Map<String, dynamic> map) {
    return ChecklistItemModel(
      id: map['id'],
      description: map['description'],
      isRequired: map['isRequired'],
    );
  }
}
