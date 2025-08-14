// ignore_for_file: file_names, unnecessary_new, unnecessary_this, prefer_collection_literals

class Departamentos {
  int? id;
  String? nombre;
  int? paisId;
  bool? active;

  Departamentos({
    this.id,
    this.nombre,
    this.paisId,
    this.active,
  });

  Departamentos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    paisId = json['pais_id'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['pais_id'] = this.paisId;
    data['active'] = this.active;
    return data;
  }
}
