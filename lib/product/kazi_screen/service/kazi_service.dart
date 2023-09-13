import 'dart:io';

import 'package:demo/core/function/get_token.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IKaziService {
  final Dio dio;
  IKaziService(this.dio);
  Future<List<KaziModel>?> getKaziList();
  Future<bool> kaziAdd(String name, String city, String town);
  Future<bool> kaziDelete(int id);
}

class KaziService extends IKaziService {
  KaziService(super.dio);

  String token = getToken();

  @override
  Future<List<KaziModel>?> getKaziList() async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.get(
        ApiItem.currentKazi.str(),
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
          List<KaziModel> kaziListesi =
              json.map((kaziJson) => KaziModel.fromJson(kaziJson)).toList();
          // KaziModel nesnelerini içeren bir liste döndürebilirsiniz
          return kaziListesi;
        }
      }
    } catch (e) {
      printf("kazı list gelmedi");
    }
    return null;
  }

  @override
  Future<bool> kaziAdd(String name, String city, String town) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.post(
        ApiItem.kazi.str(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // Diğer başlıkları da burada ekleyebilirsiniz
          },
        ),
        data: {"name": name, "city": city, "town": town},
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
      printf("kazı oluşamadı $e");
    }
    return false;
  }

  @override
  Future<bool> kaziDelete(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.delete(
        "${ApiItem.kazi.str()}/$id",
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
      printf("kazı siinmedi $e");
    }
    return false;
  }
}
