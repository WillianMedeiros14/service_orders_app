import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:service_orders_app/features/home/presentation/store/order_service_store.dart';
import 'package:service_orders_app/features/home/presentation/widget/service_order_card_widget.dart';
import 'package:service_orders_app/shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late OrderServiceStore orderServiceStore;

  @override
  void initState() {
    super.initState();
    orderServiceStore = context.read<OrderServiceStore>();

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
            if (orderServiceStore.isLoading &&
                orderServiceStore.state.isEmpty) {
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

            return RefreshIndicator(
              onRefresh: () async {
                await orderServiceStore.getServiceOrders();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        200,
                  ),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
