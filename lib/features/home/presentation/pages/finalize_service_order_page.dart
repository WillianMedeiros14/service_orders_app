import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';
import 'package:service_orders_app/features/home/data/model/service_order_update_model%20.dart';
import 'package:service_orders_app/features/home/data/repositories/order_service_store_depository.dart';
import 'package:service_orders_app/features/home/presentation/store/order_service_details_by_id_store.dart';
import 'package:service_orders_app/features/home/presentation/store/update_order_service_by_id_store.dart';
import 'package:service_orders_app/shared/data/dio/dio_client_http.dart';
import 'package:service_orders_app/shared/widgets/button_widget.dart';
import 'package:service_orders_app/shared/widgets/header_widget.dart';
import 'package:service_orders_app/shared/widgets/show_app_snack_bar_message.dart';

class FinalizeServiceOrderPage extends StatefulWidget {
  final String orderId;
  const FinalizeServiceOrderPage({super.key, required this.orderId});

  @override
  State<FinalizeServiceOrderPage> createState() =>
      _FinalizeServiceOrderPageState();
}

class _FinalizeServiceOrderPageState extends State<FinalizeServiceOrderPage> {
  final TextEditingController _observationController = TextEditingController();
  late final OrderServiceDetailsByIdStore store;
  late final UpdateOrderServiceByStore storeUpdate;
  late String status = "";

  final Map<String, bool> checklistState = {};

  @override
  void initState() {
    super.initState();

    store = OrderServiceDetailsByIdStore(
      repository: OrderRepository(client: DioClientHttp()),
    );

    storeUpdate = UpdateOrderServiceByStore(
      repository: OrderRepository(client: DioClientHttp()),
    );

    store.getServiceOrderById(orderId: widget.orderId).then((_) {
      if (store.state != null) {
        final state = store.state!;

        for (var item in state.checklistItems) {
          checklistState[item.checklistItem.description] = item.isChecked;
        }

        _observationController.text = state.executionDescription ?? '';

        setState(() {});
      }
    });
  }

  void _updateStatus() {
    if (store.state == null) return;

    final state = store.state!;
    final List<ChecklistItemUpdateModel> checklistItems = state.checklistItems
        .map(
          (item) => ChecklistItemUpdateModel(
            serviceOrderChecklistId: item.checklistItem.id,
            isChecked: checklistState[item.checklistItem.description] ?? false,
          ),
        )
        .toList();

    final bool allChecked = checklistItems.every((item) => item.isChecked);
    final bool hasDescription = _observationController.text.trim().isNotEmpty;
    final bool hasPhoto =
        state.photoPath != null && state.photoPath!.isNotEmpty;

    final newStatus = (allChecked && hasDescription && hasPhoto)
        ? "FINISHED"
        : "IN_PROGRESS";

    if (status != newStatus) {
      setState(() {
        status = newStatus;
      });
    }
  }

  void _handleSendData(BuildContext context) async {
    if (store.state == null) return;

    final state = store.state!;

    final List<ChecklistItemUpdateModel> checklistItems = state.checklistItems
        .map(
          (item) => ChecklistItemUpdateModel(
            serviceOrderChecklistId: item.checklistItem.id,
            isChecked: checklistState[item.checklistItem.description] ?? false,
          ),
        )
        .toList();

    final bool allChecked = checklistItems.every((item) => item.isChecked);
    final bool hasDescription = _observationController.text.trim().isNotEmpty;
    final bool hasPhoto =
        state.photoPath != null && state.photoPath!.isNotEmpty;

    final newStatus = (allChecked && hasDescription && hasPhoto)
        ? "FINISHED"
        : "IN_PROGRESS";

    if (status != newStatus) {
      setState(() {
        status = newStatus;
      });
    }

    final ServiceOrderUpdateModel dataUpdate = ServiceOrderUpdateModel(
      executionDescription: hasDescription ? _observationController.text : null,
      photoPath: hasPhoto ? state.photoPath : null,
      status: status,
      checklistItems: checklistItems,
    );

    final result = await storeUpdate.updateServiceOrder(
      orderId: state.id,
      data: dataUpdate,
    );

    if (result.statusCode == 200) {
      showAppSnackBarMessage(
        context,
        "Ordem de serviço atualizada com sucesso!",
        ShowAppSnackBarMessageType.success,
      );
      Navigator.pop(context);
    } else {
      showAppSnackBarMessage(
        context,
        "Erro ao atualizar OS",
        ShowAppSnackBarMessageType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: HeaderWidget(
          title: "Alterar ordem de serviço",
          showBackButton: true,
        ),
        body: Observer(
          builder: (_) {
            if (store.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.state == null) {
              return const Center(
                child: Text('Nenhuma ordem de serviço encontrada.'),
              );
            }

            final order = store.state!;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (order.photoPath != null && order.photoPath!.isNotEmpty)
                    Column(
                      children: [
                        const Text(
                          "Evidência da Execução",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              Image.network(
                                order.photoPath!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(Icons.zoom_in),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    "Resumo do Checklist",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: checklistState.keys.map((key) {
                        return CheckboxListTile(
                          title: Text(key),
                          value: checklistState[key],
                          onChanged: (value) {
                            setState(() {
                              checklistState[key] = value ?? false;
                            });
                            _updateStatus();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Observação final",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _observationController,
                    maxLines: 4,
                    onChanged: (_) => _updateStatus(),
                    decoration: InputDecoration(
                      hintText:
                          "Descreva detalhes adicionais sobre o serviço realizado...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(102, 156, 152, 152),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(102, 156, 152, 152),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Observer(
                    builder: (_) {
                      return ButtonWidget(
                        title: status == "FINISHED" ? "Finalizar" : "Salvar",
                        icon: Icons.check_circle_outline,
                        type: ButtonWidgetType.primary,
                        isLoading: storeUpdate.isLoading,
                        onPressed: () => _handleSendData(context),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
