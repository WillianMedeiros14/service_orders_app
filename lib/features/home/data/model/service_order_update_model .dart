class ServiceOrderUpdateModel {
  String? executionDescription;
  String? photoPath;
  String status;
  List<ChecklistItemUpdateModel> checklistItems;

  ServiceOrderUpdateModel({
    this.executionDescription,
    this.photoPath,
    required this.status,
    required this.checklistItems,
  });

  Map<String, dynamic> toJson() {
    return {
      if (executionDescription != null)
        'executionDescription': executionDescription,
      if (photoPath != null) 'photoPath': photoPath,
      'status': status,
      'checklistItems': checklistItems.map((e) => e.toJson()).toList(),
    };
  }
}

class ChecklistItemUpdateModel {
  String serviceOrderChecklistId;
  bool isChecked;

  ChecklistItemUpdateModel({
    required this.serviceOrderChecklistId,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceOrderChecklistId': serviceOrderChecklistId,
      'isChecked': isChecked,
    };
  }
}
