import 'package:demo/product/general/model/user_login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

String getToken() {
  var box = Hive.box<UserLoginModel>("user");
  UserLoginModel? user = box.get("user");
  return user?.accessToken ?? "";
}
