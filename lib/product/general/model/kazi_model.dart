class KaziModel {
  int? id;
  String? name;
  String? city;
  String? town;
  Owner? owner;
  List<Acmalar>? acmalar;
  List<UserModel>? users;

  KaziModel(
      {this.id,
      this.name,
      this.city,
      this.town,
      this.owner,
      this.acmalar,
      this.users});

  KaziModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    town = json['town'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['acmalar'] != null) {
      acmalar = <Acmalar>[];
      json['acmalar'].forEach((v) {
        acmalar!.add(Acmalar.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['town'] = town;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (acmalar != null) {
      data['acmalar'] = acmalar!.map((v) => v.toJson()).toList();
    }
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? name;
  String? username;
  String? rol;
  bool? activate;

  Owner({this.id, this.name, this.username, this.rol, this.activate});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    rol = json['rol'];
    activate = json['activate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['rol'] = rol;
    data['activate'] = activate;
    return data;
  }
}

class Acmalar {
  int? id;
  String? name;
  int? kaziId;
  Owner? owner;
  List<AcmaBilgileri>? acmaBilgileri;

  Acmalar({this.id, this.name, this.kaziId, this.owner, this.acmaBilgileri});

  Acmalar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kaziId = json['kazi_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    if (json['acma_bilgileri'] != null) {
      acmaBilgileri = <AcmaBilgileri>[];
      json['acma_bilgileri'].forEach((v) {
        acmaBilgileri!.add(AcmaBilgileri.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['kazi_id'] = kaziId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (acmaBilgileri != null) {
      data['acma_bilgileri'] = acmaBilgileri!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcmaBilgileri {
  int? id;
  String? name;
  String? description;
  String? photo;
  int? acmaId;
  Owner? owner;

  AcmaBilgileri(
      {this.id,
      this.name,
      this.description,
      this.photo,
      this.acmaId,
      this.owner});

  AcmaBilgileri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    acmaId = json['acma_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['photo'] = photo;
    data['acma_id'] = acmaId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? username;
  String? rol;
  bool? activate;

  UserModel({this.id, this.name, this.username, this.rol, this.activate});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    rol = json['rol'];
    activate = json['activate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['rol'] = rol;
    data['activate'] = activate;
    return data;
  }
}
