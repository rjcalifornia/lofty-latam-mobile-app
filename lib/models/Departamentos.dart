// ignore_for_file: file_names, unnecessary_new, unnecessary_this

class Departamentos {
  int? id;
  String? nombre;
  int? paisId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Departamentos(
      {this.id,
      this.nombre,
      this.paisId,
      this.active,
      this.createdAt,
      this.updatedAt});

  Departamentos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    paisId = json['pais_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['pais_id'] = this.paisId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
