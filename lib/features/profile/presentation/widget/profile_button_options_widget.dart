import 'package:flutter/material.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class ProfileButtonOptionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileButtonOptionsWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 73,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
