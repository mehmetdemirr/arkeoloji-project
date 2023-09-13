import 'dart:io';

import 'package:demo/core/function/get_token.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IAcmaService {
  final Dio dio;
  IAcmaService(this.dio);
  Future<List<Acmalar>?> getAcmaList(int id);
  Future<bool> acmaAdd(String name, int kaziId);
  Future<bool> acmaDelete(int id);
}

class AcmaService extends IAcmaService {
  AcmaService(super.dio);

  String token = getToken();

  @override
  Future<List<Acmalar>?> getAcmaList(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.get(
        "${ApiItem.acma.str()}$id/",
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
          List<Acmalar> acmaList =
              json.map((acmaJson) => Acmalar.fromJson(acmaJson)).toList();
          return acmaList;
        }
      }
    } catch (e) {
      printf("acma list gelmedi");
    }
    return null;
  }

  @override
  Future<bool> acmaAdd(String name, int kaziId) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(
        "${ApiItem.acma.str()}$kaziId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Diğer başlıkları da burada ekleyebilirsiniz
          },
        ),
        data: {
          "name": name,
          "kazi_id": kaziId,
        },
      );
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is Map<String, dynamic>) {
          KaziModel? kazi = KaziModel.fromJson(json);
          // ignore: unnecessary_null_comparison
          return kazi != null;
        }
      }
    } catch (e) {
      printf("acma oluşmadı $e");
    }
    return false;
  }

  @override
  Future<bool> acmaDelete(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.delete(
        "${ApiItem.acma.str()}$id",
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
        }
      }
    } catch (e) {
      printf("acma siinmedi $e");
    }
    return false;
  }
}
