import 'package:flutter/material.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

Color getStatusColor(String status) {
  switch (status) {
    case "OPEN":
      return AppColors.primary;
    case "IN_PROGRESS":
      return AppColors.inProgress;
    case "FINISHED":
      return AppColors.completed;
    default:
      return Colors.grey;
  }
}
