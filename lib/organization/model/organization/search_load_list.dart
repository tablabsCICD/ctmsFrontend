import 'package:flutter_hr_management/organization/model/organization/org_full_load_model.dart';

class LoadListModel {
  List<OrgFullLoadModel>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  LoadListModel(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  LoadListModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <OrgFullLoadModel>[];
      json['content'].forEach((v) {
        content!.add(new OrgFullLoadModel.fromJson(v));
      });
    }
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort']??'';
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}


