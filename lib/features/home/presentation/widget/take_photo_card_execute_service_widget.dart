import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class TakePhotoCardExecuteServiceWidget extends StatelessWidget {
  final VoidCallback onTap;

  const TakePhotoCardExecuteServiceWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [10, 5],
          strokeWidth: 2,
          radius: Radius.circular(16),
          color: AppColors.primary,
        ),

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F9FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tirar Foto',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Registre evidências do serviço',
                style: TextStyle(fontSize: 13, color: Color(0xFF7B8AA5)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
