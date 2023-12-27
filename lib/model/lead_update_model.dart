import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/lead_model.dart';

class LeadUpdates {
  int? id;
  int? lead;
  EmployeeData? updatedByUser;
  String? date;
  String? status;
  EmployeeData? nextFollowUpBy;
  int? potential;
  String? description;
  String? document;
  List<String>? comment;

  LeadUpdates(
      {this.id,
        this.lead,
        this.updatedByUser,
        this.date,
        this.status,
        this.nextFollowUpBy,
        this.potential,
        this.description,
        this.document,
        this.comment});

  LeadUpdates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
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
    document = json['document'];
    if (json['comment'] != null) {
      comment = <String>[];
      json['comment'].forEach((v) {
        comment!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead'] = this.lead;
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
    data['document'] = this.document;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v).toList();
    }
    return data;
  }
}