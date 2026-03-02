import 'package:flutter/material.dart';

IconData getStatusIcon(String status) {
  switch (status) {
    case "OPEN":
      return Icons.description_outlined;
    case "IN_PROGRESS":
      return Icons.build_outlined;
    case "FINISHED":
      return Icons.check_circle_outline;
    default:
      return Icons.help_outline;
  }
}
