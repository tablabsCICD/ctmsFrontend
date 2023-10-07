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
  int? employeeId;
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
