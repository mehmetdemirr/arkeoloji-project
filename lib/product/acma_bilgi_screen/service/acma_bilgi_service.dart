import 'dart:io';

import 'package:demo/core/function/get_token.dart';
import 'package:demo/core/function/print_function.dart';
import 'package:demo/core/utilty/api_items.dart';
import 'package:demo/product/general/model/kazi_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IAcmaBilgiService {
  final Dio dio;
  IAcmaBilgiService(this.dio);
  Future<List<AcmaBilgileri>?> getAcmaBilgiList(int id);
  Future<bool> acmaBilgiAdd(
      int acmaId, String name, String description, File file);
  Future<bool> acmaBilgiDelete(int id);
}

class AcmaBilgiService extends IAcmaBilgiService {
  AcmaBilgiService(super.dio);

  String token = getToken();

  @override
  Future<List<AcmaBilgileri>?> getAcmaBilgiList(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.get(
        "${ApiItem.acmaBilgi.str()}$id",
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
          List<AcmaBilgileri> acmaBilgileriList =
              json.map((acmaJson) => AcmaBilgileri.fromJson(acmaJson)).toList();
          return acmaBilgileriList;
        }
      }
    } catch (e) {
      printf("acma bilgi list gelmedi");
    }
    return null;
  }

  @override
  Future<bool> acmaBilgiAdd(
      int acmaId, String name, String description, File file) async {
    dio.interceptors.add(PrettyDioLogger());
    // FormData nesnesini oluşturun
    // FormData nesnesini oluşturun (sadece dosya yükleme gerektiği durumlar için)
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: 'fileName.jpg', // Dosya adını burada ayarlayabilirsiniz
      ),
    });
    // Query parametreleri oluşturun
    Map<String, dynamic> queryParameters = {
      'name': name,
      'description': description,
      'acma_id': acmaId.toString(), // acmaId'yi string olarak çevirin
    };

    try {
      final result = await dio.post(
        ApiItem.acmaBilgi.str(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            //'Content-Type': 'multipart/form-data', // İsteğin türünü belirtin
            // Diğer başlıkları da burada ekleyebilirsiniz
          },
        ),
        data: formData,
        queryParameters:
            queryParameters, // Query parametrelerini burada ekleyin
      );
      if (result.statusCode == HttpStatus.ok) {
        var json = result.data;
        if (json is Map<String, dynamic>) {
          AcmaBilgileri? acmaBilgi = AcmaBilgileri.fromJson(json);
          // ignore: unnecessary_null_comparison
          return acmaBilgi != null;
        }
      }
    } catch (e) {
      printf("acma bilgi oluşmadı $e");
    }
    return false;
  }

  @override
  Future<bool> acmaBilgiDelete(int id) async {
    dio.interceptors.add(PrettyDioLogger());
    try {
      final result = await dio.delete(
        "${ApiItem.acmaBilgi.str()}$id",
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
      printf("acma bilgi siinmedi $e");
    }
    return false;
  }
}
