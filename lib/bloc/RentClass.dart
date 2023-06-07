class RentClass {
  int? id;
  String? name;
  int? value;
  int? active;
  String? createdAt;
  String? updatedAt;

  RentClass(
      {this.id,
      this.name,
      this.value,
      this.active,
      this.createdAt,
      this.updatedAt});

  RentClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
