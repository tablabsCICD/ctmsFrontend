class RoleResponse {
  String? message;
  List<RoleData>? data;
  bool? success;

  RoleResponse({this.message, this.data, this.success});

  RoleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RoleData>[];
      json['data'].forEach((v) {
        data!.add(new RoleData.fromJson(v));
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

class RoleData {
  int? id;
  String? name;
  int? isActive;

  RoleData({this.id, this.name, this.isActive});

  RoleData.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??'';
    isActive = json['isActive']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    return data;
  }
}
