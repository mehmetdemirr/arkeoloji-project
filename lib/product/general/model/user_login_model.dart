import 'package:hive/hive.dart';
part 'user_login_model.g.dart';

@HiveType(typeId: 0)
class UserLoginModel {
  @HiveField(0)
  String? accessToken;

  @HiveField(1)
  int? id;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? username;

  @HiveField(4)
  String? rol;

  @HiveField(5)
  bool? activate;

  UserLoginModel(
      {this.accessToken,
      this.id,
      this.name,
      this.username,
      this.rol,
      this.activate});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    id = json['id'];
    name = json['name'];
    username = json['username'];
    rol = json['rol'];
    activate = json['activate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['rol'] = rol;
    data['activate'] = activate;
    return data;
  }
}
