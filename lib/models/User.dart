// ignore_for_file: file_names, unnecessary_this, unnecessary_new, unnecessary_question_mark, prefer_void_to_null, prefer_collection_literals

class User {
  int? id;
  String? name;
  String? lastname;
  String? username;
  String? phone;
  String? dui;
  String? email;
  bool? isEmailVerified;
  //Null? emailVerifiedAt;
  //int? idRol;
  //int? isAdmin;
  //int? active;
  //String? createdAt;
  //String? updatedAt;
  Rol? rol;

  User(
      {this.id,
      this.name,
      this.lastname,
      this.username,
      this.phone,
      this.dui,
      this.email,
      this.isEmailVerified,
      //this.emailVerifiedAt,
      //this.idRol,
      //this.isAdmin,
      //this.active,
      //this.createdAt,
      //this.updatedAt,
      this.rol});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
    dui = json['dui'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    //emailVerifiedAt = json['email_verified_at'];
    //idRol = json['id_rol'];
    //isAdmin = json['is_admin'];
    //active = json['active'];
    //createdAt = json['created_at'];
    //updatedAt = json['updated_at'];
    rol = json['rol'] != null ? new Rol.fromJson(json['rol']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['dui'] = this.dui;
    data['email'] = this.email;
    data['is_email_verified'] = this.isEmailVerified;
    //data['email_verified_at'] = this.emailVerifiedAt;
    //data['id_rol'] = this.idRol;
    //xdata['is_admin'] = this.isAdmin;
    //data['active'] = this.active;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    if (this.rol != null) {
      data['rol'] = this.rol!.toJson();
    }
    return data;
  }
}

class Rol {
  int? id;
  String? name;
  //int? active;
  Null? deactivatedAt;
  int? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;

  Rol({
    this.id,
    this.name,
    //this.active,
  });

  Rol.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    //data['active'] = this.active;

    return data;
  }
}
