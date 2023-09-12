import 'package:dio/dio.dart';

mixin DioManager {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "http://127.0.0.1:8000"),
  );
}
