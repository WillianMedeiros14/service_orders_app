import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:service_orders_app/features/home/data/repositories/order_service_store_depository.dart';
import 'package:service_orders_app/features/home/presentation/store/order_service_store.dart';
import 'package:service_orders_app/features/home/presentation/widget/service_order_card_widget.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OrderServiceStore orderServiceStore = OrderServiceStore(
    repository: OrderRepository(client: DioClientHttp()),
  );

  @override
  void initState() {
    super.initState();
    orderServiceStore.getServiceOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Ordens de Serviço",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 120,
          top: 16,
        ),
        child: Observer(
          builder: (_) {
            if (orderServiceStore.isLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            }

            if (orderServiceStore.state.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Text('Nenhuma ordem der serviço encontrada.'),
                ),
              );
            }

            return SingleChildScrollView(
              child: Wrap(
                spacing: 16,
                runSpacing: 4,
                children: orderServiceStore.state.map((order) {
                  return ServiceOrderCardWidget(
                    orderId: order.id,
                    status: order.status,
                    title: order.title.isNotEmpty
                        ? order.title
                        : order.problemDescription,
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
