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