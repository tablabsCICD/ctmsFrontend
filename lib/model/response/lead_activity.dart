class LeadActivityModel {
  String? message;
  List<LeadUpdateData>? data;
  bool? success;

  LeadActivityModel({this.message, this.data, this.success});

  LeadActivityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadUpdateData>[];
      json['data'].forEach((v) {
        data!.add(new LeadUpdateData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class LeadUpdateData {
  int? id;
  Lead? lead;
  LeadAddedBy? updatedByUser;
  String? date;
  String? status;
  LeadAddedBy? nextFollowUpBy;
  int? potential;
  String? description;

  LeadUpdateData(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description});

  LeadUpdateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new LeadAddedBy.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new LeadAddedBy.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential'];
    description = json['description']!=null?json['description']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.updatedByUser != null) {
      data['updatedByUser'] = this.updatedByUser!.toJson();
    }
    data['date'] = this.date;
    data['status'] = this.status;
    if (this.nextFollowUpBy != null) {
      data['nextFollowUpBy'] = this.nextFollowUpBy!.toJson();
    }
    data['potential'] = this.potential;
    data['description'] = this.description;
    return data;
  }
}

class Lead {
  int? id;
  String? companyName;
  String? coordinator;
  String? mobileNumber;
  String? emailId;
  String? sourceOfLead;
  String? pinCode;
  String? city;
  String? address;
  String? typeOfBusiness;
  String? date;
  LeadAddedBy? leadAddedBy;
  LeadAddedBy? leadAssignedTo;
  String? isEnquiry;
  bool? isRobinRound;

  Lead(
      {this.id,
        this.companyName,
        this.coordinator,
        this.mobileNumber,
        this.emailId,
        this.sourceOfLead,
        this.pinCode,
        this.city,
        this.address,
        this.typeOfBusiness,
        this.date,
        this.leadAddedBy,
        this.leadAssignedTo,
        this.isEnquiry,
        this.isRobinRound});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    coordinator = json['coordinator'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    sourceOfLead = json['sourceOfLead'];
    pinCode = json['pinCode'];
    city = json['city'];
    address = json['address'];
    typeOfBusiness = json['typeOfBusiness'];
    date = json['date'];
    leadAddedBy = json['leadAddedBy'] != null
        ? new LeadAddedBy.fromJson(json['leadAddedBy'])
        : null;
    leadAssignedTo = json['leadAssignedTo'] != null
        ? new LeadAddedBy.fromJson(json['leadAssignedTo'])
        : null;
    isEnquiry = json['isEnquiry'];
    isRobinRound = json['isRobinRound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['coordinator'] = this.coordinator;
    data['mobileNumber'] = this.mobileNumber;
    data['emailId'] = this.emailId;
    data['sourceOfLead'] = this.sourceOfLead;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['address'] = this.address;
    data['typeOfBusiness'] = this.typeOfBusiness;
    data['date'] = this.date;
    if (this.leadAddedBy != null) {
      data['leadAddedBy'] = this.leadAddedBy!.toJson();
    }
    if (this.leadAssignedTo != null) {
      data['leadAssignedTo'] = this.leadAssignedTo!.toJson();
    }
    data['isEnquiry'] = this.isEnquiry;
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}

class LeadAddedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  Null? employeeId;
  Role? role;
  bool? isAdmin;
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;

  LeadAddedBy(
      {this.id,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.employeeId,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId});

  LeadAddedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    employeeId = json['employeeId'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    isAdmin = json['is_admin'];
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['employeeId'] = this.employeeId;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['is_admin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['status'] = this.status;
    data['deviceId'] = this.deviceId;
    return data;
  }
}

class Role {
  int? id;
  String? name;
  int? isActive;

  Role({this.id, this.name, this.isActive});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    return data;
  }
}
