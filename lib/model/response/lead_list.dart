import 'dart:js_util';

import 'package:flutter_hr_management/model/lead_model.dart';

class LeadListResponse {
  String? message;
  PaginationData? data;
  bool? success;

  LeadListResponse({this.message, this.data, this.success});

  LeadListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new PaginationData.fromJson(json['data']) : null;
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

class PaginationData {
  List<LeadData>? detailsWithPage;
  int? pageNumber;
  int? pageSize;
  int? totalElements;
  int? totalPages;
  bool? lastPage;

  PaginationData(
      {this.detailsWithPage,
        this.pageNumber,
        this.pageSize,
        this.totalElements,
        this.totalPages,
        this.lastPage});

  PaginationData.fromJson(Map<String, dynamic> json) {
    if (json['detailsWithPage'] != null) {
      detailsWithPage = <LeadData>[];
      json['detailsWithPage'].forEach((v) {
        detailsWithPage!.add(new LeadData.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailsWithPage != null) {
      data['detailsWithPage'] =
          this.detailsWithPage!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['lastPage'] = this.lastPage;
    return data;
  }
}






