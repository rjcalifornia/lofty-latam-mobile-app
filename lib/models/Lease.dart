// ignore_for_file: file_names, unnecessary_this, unnecessary_new, unnecessary_question_mark, prefer_void_to_null, prefer_collection_literals

class Lease {
  int? id;
  Null? scannedContract;
  TenantId? tenantId;
  PropertyId? propertyId;
  String? rentTypeId;
  String? contractDate;
  String? paymentDate;
  String? expirationDate;
  String? price;
  String? deposit;
  String? duration;
  bool? active;
  String? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;
  RentType? rentType;
  List<Payments>? payments;

  Lease(
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
      this.updatedAt,
      this.rentType,
      this.payments});

  Lease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scannedContract = json['scanned_contract'];
    tenantId = json['tenant_id'] != null
        ? new TenantId.fromJson(json['tenant_id'])
        : null;
    propertyId = json['property_id'] != null
        ? new PropertyId.fromJson(json['property_id'])
        : null;
    rentTypeId = json['rent_type_id'];
    contractDate = json['contract_date'];
    paymentDate = json['payment_date'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    deposit = json['deposit'];
    duration = json['duration'];
    active = json['active'];
    userCreates = json['user_creates'];
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rentType = json['rent_type'] != null
        ? new RentType.fromJson(json['rent_type'])
        : null;
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scanned_contract'] = this.scannedContract;
    if (this.tenantId != null) {
      data['tenant_id'] = this.tenantId!.toJson();
    }
    if (this.propertyId != null) {
      data['property_id'] = this.propertyId!.toJson();
    }
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
    if (this.rentType != null) {
      data['rent_type'] = this.rentType!.toJson();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
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
  String? active;
  String? userCreates;
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
    active = json['active'];
    userCreates = json['user_creates'];
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

class RentType {
  int? id;
  String? name;
  String? value;
  String? active;
  String? createdAt;
  String? updatedAt;

  RentType(
      {this.id,
      this.name,
      this.value,
      this.active,
      this.createdAt,
      this.updatedAt});

  RentType.fromJson(Map<String, dynamic> json) {
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

class Payments {
  int? id;
  String? receiptNumber;
  LeaseId? leaseId;
  PaymentTypeId? paymentTypeId;
  String? paymentDate;
  String? monthCancelled;
  String? payment;
  String? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;
  String? monthCancelledName;

  Payments(
      {this.id,
      this.receiptNumber,
      this.leaseId,
      this.paymentTypeId,
      this.paymentDate,
      this.monthCancelled,
      this.payment,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt,
      this.monthCancelledName});

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptNumber = json['receipt_number'];
    leaseId = json['lease_id'] != null
        ? new LeaseId.fromJson(json['lease_id'])
        : null;
    paymentTypeId = json['payment_type_id'] != null
        ? new PaymentTypeId.fromJson(json['payment_type_id'])
        : null;
    paymentDate = json['payment_date'];
    monthCancelled = json['month_cancelled'];
    payment = json['payment'];
    userCreates = json['user_creates'];
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    monthCancelledName = json['month_cancelled_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receipt_number'] = this.receiptNumber;
    if (this.leaseId != null) {
      data['lease_id'] = this.leaseId!.toJson();
    }
    if (this.paymentTypeId != null) {
      data['payment_type_id'] = this.paymentTypeId!.toJson();
    }
    data['payment_date'] = this.paymentDate;
    data['month_cancelled'] = this.monthCancelled;
    data['payment'] = this.payment;
    data['user_creates'] = this.userCreates;
    data['user_modifies'] = this.userModifies;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['month_cancelled_name'] = this.monthCancelledName;
    return data;
  }
}

class LeaseId {
  int? id;
  Null? scannedContract;
  TenantId? tenantId;
  PropertyId? propertyId;
  String? rentTypeId;
  String? contractDate;
  String? paymentDate;
  String? expirationDate;
  String? price;
  String? deposit;
  String? duration;
  bool? active;
  String? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;

  LeaseId(
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

  LeaseId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scannedContract = json['scanned_contract'];
    tenantId = json['tenant_id'] != null
        ? new TenantId.fromJson(json['tenant_id'])
        : null;
    propertyId = json['property_id'] != null
        ? new PropertyId.fromJson(json['property_id'])
        : null;
    rentTypeId = json['rent_type_id'];
    contractDate = json['contract_date'];
    paymentDate = json['payment_date'];
    expirationDate = json['expiration_date'];
    price = json['price'];
    deposit = json['deposit'];
    duration = json['duration'];
    active = json['active'];
    userCreates = json['user_creates'];
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
    if (this.propertyId != null) {
      data['property_id'] = this.propertyId!.toJson();
    }
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

class PropertyId {
  int? id;
  String? name;
  String? address;
  String? bedrooms;
  String? beds;
  String? bathrooms;
  bool? hasAc;
  bool? hasKitchen;
  bool? hasDinningRoom;
  bool? hasSink;
  bool? hasFridge;
  bool? hasWifi;
  bool? hasTv;
  bool? hasFurniture;
  bool? hasGarage;
  LandlordId? landlordId;
  bool? active;
  String? userCreates;
  Null? userModifies;
  String? createdAt;
  String? updatedAt;

  PropertyId(
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
      this.hasWifi,
      this.hasTv,
      this.hasFurniture,
      this.hasGarage,
      this.landlordId,
      this.active,
      this.userCreates,
      this.userModifies,
      this.createdAt,
      this.updatedAt});

  PropertyId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    bedrooms = json['bedrooms'];
    beds = json['beds'];
    bathrooms = json['bathrooms'];
    hasAc = json['has_ac'];
    hasKitchen = json['has_kitchen'];
    hasDinningRoom = json['has_dinning_room'];
    hasSink = json['has_sink'];
    hasFridge = json['has_fridge'];
    hasWifi = json['has_wifi'];
    hasTv = json['has_tv'];
    hasFurniture = json['has_furniture'];
    hasGarage = json['has_garage'];
    landlordId = json['landlord_id'] != null
        ? new LandlordId.fromJson(json['landlord_id'])
        : null;
    active = json['active'];
    userCreates = json['user_creates'];
    userModifies = json['user_modifies'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['has_wifi'] = this.hasWifi;
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
  String? idRol;
  String? isAdmin;
  String? active;
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
    idRol = json['id_rol'];
    isAdmin = json['is_admin'];
    active = json['active'];
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

class PaymentTypeId {
  int? id;
  String? name;
  bool? active;
  String? createdAt;
  String? updatedAt;

  PaymentTypeId(
      {this.id, this.name, this.active, this.createdAt, this.updatedAt});

  PaymentTypeId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
