
class DepartmentDetails {
  int? id;
  String? name;
  String? employeeId;
  String? contact;
  String? active;

  DepartmentDetails(
      {this.id, this.name, this.employeeId, this.contact, this.active});

  DepartmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    employeeId = json['employeeId'];
    contact = json['contact'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['employeeId'] = this.employeeId;
    data['contact'] = this.contact;
    data['active'] = this.active;
    return data;
  }
}