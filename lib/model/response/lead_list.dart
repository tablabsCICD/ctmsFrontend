class LeadList {
  String? message;
  List<LeadData>? data;
  bool? success;

  LeadList({this.message, this.data, this.success});

  LeadList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadData>[];
      json['data'].forEach((v) {
        data!.add(new LeadData.fromJson(v));
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

class LeadData {
  Lead? lead;
  List<String>? leadUpdates;
  List<String>? trackings;

  LeadData({this.lead, this.leadUpdates, this.trackings});

  LeadData.fromJson(Map<String, dynamic> json) {
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    leadUpdates = json['leadUpdates'].cast<String>();
    trackings = json['trackings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    data['leadUpdates'] = this.leadUpdates;
    data['trackings'] = this.trackings;
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
  int? isEnquiry;
  bool? isRobinRound;
  bool? isSelected;

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
        this.isRobinRound,
        this.isSelected
      });

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
    isSelected=false;
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
  String? employeeId;
  Role? role;
  int ? isActive;
  String? otp;
  String? password;
  String? os;
  String? deviceId;

  LeadAddedBy(
      {this.id,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.employeeId,
        this.role,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.deviceId});

  LeadAddedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    employeeId = json['employeeId'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
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
    data['employeeId'] = this.employeeId;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
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
