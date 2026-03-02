import 'package:service_orders_app/features/home/data/model/checklist_item_model.dart';

class ServiceOrderChecklistItemModel {
  final String id;
  final bool isChecked;
  final ChecklistItemModel checklistItem;

  ServiceOrderChecklistItemModel({
    required this.id,
    required this.isChecked,
    required this.checklistItem,
  });

  factory ServiceOrderChecklistItemModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderChecklistItemModel(
      id: map['id'],
      isChecked: map['isChecked'],
      checklistItem: ChecklistItemModel.fromMap(map['checklistItem']),
    );
  }
}
