import 'package:image_picker/image_picker.dart';

Future<XFile?> openCamera() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 100,
    preferredCameraDevice: CameraDevice.front,
  );

  return file;
}
