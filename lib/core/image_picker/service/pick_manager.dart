import 'package:app_settings/app_settings.dart';
import 'package:demo/core/permission_control/permission_check.dart';
import 'package:demo/core/image_picker/service/pick_image_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IPickManager {
  final IPermissionCheck _iPermissionCheck = PermissionCheck();
  final IPickImage _iPickImage = CustomPickImage();
  Future<XFile?> fetchImageGallery();
  Future<XFile?> fetchImageCamera();
}

class PickManager extends IPickManager {
  @override
  Future<XFile?> fetchImageGallery() async {
    // await Permission.photos.request();
    if (!await _iPermissionCheck.gallery()) {
      await AppSettings.openAppSettings();
      return null;
    }

    return _iPickImage.pickImageGallery();
  }

  @override
  Future<XFile?> fetchImageCamera() async {
    // await Permission.camera.request();
    if (!await _iPermissionCheck.camera()) {
      await AppSettings.openAppSettings();
      return null;
    }
    return _iPickImage.pickImageCamera();
  }
}
