// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals, unnecessary_this

class Municipios {
  int? id;
  String? nombre;
  DepartamentoId? departamentoId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Municipios(
      {this.id,
      this.nombre,
      this.departamentoId,
      this.active,
      this.createdAt,
      this.updatedAt});

  Municipios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    departamentoId = json['departamento_id'] != null
        ? new DepartamentoId.fromJson(json['departamento_id'])
        : null;
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    if (this.departamentoId != null) {
      data['departamento_id'] = this.departamentoId!.toJson();
    }
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DepartamentoId {
  int? id;
  String? nombre;
  int? paisId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  DepartamentoId(
      {this.id,
      this.nombre,
      this.paisId,
      this.active,
      this.createdAt,
      this.updatedAt});

  DepartamentoId.fromJson(Map<String, dynamic> json) {
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
