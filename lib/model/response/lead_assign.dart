

import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/lead_model.dart';
import 'package:flutter_hr_management/model/lead_update_model.dart';

import 'lead_list.dart';

class LeadAssignModel {
  String? message;
  List<LeadAssign>? data;
  bool? success;

  LeadAssignModel({this.message, this.data, this.success});

  LeadAssignModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadAssign>[];
      json['data'].forEach((v) {
        data!.add(new LeadAssign.fromJson(v));
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

class LeadAssign {
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

  LeadAssign(
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

  LeadAssign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new EmployeeData.fromJson(json['updatedByUser'])
        : null;
    date = json['date']??'';
    status = json['status']??'';
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new EmployeeData.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential']??0;
    description = json['description']??"";
    nextFollowupDate = json['nextFollowupDate']??'';
    isActive = json['isActive']??false;
    document = json['document']??'';
    organisationId = json['organisationId']??0;
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

