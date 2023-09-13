import 'package:demo/core/function/print_function.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:demo/product/general/service/project_dio.dart';
import 'package:demo/product/kazi_user_add_sceen/service/kazi_user_add_service.dart';
import 'package:flutter/material.dart';

class KaziUserViewModel extends ChangeNotifier {
  List<UserModel>? users;
  List<UserModel>? currentUsers;

  Future<void> getUsers() async {
    users = await UserService(DioManager.dio).getUserList();
    notifyListeners();
  }

  Future<void> getCurrentUsers(int kaziId) async {
    currentUsers = await UserService(DioManager.dio).getCurrentUserList(kaziId);
    notifyListeners();
  }

  Future<bool> deleteUserKazi(int kaziId, int userId) async {
    bool value =
        await UserService(DioManager.dio).kaziUserDelete(kaziId, userId);
    if (value) {
      try {
        currentUsers?.removeWhere((users) => users.id == userId);
      } catch (e) {
        printf("hata geldi :$e");
      }
    }
    notifyListeners();
    return value;
  }

  Future<bool> addUserKazi(int kaziId, UserModel user) async {
    bool value =
        await UserService(DioManager.dio).kaziUserAdd(kaziId, user.id ?? -1);
    if (value) {
      currentUsers?.add(user);
    }
    notifyListeners();
    return value;
  }
}
