
import 'package:flutter_hr_management/model/employee_model.dart';

class LoginDeatils {
  String? message;
  EmployeeData? data;
  bool? success;

  LoginDeatils({this.message, this.data, this.success});

  LoginDeatils.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new EmployeeData.fromJson(json['data']) : null;
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

