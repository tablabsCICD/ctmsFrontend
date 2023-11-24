import 'lead_list.dart';




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
  UpdatedByUser? updatedByUser;
  String? date;
  String? status;
  UpdatedByUser? nextFollowUpBy;
  int? potential;
  String? description;
  String? nextFollowupDate;
  bool? isActive;
  String? document;

  LeadUpdateData(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description,
        this.nextFollowupDate,
        this.isActive,
        this.document});

  LeadUpdateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new UpdatedByUser.fromJson(json['updatedByUser'])
        : null;
    date = json['date']??'';
    status = json['status']??'';
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new UpdatedByUser.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential']??0;
    description = json['description']??'';
    nextFollowupDate = json['nextFollowupDate'];
    isActive = json['isActive']??true;
    document = json['document']??'';
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
    data['nextFollowupDate'] = this.nextFollowupDate;
    data['isActive'] = this.isActive;
    data['document'] = this.document;
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
  bool? isActive;
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
  String? active;
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
        this.active,
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
    firstName = json['firstName']??'';
    lastName = json['lastName']??"";
    emailId = json['emailId']??'';
    mobileNumber = json['mobileNumber']??'';
    address = json['address']??"";
    image = json['image']??'';
    designation = json['designation']??'';
    contact = json['contact']??'';
    employeeLocation = json['employeeLocation']??'';
    departmentId = json['departmentId']??0;
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    active = json['active']??true;
    role = json['role'] != null
        ? new Role.fromJson(json['role'])
        : null;
    isAdmin = json['is_admin']??false;
    isActive = json['isActive']??true;
    otp = json['otp']??'';
    password = json['password']??'';
    os = json['os']??'';
    status = json['status']??'';
    deviceId = json['deviceId']??'';
    createdDate = json['createdDate']??'';
    securityQuestion = json['securityQuestion']??'';
    securityAnswer = json['securityAnswer']??'';
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
    data['active'] = this.active;
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
