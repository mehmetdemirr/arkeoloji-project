import 'dart:io';

import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ILoginService {
  final Dio dio;
  ILoginService(this.dio);
  Future<bool> login(String username, String pasword);
}

class LoginService extends ILoginService {
  LoginService(super.dio);

  @override
  Future<bool> login(String username, String pasword) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(ApiItem.login.str(),
          data: {"username": username, "password": pasword});
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is Map<String, dynamic>) {
          UserLoginModel user = UserLoginModel.fromJson(json);
          var box = Hive.box<UserLoginModel>("user");
          await box.put("user", user);
          return true;
        }
      }
    } catch (e) {
      printf("giriş yapılmadı $e");
    }
    return false;
  }
}
