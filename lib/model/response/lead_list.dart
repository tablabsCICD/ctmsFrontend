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
  String? status;
  Lead? lead;
  List<LeadUpdates>? leadUpdates;

  LeadData({this.status, this.lead, this.leadUpdates, });

  LeadData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    if (json['leadUpdates'] != null) {
      leadUpdates = <LeadUpdates>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdates.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.leadUpdates != null) {
      data['leadUpdates'] = this.leadUpdates!.map((v) => v.toJson()).toList();
    }

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
  String? addLogo;
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
        this.addLogo,
        this.isSelected,
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
    addLogo = json['addLogo'];
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
    data['addLogo'] = this.addLogo;
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}

class NextFollowUpBy {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? employeeId;
  Role? role;
  bool? isAdmin;
  bool? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;

  NextFollowUpBy(
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
        this.deviceId,
        this.createdDate});

  NextFollowUpBy.fromJson(Map<String, dynamic> json) {
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
    createdDate = json['createdDate'];
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
    data['createdDate'] = this.createdDate;
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
  String? employeeId;
  Role? role;
  bool? isAdmin;
  bool? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;

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
        this.deviceId,
        this.createdDate});

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
    createdDate = json['createdDate'];
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
    data['createdDate'] = this.createdDate;
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

class LeadUpdates {
  int? id;
  int? lead;
  LeadAddedBy? updatedByUser;
  String? date;
  String? status;
  NextFollowUpBy? nextFollowUpBy;
  int? potential;
  String? description;

  LeadUpdates(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description});

  LeadUpdates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
    updatedByUser = json['updatedByUser'] != null
        ? new LeadAddedBy.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new NextFollowUpBy.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead'] = this.lead;
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



/*
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
  String? status;
  Lead? lead;
  List<LeadUpdates>? leadUpdates;
  List<dynamic>? trackings;

  LeadData({this.status, this.lead, this.leadUpdates, this.trackings});

  LeadData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    if (json['leadUpdates'] != null) {
      leadUpdates = <LeadUpdates>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdates.fromJson(v));
      });
    }
    */
/*if (json['trackings'] != null) {
      trackings = <Null>[];
      json['trackings'].forEach((v) {
        trackings!.add(new Null.fromJson(v));
      });
    }*//*

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.leadUpdates != null) {
      data['leadUpdates'] = this.leadUpdates!.map((v) => v.toJson()).toList();
    }
    */
/*if (this.trackings != null) {
      data['trackings'] = this.trackings!.map((v) => v.toJson()).toList();
    }*//*

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
  String? addLogo;
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
        this.addLogo,
        this.isRobinRound,
        this.isSelected});

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
    addLogo = json['addLogo'];
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
    data['addLogo'] = this.addLogo;
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
  String? employeeId;
  Role? role;
  bool? isAdmin;
  bool? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;

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
        this.deviceId,
        this.createdDate});

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
    createdDate = json['createdDate'];
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
    data['createdDate'] = this.createdDate;
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

class LeadUpdates {
  int? id;
  int? lead;
  LeadAddedBy? updatedByUser;
  String? date;
  String? status;
  String? nextFollowUpBy;
  String? potential;
  String? description;

  LeadUpdates(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description});

  LeadUpdates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
    updatedByUser = json['updatedByUser'] != null
        ? new LeadAddedBy.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'];
    potential = json['potential'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead'] = this.lead;
    if (this.updatedByUser != null) {
      data['updatedByUser'] = this.updatedByUser!.toJson();
    }
    data['date'] = this.date;
    data['status'] = this.status;
    data['nextFollowUpBy'] = this.nextFollowUpBy;
    data['potential'] = this.potential;
    data['description'] = this.description;
    return data;
  }
}


*/
/*
class LeadList {
  String? message;
  LeadData? data;
  bool? success;

  LeadList({this.message, this.data, this.success});

  LeadList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new LeadData.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class LeadData {
  int? id;
  Lead? lead;
  LeadAddedBy? updatedByUser;
  String? date;
  String? status;
  String? nextFollowUpBy;
  String? potential;
  String? description;
  String? nextFollowupDate;
  String? isActive;

  LeadData(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description,
        this.nextFollowupDate,
        this.isActive});

  LeadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new LeadAddedBy.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'];
    potential = json['potential'];
    description = json['description'];
    nextFollowupDate = json['nextFollowupDate'];
    isActive = json['isActive'];
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
    data['nextFollowUpBy'] = this.nextFollowUpBy;
    data['potential'] = this.potential;
    data['description'] = this.description;
    data['nextFollowupDate'] = this.nextFollowupDate;
    data['isActive'] = this.isActive;
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
  String? addLogo;
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
        this.addLogo,
        this.isRobinRound,
      this.isSelected});

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
    addLogo = json['addLogo'];
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
    data['addLogo'] = this.addLogo;
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
  String? employeeId;
  Role? role;
  String? isAdmin;
  String? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;

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
        this.deviceId,
        this.createdDate});

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
    createdDate = json['createdDate'];
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
    data['createdDate'] = this.createdDate;
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




*//*

*/
/*
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
*//*


*/
