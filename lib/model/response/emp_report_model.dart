import 'package:flutter_hr_management/model/employee_model.dart';
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
  List<LeadUpdates>? leadUpdates;
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
      leadUpdates = <LeadUpdates>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdates.fromJson(v));
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

