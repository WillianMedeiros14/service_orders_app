import 'package:flutter/material.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

enum ButtonWidgetType { primary, secondary }

class ButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final ButtonWidgetType type;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.type = ButtonWidgetType.primary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = type == ButtonWidgetType.primary;

    final Color backgroundColor = isPrimary
        ? AppColors.primary
        : AppColors.secondaryButton;

    final Color textColor = isPrimary ? Colors.white : const Color(0xFF2E3A59);

    final Color iconColor = textColor;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon, color: iconColor),
        label: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
