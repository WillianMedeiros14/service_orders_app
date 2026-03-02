import 'package:service_orders_app/features/home/data/model/service_order_checklist_item_model.dart';
import 'package:service_orders_app/features/home/data/model/technician_model.dart';

class ServiceOrderDetailsModel {
  final String id;
  final String title;
  final String problemDescription;
  final String? executionDescription;
  final String status;
  final DateTime createdAt;
  final DateTime? finishedAt;
  final String? photoPath;
  final String createdByUserId;
  final String technicianId;
  final TechnicianModel technician;
  final List<ServiceOrderChecklistItemModel> checklistItems;

  ServiceOrderDetailsModel({
    required this.id,
    required this.title,
    required this.problemDescription,
    required this.executionDescription,
    required this.status,
    required this.createdAt,
    required this.finishedAt,
    required this.photoPath,
    required this.createdByUserId,
    required this.technicianId,
    required this.technician,
    required this.checklistItems,
  });

  factory ServiceOrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return ServiceOrderDetailsModel(
      id: map['id'],
      title: map['title'],
      problemDescription: map['problemDescription'],
      executionDescription: map['executionDescription'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
      finishedAt: map['finishedAt'] != null
          ? DateTime.parse(map['finishedAt'])
          : null,
      photoPath: map['photoPath'],
      createdByUserId: map['createdByUserId'],
      technicianId: map['technicianId'],
      technician: TechnicianModel.fromMap(map['technician']),
      checklistItems: (map['checklistItems'] as List)
          .map((e) => ServiceOrderChecklistItemModel.fromMap(e))
          .toList(),
    );
  }
}
