class BranchResponse {
  String? message;
  Branch? data;
  bool? success;

  BranchResponse({this.message, this.data, this.success});

  BranchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Branch.fromJson(json['data']) : null;
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

class Branch {
  int? id;
  String? branchName;
  String? address;
  String? contact;
  int? employeeId;

  Branch({this.id, this.branchName, this.address, this.contact, this.employeeId});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branchName']??'';
    address = json['address']??'';
    contact = json['contact']??'';
    employeeId = json['employeeId']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchName'] = this.branchName;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['employeeId'] = this.employeeId;
    return data;
  }
}
