import 'lead_list.dart';

class EmpReportModel {
  String? message;
  EmpReport? data;
  bool? success;

  EmpReportModel({this.message, this.data, this.success});

  EmpReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new EmpReport.fromJson(json['data']) : null;
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

class EmpReport {
  Employee? employee;
  int? totaLead;
  int? acceptedLead;
  int? rejectedLead;
  int? pendingLaed;
  List<LeadUpdates>? leadUpdates;
  String? report;

  EmpReport(
      {this.employee,
        this.totaLead,
        this.acceptedLead,
        this.rejectedLead,
        this.pendingLaed,
        this.leadUpdates,
        this.report});

  EmpReport.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    totaLead = json['totaLead'];
    acceptedLead = json['acceptedLead'];
    rejectedLead = json['rejectedLead'];
    pendingLaed = json['pendingLaed'];
    if (json['leadUpdates'] != null) {
      leadUpdates = <LeadUpdates>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdates.fromJson(v));
      });
    }
    report = json['report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['totaLead'] = this.totaLead;
    data['acceptedLead'] = this.acceptedLead;
    data['rejectedLead'] = this.rejectedLead;
    data['pendingLaed'] = this.pendingLaed;
    if (this.leadUpdates != null) {
      data['leadUpdates'] = this.leadUpdates!.map((v) => v.toJson()).toList();
    }
    data['report'] = this.report;
    return data;
  }
}

class Employee {
  int? id;
  String? firstName;
  String? birthdate;
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
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  Employee(
      {this.id,
        this.firstName,
        this.birthdate,
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

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    birthdate = json['birthdate'];
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
    active = json['active'];
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
    data['firstName'] = this.firstName;
    data['birthdate'] = this.birthdate;
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
    experienceCertificate = json['experienceCertificate'];
    active = json['active'];
    otherDocuments = json['otherDocuments'].cast<String>();
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

class LeadUpdates {
  int? id;
  Lead? lead;
  UpdatedByUser? updatedByUser;
  String? date;
  String? status;
  Employee? nextFollowUpBy;
  int? potential;
  String? description;
  String? nextFollowupDate;
  bool? isActive;
  String? document;

  LeadUpdates(
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

  LeadUpdates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new UpdatedByUser.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new Employee.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential'];
    description = json['description'];
    nextFollowupDate = json['nextFollowupDate'];
    isActive = json['isActive'];
    document = json['document'];
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
    isEnquiry = json['isEnquiry'];
    isRoundRobin = json['isRoundRobin'];
    addLogo = json['addLogo'];
    document = json['document'];
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
    data['isEnquiry'] = this.isEnquiry;
    data['isRoundRobin'] = this.isRoundRobin;
    data['addLogo'] = this.addLogo;
    data['document'] = this.document;
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}

class UpdatedByUser {
  int? id;
  String? firstName;
  String? birthdate;
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
  Null? role;
  bool? isAdmin;
  Null? isActive;
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
        this.firstName,
        this.birthdate,
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

  UpdatedByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    birthdate = json['birthdate'];
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
    active = json['active'];
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
    data['firstName'] = this.firstName;
    data['birthdate'] = this.birthdate;
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
