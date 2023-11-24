class LeadListResponse {
  String? message;
  PaginationData? data;
  bool? success;

  LeadListResponse({this.message, this.data, this.success});

  LeadListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new PaginationData.fromJson(json['data']) : null;
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

class PaginationData {
  List<LeadData>? detailsWithPage;
  int? pageNumber;
  int? pageSize;
  int? totalElements;
  int? totalPages;
  bool? lastPage;

  PaginationData(
      {this.detailsWithPage,
        this.pageNumber,
        this.pageSize,
        this.totalElements,
        this.totalPages,
        this.lastPage});

  PaginationData.fromJson(Map<String, dynamic> json) {
    if (json['detailsWithPage'] != null) {
      detailsWithPage = <LeadData>[];
      json['detailsWithPage'].forEach((v) {
        detailsWithPage!.add(new LeadData.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailsWithPage != null) {
      data['detailsWithPage'] =
          this.detailsWithPage!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['lastPage'] = this.lastPage;
    return data;
  }
}







class LeadData {
  String? status;
  Lead? lead;
  List<LeadUpdates>? leadUpdates;
  List<String>? trackings;

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
    if (json['trackings'] != null) {
      trackings = <String>[];
      json['trackings'].forEach((v) {
        trackings!.add((v));
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
    if (this.trackings != null) {
      data['trackings'] = this.trackings!.map((v) => v).toList();
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
  int? isEnquiry;
  bool? isRoundRobin;
  String? addLogo;
  String? document;
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
        this.isEnquiry,
        this.isRoundRobin,
        this.addLogo,
        this.document,
        this.isSelected});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName']??'';
    coordinator = json['coordinator']??"";
    mobileNumber = json['mobileNumber']??"";
    emailId = json['emailId']??"";
    sourceOfLead = json['sourceOfLead']??'';
    pinCode = json['pinCode']??'';
    city = json['city']??'';
    address = json['address']??'';
    typeOfBusiness = json['typeOfBusiness']??'';
    date = json['date']??'';
    isEnquiry = json['isEnquiry']??0;
    isRoundRobin = json['isRoundRobin']??false;
    addLogo = json['addLogo']??"";
    document = json['document']??"";
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
    data['isEnquiry'] = this.isEnquiry;
    data['addLogo'] = this.addLogo;
    data['document'] = this.document;
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}

class LeadUpdates {
  int? id;
  int? lead;
  UpdatedByUser? updatedByUser;
  String? date;
  String? status;
  UpdatedByUser? nextFollowUpBy;
  int? potential;
  String? description;
  String? document;
  List<String>? comment;

  LeadUpdates(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description,
        this.document,
        this.comment});

  LeadUpdates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
    updatedByUser = json['updatedByUser'] != null
        ? new UpdatedByUser.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new UpdatedByUser.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential'];
    description = json['description'];
    document = json['document'];
    if (json['comment'] != null) {
      comment = <String>[];
      json['comment'].forEach((v) {
        comment!.add((v));
      });
    }
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
    data['document'] = this.document;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v).toList();
    }
    return data;
  }
}

class LeadAddedBy {
  int? id;
  String? employeeId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? designation;
  String? contact;
  String? employeeLocation;
  int? departmentId;
  BoardingDeatails? boardingDeatails;
  Role? role;
  bool? isAdmin;
  bool? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  LeadAddedBy(
      {this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.designation,
        this.contact,
        this.employeeLocation,
        this.departmentId,
        this.boardingDeatails,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  LeadAddedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    designation = json['designation'];
    contact = json['contact'];
    employeeLocation = json['employeeLocation'];
    departmentId = json['departmentId'];
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'] != null
        ? new Role.fromJson(json['role'])
        : null;
    isAdmin = json['is_admin'];
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
    createdDate = json['createdDate'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['employeeLocation'] = this.employeeLocation;
    data['departmentId'] = this.departmentId;
    if (this.boardingDeatails != null) {
      data['boardingDeatails'] = this.boardingDeatails!.toJson();
    }
    data['role'] = this.role;
    data['is_admin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['status'] = this.status;
    data['deviceId'] = this.deviceId;
    data['createdDate'] = this.createdDate;
    data['securityQuestion'] = this.securityQuestion;
    data['securityAnswer'] = this.securityAnswer;
    return data;
  }
}

class BoardingDeatails {
  int? boardingId;
  String? tenthDCertificate;
  String? twelthCertificate;
  String? degreeCertificate;
  String? aadharCard;
  String? panCard;
  String? experienceCertificate;
  String? active;
  List<String>? otherDocuments;

  BoardingDeatails(
      {this.boardingId,
        this.tenthDCertificate,
        this.twelthCertificate,
        this.degreeCertificate,
        this.aadharCard,
        this.panCard,
        this.experienceCertificate,
        this.active,
        this.otherDocuments});

  BoardingDeatails.fromJson(Map<String, dynamic> json) {
    boardingId = json['boardingId'];
    tenthDCertificate = json['tenthDCertificate'];
    twelthCertificate = json['twelthCertificate'];
    degreeCertificate = json['degreeCertificate'];
    aadharCard = json['aadharCard'];
    panCard = json['panCard'];
    experienceCertificate = json['experienceCertificate']??'';
    active = json['active'];
    if (json['otherDocuments'] != null) {
      otherDocuments = <String>[];
      json['otherDocuments'].forEach((v) {
        otherDocuments!.add((v));
      });
    }
   // otherDocuments = json['otherDocuments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boardingId'] = this.boardingId;
    data['tenthDCertificate'] = this.tenthDCertificate;
    data['twelthCertificate'] = this.twelthCertificate;
    data['degreeCertificate'] = this.degreeCertificate;
    data['aadharCard'] = this.aadharCard;
    data['panCard'] = this.panCard;
    data['experienceCertificate'] = this.experienceCertificate;
    data['active'] = this.active;
    data['otherDocuments'] = this.otherDocuments;
    return data;
  }
}

class LeadAssignedTo {
  int? id;
  String? employeeId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? designation;
  String? contact;
  String? employeeLocation;
  int? departmentId;
  BoardingDeatails? boardingDeatails;
  String? role;
  bool? isAdmin;
  bool? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  LeadAssignedTo(
      {this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.designation,
        this.contact,
        this.employeeLocation,
        this.departmentId,
        this.boardingDeatails,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  LeadAssignedTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    designation = json['designation'];
    contact = json['contact'];
    employeeLocation = json['employeeLocation'];
    departmentId = json['departmentId'];
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'];
    isAdmin = json['is_admin'];
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
    createdDate = json['createdDate'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['employeeLocation'] = this.employeeLocation;
    data['departmentId'] = this.departmentId;
    if (this.boardingDeatails != null) {
      data['boardingDeatails'] = this.boardingDeatails!.toJson();
    }
    data['role'] = this.role;
    data['is_admin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['status'] = this.status;
    data['deviceId'] = this.deviceId;
    data['createdDate'] = this.createdDate;
    data['securityQuestion'] = this.securityQuestion;
    data['securityAnswer'] = this.securityAnswer;
    return data;
  }
}

class UpdatedByUser {
  int? id;
  String? employeeId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? designation;
  String? contact;
  String? employeeLocation;
  int? departmentId;
  BoardingDeatails? boardingDeatails;
  Role? role;
  bool? isAdmin;
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  UpdatedByUser(
      {this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.designation,
        this.contact,
        this.employeeLocation,
        this.departmentId,
        this.boardingDeatails,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  UpdatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    designation = json['designation'];
    contact = json['contact'];
    employeeLocation = json['employeeLocation'];
    departmentId = json['departmentId'];
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    isAdmin = json['is_admin'];
    isActive = json['isActive']??0;
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
    createdDate = json['createdDate'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['employeeLocation'] = this.employeeLocation;
    data['departmentId'] = this.departmentId;
    if (this.boardingDeatails != null) {
      data['boardingDeatails'] = this.boardingDeatails!.toJson();
    }
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
    data['securityQuestion'] = this.securityQuestion;
    data['securityAnswer'] = this.securityAnswer;
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

class NextFollowUpBy {
  int? id;
  String? employeeId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? designation;
  String? contact;
  String? employeeLocation;
  int? departmentId;
  BoardingDeatails? boardingDeatails;
  Role? role;
  int? isAdmin;
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  NextFollowUpBy(
      {this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.designation,
        this.contact,
        this.employeeLocation,
        this.departmentId,
        this.boardingDeatails,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  NextFollowUpBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    designation = json['designation'];
    contact = json['contact'];
    employeeLocation = json['employeeLocation'];
    departmentId = json['departmentId'];
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'];
    isAdmin = json['is_admin'];
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
    createdDate = json['createdDate'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['employeeLocation'] = this.employeeLocation;
    data['departmentId'] = this.departmentId;
    if (this.boardingDeatails != null) {
      data['boardingDeatails'] = this.boardingDeatails!.toJson();
    }
    data['role'] = this.role;
    data['is_admin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['status'] = this.status;
    data['deviceId'] = this.deviceId;
    data['createdDate'] = this.createdDate;
    data['securityQuestion'] = this.securityQuestion;
    data['securityAnswer'] = this.securityAnswer;
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
    companyName = json['companyName']??'';
    coordinator = json['coordinator']??'';
    mobileNumber = json['mobileNumber']??'';
    emailId = json['emailId']??"";
    sourceOfLead = json['sourceOfLead']??'';
    pinCode = json['pinCode']??"";
    city = json['city']??"";
    address = json['address']??'';
    typeOfBusiness = json['typeOfBusiness']??"";
    date = json['date']??"";
    leadAddedBy = json['leadAddedBy'] != null
        ? new LeadAddedBy.fromJson(json['leadAddedBy'])
        : null;
    leadAssignedTo = json['leadAssignedTo'] != null
        ? new LeadAddedBy.fromJson(json['leadAssignedTo'])
        : null;
    isEnquiry = json['isEnquiry']??1;
    addLogo = json['addLogo']??'';
    isRobinRound = json['isRobinRound']??false;
    isSelected = false;
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
    *//*

*/
/*if (json['trackings'] != null) {
      trackings = <Null>[];
      json['trackings'].forEach((v) {
        trackings!.add(new Null.fromJson(v));
      });
    }*//*
*/
/*

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
    *//*

*/
/*if (this.trackings != null) {
      data['trackings'] = this.trackings!.map((v) => v.toJson()).toList();
    }*//*
*/
/*

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


*//*

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
*/




