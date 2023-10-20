class EmployeeList {
  String? message;
  List<EmpData>? data;
  bool? success;

  EmployeeList({this.message, this.data, this.success});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <EmpData>[];
      json['data'].forEach((v) {
        data!.add(new EmpData.fromJson(v));
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

class EmpData {
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
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? deviceId;
  bool? isSelected;
  bool? isAdmin;
  String? status;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  EmpData(
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
        this.isSelected,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  EmpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId']??1;
    firstName = json['firstName']??'';
    lastName = json['lastName']??'';
    emailId = json['emailId']??"";
    mobileNumber = json['mobileNumber']??'';
    address = json['address']??'';
    image = json['image']??"";
    designation = json['designation']??'';
    contact = json['contact']??'';
    employeeLocation = json['employeeLocation']??"";
    departmentId = json['departmentId']??'';
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'] != null
        ? new Role.fromJson(json['role'])
        : null;
     isAdmin = json['is_admin']??false;
    isActive = json['isActive']??1;
    otp = json['otp']??'';
    password = json['password']??'';
    os = json['os']??'';
    status = json['status']??'';
    deviceId = json['deviceId']??'';
    createdDate = json['createdDate']??'';
    securityQuestion = json['securityQuestion']??'';
    securityAnswer = json['securityAnswer']??"";
    isSelected = false;
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

/*
class EmployeeList {
  String? message;
  List<EmpData>? data;
  bool? success;

  EmployeeList({this.message, this.data, this.success});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <EmpData>[];
      json['data'].forEach((v) {
        data!.add(new EmpData.fromJson(v));
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

class EmpData {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? status;
  String? employeeId;
  String? designation;
  Role? role;
  int? isActive;
  String? otp;
  String? password;
  String? os;
  String? deviceId;
  bool? isSelected;
  String? image;

  EmpData(
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
        this.designation,
        this.deviceId,
        this.isSelected,
        this.status,
        this.image
      });

  EmpData.fromJson(Map<String, dynamic> json) {
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
    designation = json['designation'];
    password = json['password'];
    os = json['os'];
    deviceId = json['deviceId'];
    image = json['image'];
    status = json['status'];
    isSelected=false;
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
    data['designation'] = this.designation;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['deviceId'] = this.deviceId;
    data['status'] = this.status;
    return data;
  }
}
*/

class Role {
  int? id;
  String? name;
  int? isActive;

  Role({this.id, this.name, this.isActive});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
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
