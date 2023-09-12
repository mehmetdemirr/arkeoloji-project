import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/home_screen/service/kazi_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<KaziModel>? kazilar;

  Future<void> getKazilar() async {
    kazilar = await KaziService(DioManager.dio).getKaziList();
    notifyListeners();
  }

  Future<void> deleteKazi(int id) async {
    bool value = await KaziService(DioManager.dio).kaziDelete(id);
    if (value) {
      kazilar?.removeWhere((kazi) => kazi.id == id);
    }
    notifyListeners();
  }
}
