// ignore_for_file: file_names, unnecessary_new, unnecessary_this, prefer_collection_literals
class Distritos {
  int? id;
  String? nombre;
  DepartamentoId? departamentoId;
  MunicipioId? municipioId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Distritos(
      {this.id,
      this.nombre,
      this.departamentoId,
      this.municipioId,
      this.active,
      this.createdAt,
      this.updatedAt});

  Distritos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    departamentoId = json['departamento_id'] != null
        ? new DepartamentoId.fromJson(json['departamento_id'])
        : null;
    municipioId = json['municipio_id'] != null
        ? new MunicipioId.fromJson(json['municipio_id'])
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
    if (this.municipioId != null) {
      data['municipio_id'] = this.municipioId!.toJson();
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

class MunicipioId {
  int? id;
  String? nombre;
  int? departamentoId;
  bool? active;
  String? createdAt;
  String? updatedAt;

  MunicipioId(
      {this.id,
      this.nombre,
      this.departamentoId,
      this.active,
      this.createdAt,
      this.updatedAt});

  MunicipioId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    departamentoId = json['departamento_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['departamento_id'] = this.departamentoId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
