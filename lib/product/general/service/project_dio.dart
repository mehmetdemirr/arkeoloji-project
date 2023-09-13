import 'package:dio/dio.dart';

mixin DioManager {
  static final Dio dio = Dio(
    BaseOptions(baseUrl: "https://mehmetdemir.xyz/arkeo"),
  );
}
