import 'package:flutter_hr_management/model/response/employeelist.dart';

class SearchEmpResponse {
  String? message;
  List<Data>? data;
  bool? success;

  SearchEmpResponse({this.message, this.data, this.success});

  SearchEmpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  EmpData? employeeDetails;
  DepartmentDetails? departmentDetails;
  EmpData? headOfDept;

  Data({this.employeeDetails, this.departmentDetails, this.headOfDept});

  Data.fromJson(Map<String, dynamic> json) {
    employeeDetails = json['employeeDetails'] != null
        ? new EmpData.fromJson(json['employeeDetails'])
        : null;
    departmentDetails = json['departmentDetails'] != null
        ? new DepartmentDetails.fromJson(json['departmentDetails'])
        : null;
    headOfDept = json['headOfDept'] != null
        ? new EmpData.fromJson(json['headOfDept'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeeDetails != null) {
      data['employeeDetails'] = this.employeeDetails!.toJson();
    }
    if (this.departmentDetails != null) {
      data['departmentDetails'] = this.departmentDetails!.toJson();
    }
    if (this.headOfDept != null) {
      data['headOfDept'] = this.headOfDept!.toJson();
    }
    return data;
  }
}





class DepartmentDetails {
  int? id;
  String? name;
  String? employeeId;
  String? contact;
  String? active;

  DepartmentDetails(
      {this.id, this.name, this.employeeId, this.contact, this.active});

  DepartmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeId = json['employeeId'];
    contact = json['contact'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['employeeId'] = this.employeeId;
    data['contact'] = this.contact;
    data['active'] = this.active;
    return data;
  }
}
