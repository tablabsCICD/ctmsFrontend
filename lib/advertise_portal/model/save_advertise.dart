import 'package:flutter_hr_management/advertise_portal/model/advertise_model.dart';

class SaveAdvertise {
  String? message;
  AdvertiseData? data;
  bool? success;

  SaveAdvertise({this.message, this.data, this.success});

  SaveAdvertise.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new AdvertiseData.fromJson(json['data']) : null;
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