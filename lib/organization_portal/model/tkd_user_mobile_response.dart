import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';

class TkdUserByMobileResponse {
  String? message;
  ConnectUser? data;
  bool? success;

  TkdUserByMobileResponse({this.message, this.data, this.success});

  TkdUserByMobileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ConnectUser.fromJson(json['data']) : null;
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


