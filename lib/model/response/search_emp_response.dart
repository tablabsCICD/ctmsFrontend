import 'package:flutter_hr_management/model/department_model.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
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
  EmployeeData? employeeDetails;
  DepartmentDetails? departmentDetails;
  EmployeeData? headOfDept;

  Data({this.employeeDetails, this.departmentDetails, this.headOfDept});

  Data.fromJson(Map<String, dynamic> json) {
    employeeDetails = json['employeeDetails'] != null
        ? new EmployeeData.fromJson(json['employeeDetails'])
        : null;
    departmentDetails = json['departmentDetails'] != null
        ? new DepartmentDetails.fromJson(json['departmentDetails'])
        : null;
    headOfDept = json['headOfDept'] != null
        ? new EmployeeData.fromJson(json['headOfDept'])
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





