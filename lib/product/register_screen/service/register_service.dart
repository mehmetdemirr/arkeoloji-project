import 'dart:io';

import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/user_login_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IRegisterService {
  final Dio dio;
  IRegisterService(this.dio);
  Future<bool> register(String name, String username, String pasword);
}

class RegisterService extends IRegisterService {
  RegisterService(super.dio);

  @override
  Future<bool> register(String name, String username, String pasword) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(
        "${ApiItem.user.str()}/",
        data: {
          "name": name,
          "username": username,
          "password": pasword,
          "rol": "user",
          "activate": true
        },
      );
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is Map<String, dynamic>) {
          // UserLoginModel user = UserLoginModel.fromJson(json);
          // var box = Hive.box<UserLoginModel>("user");
          // await box.put("user", user);
          if (json["name"] != name) {
            return false;
          }
          return true;
        }
      }
    } catch (e) {
      printf("kayıt yapılmadı $e");
    }
    return false;
  }
}
