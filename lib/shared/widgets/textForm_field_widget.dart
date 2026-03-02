import 'package:flutter/material.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String?>? onChanged;
  final int? maxLines;
  final bool isLoading;
  final IconData? prefixIcon;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.maxLines = 1,
    required this.onChanged,
    this.isLoading = false,
    required this.labelText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),

        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: hintText,

            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15.0,
            ),
            suffixIcon: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
