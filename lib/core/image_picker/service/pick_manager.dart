import 'package:app_settings/app_settings.dart';
import 'package:demo/core/permission_control/permission_check.dart';
import 'package:demo/core/image_picker/service/pick_image_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    if (kIsWeb) {
      return _iPickImage.pickImageGallery();
    }
    if (!await _iPermissionCheck.gallery()) {
      await AppSettings.openAppSettings();
      return null;
    }

    return _iPickImage.pickImageGallery();
  }

  @override
  Future<XFile?> fetchImageCamera() async {
    // await Permission.camera.request();
    if (kIsWeb) {
      return _iPickImage.pickImageGallery();
    }
    if (!await _iPermissionCheck.camera()) {
      await AppSettings.openAppSettings();
      return null;
    }
    return _iPickImage.pickImageCamera();
  }
}
