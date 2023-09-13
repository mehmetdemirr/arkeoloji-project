import 'package:demo/product/acma_screen/service/acma_service.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:flutter/material.dart';

class AcmaViewModel extends ChangeNotifier {
  List<Acmalar>? acmalar;

  Future<void> getAcmalar(int id) async {
    acmalar = await AcmaService(DioManager.dio).getAcmaList(id);
    notifyListeners();
  }

  Future<void> deleteAcma(int id) async {
    bool value = await AcmaService(DioManager.dio).acmaDelete(id);
    if (value) {
      acmalar?.removeWhere((acma) => acma.id == id);
    }
    notifyListeners();
  }
}
