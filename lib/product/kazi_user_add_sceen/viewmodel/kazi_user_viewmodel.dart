import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/kazi_user_add_sceen/service/kazi_user_add_service.dart';
import 'package:flutter/material.dart';

class KaziUserViewModel extends ChangeNotifier {
  List<UserModel>? users;

  Future<void> getUsers() async {
    users = await UserService(DioManager.dio).getUserList();
    notifyListeners();
  }
}
