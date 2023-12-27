import 'package:flutter_hr_management/model/ctms_organization.dart';

class CtmsOrganizationResponse {
  String? message;
  CtmsOrganization? data;
  bool? success;

  CtmsOrganizationResponse({this.message, this.data, this.success});

  CtmsOrganizationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new CtmsOrganization.fromJson(json['data']) : null;
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


