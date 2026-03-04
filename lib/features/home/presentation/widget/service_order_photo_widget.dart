import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_orders_app/features/home/data/model/service_order_details_model.dart';
import 'package:service_orders_app/features/home/presentation/widget/take_photo_card_execute_service_widget.dart';

class ServiceOrderPhotoWidget extends StatelessWidget {
  final ServiceOrderDetailsModel order;
  final XFile? image;
  final VoidCallback onTakePhoto;

  const ServiceOrderPhotoWidget({
    super.key,
    required this.order,
    required this.image,
    required this.onTakePhoto,
  });

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return _buildLocalPhoto();
    }

    if (order.photoPath != null && order.photoPath!.isNotEmpty) {
      return _buildNetworkPhoto();
    }

    return TakePhotoCardExecuteServiceWidget(onTap: onTakePhoto);
  }

  Widget _buildLocalPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.file(
            File(image!.path),
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: _changePhoto(() {
              onTakePhoto();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            order.photoPath!,
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: _changePhoto(() {
              onTakePhoto();
            }),
          ),
        ],
      ),
    );
  }

  Widget _changePhoto(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
