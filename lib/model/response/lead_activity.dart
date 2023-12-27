import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/lead_model.dart';

class LeadActivityModel {
  String? message;
  List<LeadActivityData>? data;
  bool? success;

  LeadActivityModel({this.message, this.data, this.success});

  LeadActivityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadActivityData>[];
      json['data'].forEach((v) {
        data!.add(new LeadActivityData.fromJson(v));
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

class LeadActivityData {
  int? id;
  Lead? lead;
  EmployeeData? updatedByUser;
  String? date;
  String? status;
  EmployeeData? nextFollowUpBy;
  int? potential;
  String? description;
  String? nextFollowupDate;
  bool? isActive;
  String? document;
  int? organisationId;

  LeadActivityData(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description,
        this.nextFollowupDate,
        this.isActive,
        this.document,
        this.organisationId});

  LeadActivityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new EmployeeData.fromJson(json['updatedByUser'])
        : null;
    date = json['date']??"";
    status = json['status']??"";
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new EmployeeData.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential']??0;
    description = json['description']??"";
    nextFollowupDate = json['nextFollowupDate']??'';
    isActive = json['isActive'];
    document = json['document']??"";
    organisationId = json['organisationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.updatedByUser != null) {
      data['updatedByUser'] = this.updatedByUser!.toJson();
    }
    data['date'] = this.date;
    data['status'] = this.status;
    if (this.nextFollowUpBy != null) {
      data['nextFollowUpBy'] = this.nextFollowUpBy!.toJson();
    }
    data['potential'] = this.potential;
    data['description'] = this.description;
    data['nextFollowupDate'] = this.nextFollowupDate;
    data['isActive'] = this.isActive;
    data['document'] = this.document;
    data['organisationId'] = this.organisationId;
    return data;
  }
}

