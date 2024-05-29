

import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';

class TKDEmployeeListResponse {
  String? message;
  List<User>? data;
  bool? success;

  TKDEmployeeListResponse({this.message, this.data, this.success});

  TKDEmployeeListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(new User.fromJson(v));
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


