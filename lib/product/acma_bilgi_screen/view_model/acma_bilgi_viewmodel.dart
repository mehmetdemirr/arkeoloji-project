import 'package:demo/product/acma_bilgi_screen/service/acma_bilgi_service.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:flutter/material.dart';

class AcmaBilgiViewModel extends ChangeNotifier {
  List<AcmaBilgileri>? acmaBilgiler;

  Future<void> getAcmaBilgiler(int id) async {
    acmaBilgiler = await AcmaBilgiService(DioManager.dio).getAcmaBilgiList(id);
    notifyListeners();
  }

  Future<void> deleteAcmaBilgi(int id) async {
    bool value = await AcmaBilgiService(DioManager.dio).acmaBilgiDelete(id);
    if (value) {
      acmaBilgiler?.removeWhere((acma) => acma.id == id);
    }
    notifyListeners();
  }
}
