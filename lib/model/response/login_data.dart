import 'package:flutter_hr_management/model/response/roles.dart';

import 'lead_list.dart';

class LoginDeatils {
  String? message;
  Data? data;
  bool? success;

  LoginDeatils({this.message, this.data, this.success});

  LoginDeatils.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
    tenthDCertificate = json['tenthDCertificate']??"";
    twelthCertificate = json['twelthCertificate']??'';
    degreeCertificate = json['degreeCertificate']??'';
    aadharCard = json['aadharCard']??'';
    panCard = json['panCard']??'';
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
