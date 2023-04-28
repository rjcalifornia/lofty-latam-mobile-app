// ignore_for_file: file_names, unnecessary_this, unnecessary_new, unnecessary_question_mark, prefer_void_to_null, prefer_collection_literals
class PaymentsDetails {
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

  PaymentsDetails(
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

  PaymentsDetails.fromJson(Map<String, dynamic> json) {
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
  String? propertyId;
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
    propertyId = json['property_id'];
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
class PaymentType {
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
