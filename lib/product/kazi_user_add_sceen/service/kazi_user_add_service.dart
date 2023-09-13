import 'dart:io';

import 'package:demo/core/function/get_token.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IUserService {
  final Dio dio;
  IUserService(this.dio);
  Future<List<UserModel>?> getUserList();
  Future<bool> kaziUserAdd(int kaziId, int userId);
}

class UserService extends IUserService {
  UserService(super.dio);

  String token = getToken();

  @override
  Future<List<UserModel>?> getUserList() async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.get(
        ApiItem.user.str(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Diğer başlıkları da burada ekleyebilirsiniz
          },
        ),
      );
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is List) {
          List<UserModel> userListesi =
              json.map((kaziJson) => UserModel.fromJson(kaziJson)).toList();
          // KaziModel nesnelerini içeren bir liste döndürebilirsiniz
          return userListesi;
        }
      }
    } catch (e) {
      printf("user list gelmedi");
    }
    return null;
  }

  @override
  Future<bool> kaziUserAdd(int kaziId, int userId) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(
        "/kazi/$kaziId/user/$userId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Diğer başlıkları da burada ekleyebilirsiniz
          },
        ),
      );
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is Map<String, dynamic>) {
          if (json["details"] == "true") {
            return true;
          }
          return false;
        }
      }
    } catch (e) {
      printf("kayıt yapılmadı $e");
    }
    return false;
  }
}
