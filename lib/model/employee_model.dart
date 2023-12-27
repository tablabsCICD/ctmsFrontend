import 'package:flutter_hr_management/model/boarding_model.dart';
import 'package:flutter_hr_management/model/branch_model.dart';
import 'package:flutter_hr_management/model/role_model.dart';

class EmployeeData {
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
  Branch? branch;
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
  int? organisationId;
  bool? isSelected;
  String? aadharNo;
  String? panNo;
  String? esiNO;

  EmployeeData(
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
        this.branch,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.organisationId,
        this.securityAnswer,
        this.aadharNo,
        this.panNo,
        this.esiNO,
        this.isSelected
      });

  EmployeeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId']??'';
    firstName = json['firstName']??"";
    lastName = json['lastName']??'';
    emailId = json['emailId']??'';
    mobileNumber = json['mobileNumber']??"";
    address = json['address']??'';
    image = json['image']??"";
    designation = json['designation']??'';
    contact = json['contact']??'';
    employeeLocation = json['employeeLocation']??'';
    departmentId = json['departmentId']??0;
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'] != null
        ? new Role.fromJson(json['role'])
        : null;
    branch = json['branch'] != null
        ? new Branch.fromJson(json['branch'])
        : null;
    isAdmin = json['is_admin']??true;
    isActive = json['isActive']??1;
    otp = json['otp']??'';
    password = json['password']??'';
    os = json['os']??'';
    status = json['status']??'';
    deviceId = json['deviceId']??'';
    createdDate = json['createdDate']??'';
    securityQuestion = json['securityQuestion']??'';
    securityAnswer = json['securityAnswer']??'';
    organisationId = json['organisationId'];
    aadharNo = json['aadharNo']??'';
    panNo = json['panNo']??'';
    esiNO = json['esiNO']??'';
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
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
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
    data['organisationId'] = this.organisationId;
    data['aadharNo'] = this.aadharNo;
    data['panNo'] = this.panNo;
    data['esiNO'] = this.esiNO;
    return data;
  }
}

