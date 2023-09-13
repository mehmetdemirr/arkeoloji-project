import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/kazi_screen/service/kazi_service.dart';
import 'package:flutter/material.dart';

class KaziViewModel extends ChangeNotifier {
  List<KaziModel>? kazilar;
  bool isLoading = false;

  void isLoadingchange() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> getKazilar() async {
    isLoadingchange();
    kazilar = await KaziService(DioManager.dio).getKaziList();
    isLoadingchange();
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
