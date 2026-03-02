import 'package:flutter/material.dart';
import 'package:service_orders_app/features/home/presentation/pages/service_order_details_page.dart';
import 'package:service_orders_app/features/home/presentation/utils/get_status_color.dart';
import 'package:service_orders_app/features/home/presentation/utils/get_status_icon.dart';
import 'package:service_orders_app/features/home/presentation/utils/get_status_label.dart';

class ServiceOrderCardWidget extends StatelessWidget {
  final String status;
  final String title;
  final String orderId;

  const ServiceOrderCardWidget({
    super.key,
    required this.status,
    required this.title,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = getStatusColor(status);
    final IconData icon = getStatusIcon(status);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceOrderDetailsPage(orderId: orderId),
          ),
        ),
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: statusColor),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          getStatusLabel(status),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(title, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
