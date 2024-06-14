import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/lead_model.dart';
import 'package:flutter_hr_management/model/lead_update_model.dart';

import 'lead_list.dart';

class EmpReportModel {
  String? message;
  EmpReport? data;
  bool? success;

  EmpReportModel({this.message, this.data, this.success});

  EmpReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new EmpReport.fromJson(json['data']) : null;
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

class EmpReport {
  EmployeeData? employee;
  int? totaLead;
  int? acceptedLead;
  int? rejectedLead;
  int? pendingLaed;
  List<LeadUpdate>? leadUpdates;
  String? report;

  EmpReport(
      {this.employee,
        this.totaLead,
        this.acceptedLead,
        this.rejectedLead,
        this.pendingLaed,
        this.leadUpdates,
        this.report});

  EmpReport.fromJson(Map<String, dynamic> json) {
    employee = json['employee'] != null
        ? new EmployeeData.fromJson(json['employee'])
        : null;
    totaLead = json['totaLead'];
    acceptedLead = json['acceptedLead'];
    rejectedLead = json['rejectedLead'];
    pendingLaed = json['pendingLaed'];
    if (json['leadUpdates'] != null) {
      leadUpdates = <LeadUpdate>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdate.fromJson(v));
      });
    }
    report = json['report'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['totaLead'] = this.totaLead;
    data['acceptedLead'] = this.acceptedLead;
    data['rejectedLead'] = this.rejectedLead;
    data['pendingLaed'] = this.pendingLaed;
    if (this.leadUpdates != null) {
      data['leadUpdates'] = this.leadUpdates!.map((v) => v.toJson()).toList();
    }
    data['report'] = this.report;
    return data;
  }
}

class LeadUpdate {
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

  LeadUpdate(
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

  LeadUpdate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    updatedByUser = json['updatedByUser'] != null
        ? new EmployeeData.fromJson(json['updatedByUser'])
        : null;
    date = json['date'];
    status = json['status'];
    nextFollowUpBy = json['nextFollowUpBy'] != null
        ? new EmployeeData.fromJson(json['nextFollowUpBy'])
        : null;
    potential = json['potential'];
    description = json['description'];
    nextFollowupDate = json['nextFollowupDate'];
    isActive = json['isActive'];
    document = json['document'];
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