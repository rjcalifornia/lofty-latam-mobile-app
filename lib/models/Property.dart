// ignore_for_file: file_names, unnecessary_this, unnecessary_new, unnecessary_question_mark, prefer_void_to_null, prefer_collection_literals

class Property {
  int? id;
  String? name;
  String? address;
  int? bedrooms;
  int? beds;
  int? bathrooms;
  bool? hasAc;
  bool? hasKitchen;
  bool? hasDinningRoom;
  bool? hasSink;
  bool? hasFridge;
  bool? hasTv;
  bool? hasFurniture;
  bool? hasGarage;
  LandlordId? landlordId;
  bool? active;
  int? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;
  List<Leases>? leases;
  PropertyPictures? propertyPictures;

  Property(
      {this.id,
      this.name,
      this.address,
      this.bedrooms,
      this.beds,
      this.bathrooms,
      this.hasAc,
      this.hasKitchen,
      this.hasDinningRoom,
      this.hasSink,
      this.hasFridge,
      this.hasTv,
      this.hasFurniture,
      this.hasGarage,
      this.landlordId,
      this.active,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt,
      this.leases,
      this.propertyPictures});

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    bedrooms = int.parse(json['bedrooms']);
    beds = int.parse(json['beds']);
    bathrooms = int.parse(json['bathrooms']);
    hasAc = json['has_ac'];
    hasKitchen = json['has_kitchen'];
    hasDinningRoom = json['has_dinning_room'];
    hasSink = json['has_sink'];
    hasFridge = json['has_fridge'];
    hasTv = json['has_tv'];
    hasFurniture = json['has_furniture'];
    hasGarage = json['has_garage'];
    landlordId = json['landlord_id'] != null
        ? new LandlordId.fromJson(json['landlord_id'])
        : null;
    active = json['active'];
    userCreates = int.parse(json['user_creates']);
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['leases'] != null) {
      leases = <Leases>[];
      json['leases'].forEach((v) {
        leases!.add(new Leases.fromJson(v));
      });
    }
    propertyPictures = json['property_pictures'] != null
        ? new PropertyPictures.fromJson(json['property_pictures'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['bedrooms'] = this.bedrooms;
    data['beds'] = this.beds;
    data['bathrooms'] = this.bathrooms;
    data['has_ac'] = this.hasAc;
    data['has_kitchen'] = this.hasKitchen;
    data['has_dinning_room'] = this.hasDinningRoom;
    data['has_sink'] = this.hasSink;
    data['has_fridge'] = this.hasFridge;
    data['has_tv'] = this.hasTv;
    data['has_furniture'] = this.hasFurniture;
    data['has_garage'] = this.hasGarage;
    if (this.landlordId != null) {
      data['landlord_id'] = this.landlordId!.toJson();
    }
    data['active'] = this.active;
    data['user_creates'] = this.userCreates;
    data['user_modifies'] = this.userModifies;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.leases != null) {
      data['leases'] = this.leases!.map((v) => v.toJson()).toList();
    }
    if (this.propertyPictures != null) {
      data['property_pictures'] = this.propertyPictures!.toJson();
    }
    return data;
  }
}

class LandlordId {
  int? id;
  String? name;
  String? lastname;
  String? username;
  String? phone;
  String? dui;
  String? email;
  Null? emailVerifiedAt;
  int? idRol;
  int? isAdmin;
  int? active;
  String? createdAt;
  String? updatedAt;

  LandlordId(
      {this.id,
      this.name,
      this.lastname,
      this.username,
      this.phone,
      this.dui,
      this.email,
      this.emailVerifiedAt,
      this.idRol,
      this.isAdmin,
      this.active,
      this.createdAt,
      this.updatedAt});

  LandlordId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
    dui = json['dui'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    idRol = int.parse(json['id_rol']);
    isAdmin = int.parse(json['is_admin']);
    active = int.parse(json['active']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['email_verified_at'] = this.emailVerifiedAt;
    data['id_rol'] = this.idRol;
    data['is_admin'] = this.isAdmin;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Leases {
  int? id;
  Null? scannedContract;
  TenantId? tenantId;
  int? propertyId;
  int? rentTypeId;
  String? contractDate;
  String? paymentDate;
  String? expirationDate;
  String? price;
  String? deposit;
  int? duration;
  bool? active;
  int? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;

  Leases(
      {this.id,
      this.scannedContract,
      this.tenantId,
      this.propertyId,
      this.rentTypeId,
      this.contractDate,
      this.paymentDate,
      this.expirationDate,
      this.price,
      this.deposit,
      this.duration,
      this.active,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt});

  Leases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scannedContract = json['scanned_contract'];
    tenantId = json['tenant_id'] != null
        ? new TenantId.fromJson(json['tenant_id'])
        : null;
    propertyId = int.parse(json['property_id']);
    rentTypeId = int.parse(json['rent_type_id']);
    contractDate = json['contract_date'];
    paymentDate = json['payment_date'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    deposit = json['deposit'];
    duration = int.parse(json['duration']);
    active = json['active'];
    userCreates = int.parse(json['user_creates']);
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scanned_contract'] = this.scannedContract;
    if (this.tenantId != null) {
      data['tenant_id'] = this.tenantId!.toJson();
    }
    data['property_id'] = this.propertyId;
    data['rent_type_id'] = this.rentTypeId;
    data['contract_date'] = this.contractDate;
    data['payment_date'] = this.paymentDate;
    data['expiration_date'] = this.expirationDate;
    data['price'] = this.price;
    data['deposit'] = this.deposit;
    data['duration'] = this.duration;
    data['active'] = this.active;
    data['user_creates'] = this.userCreates;
    data['user_modifies'] = this.userModifies;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TenantId {
  int? id;
  String? name;
  String? lastname;
  String? username;
  String? phone;
  String? email;
  int? active;
  int? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;

  TenantId(
      {this.id,
      this.name,
      this.lastname,
      this.username,
      this.phone,
      this.email,
      this.active,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt});

  TenantId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    active = int.parse(json['active']);
    userCreates = int.parse(json['user_creates']);
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['active'] = this.active;
    data['user_creates'] = this.userCreates;
    data['user_modifies'] = this.userModifies;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PropertyPictures {
  int? id;
  int? propertyId;
  String? imageName;
  int? active;
  Null? order;
  int? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;
  String? imageLinkName;

  PropertyPictures(
      {this.id,
      this.propertyId,
      this.imageName,
      this.active,
      this.order,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt,
      this.imageLinkName});

  PropertyPictures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = int.parse(json['property_id']);
    imageName = json['image_name'];
    active = int.parse(json['active']);
    order = json['order'];
    userCreates = int.parse(json['user_creates']);
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageLinkName = json['image_link_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['image_name'] = this.imageName;
    data['active'] = this.active;
    data['order'] = this.order;
    data['user_creates'] = this.userCreates;
    data['user_modifies'] = this.userModifies;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_link_name'] = this.imageLinkName;
    return data;
  }
}
