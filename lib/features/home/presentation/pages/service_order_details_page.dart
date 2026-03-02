import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';
import 'package:service_orders_app/features/home/data/repositories/order_service_store_depository.dart';
import 'package:service_orders_app/features/home/presentation/pages/finalize_service_order_page.dart';
import 'package:service_orders_app/features/home/presentation/store/order_service_details_by_id_store.dart';
import 'package:service_orders_app/features/home/presentation/utils/get_status_color.dart';
import 'package:service_orders_app/features/home/presentation/utils/get_status_label.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';
import 'package:service_orders_app/shared/widgets/button_widget.dart';
import 'package:service_orders_app/shared/widgets/header_widget.dart';
import 'package:service_orders_app/shared/widgets/line_vertical.dart';

class ServiceOrderDetailsPage extends StatefulWidget {
  final String orderId;

  const ServiceOrderDetailsPage({super.key, required this.orderId});

  @override
  State<ServiceOrderDetailsPage> createState() =>
      _ServiceOrderDetailsPageState();
}

class _ServiceOrderDetailsPageState extends State<ServiceOrderDetailsPage> {
  final OrderServiceDetailsByIdStore store = OrderServiceDetailsByIdStore(
    repository: OrderRepository(client: DioClientHttp()),
  );

  @override
  void initState() {
    super.initState();

    store.getServiceOrderById(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderWidget(title: "Detalhes da OS", showBackButton: true),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (store.state == null) {
            return const Center(
              child: Text('Nenhuma ordem de serviço encontrada.'),
            );
          }

          final order = store.state!;

          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 120,
              top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineVertical(),
                _header(order),

                LineVertical(),
                const SizedBox(height: 16),

                _titleSection(order.title),

                const SizedBox(height: 16),
                LineVertical(),
                const SizedBox(height: 14),
                _dateSection(order.createdAt, order.finishedAt),

                const SizedBox(height: 16),
                LineVertical(),

                const SizedBox(height: 16),
                _sectionTitle("Descrição do Problema", Icons.warning_amber),
                _box(order.problemDescription),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (order.photoPath != null &&
                        order.photoPath!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _sectionTitle(
                        "Evidência Fotográfica",
                        Icons.image_outlined,
                      ),
                      _photo(order.photoPath!),
                      const SizedBox(height: 16),
                    ],

                    if (order.executionDescription != null &&
                        order.executionDescription!.isNotEmpty) ...[
                      _sectionTitle(
                        "Descrição da Execução",
                        Icons.build_outlined,
                      ),
                      _box(order.executionDescription!),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),

                const SizedBox(height: 16),
                _sectionTitle("Checklist de Verificação", Icons.checklist),
                ...order.checklistItems.map((item) {
                  return _checkItem(
                    item.checklistItem.description,
                    item.isChecked,
                  );
                }),

                const SizedBox(height: 24),
                _buttons(order.status, order.id),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _header(ServiceOrderDetailsModel order) {
    final Color statusColor = getStatusColor(order.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tag, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ID DA ORDEM DE SERVIÇO",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(128, 21, 24, 27),
                  ),
                ),
                Text(
                  order.id,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              getStatusLabel(order.status),
              style: TextStyle(
                color: getStatusColor(order.status),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "TÍTULO",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(128, 21, 24, 27),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _dateSection(DateTime createdAt, DateTime? finishedAt) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          _dateItem(
            Icons.calendar_today,
            "CRIADA EM",
            createdAt,
            AppColors.primary,
          ),
          const SizedBox(width: 16),

          if (finishedAt != null)
            _dateItem(
              Icons.check_circle,
              "FINALIZADA EM",
              finishedAt,
              AppColors.completed,
            ),
        ],
      ),
    );
  }

  Widget _dateItem(IconData icon, String label, DateTime date, Color? color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(128, 21, 24, 27),
              ),
            ),
            Text(
              "${date.day.toString().padLeft(2, '0')}/"
              "${date.month.toString().padLeft(2, '0')}/"
              "${date.year} - "
              "${date.toLocal().hour.toString().padLeft(2, '0')}:"
              "${date.toLocal().minute.toString().padLeft(2, '0')}",
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _box(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text),
    );
  }

  Widget _photo(String url) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  Widget _checkItem(String text, bool isChecked) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryButton,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.check_box_outline_blank,
            color: isChecked
                ? Colors.green
                : const Color.fromARGB(255, 131, 129, 129),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buttons(String status, String orderId) {
    return Column(
      children: [
        if (status != 'FINISHED')
          ButtonWidget(
            title: "Realizar Serviço",
            icon: Icons.check,
            type: ButtonWidgetType.primary,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FinalizeServiceOrderPage(orderId: orderId),
                ),
              );

              store.getServiceOrderById(orderId: store.state!.id);
            },
          ),

        if (status != 'FINISHED') const SizedBox(height: 12),
      ],
    );
  }
}
