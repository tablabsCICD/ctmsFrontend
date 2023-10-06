class UpdateEMP {
  String? address;
  String? createdDate;
  String? deviceId;
  String? emailId;
  int? employeeId;
  String? firstName;
  int? id;
  String? image;
  int? isActive;
  bool? isAdmin;
  String? lastName;
  String? mobileNumber;
  String? os;
  String? otp;
  String? password;
  String? status;

  UpdateEMP(
      {this.address,
        this.createdDate,
        this.deviceId,
        this.emailId,
        this.employeeId,
        this.firstName,
        this.id,
        this.image,
        this.isActive,
        this.isAdmin,
        this.lastName,
        this.mobileNumber,
        this.os,
        this.otp,
        this.password,
        this.status});

  UpdateEMP.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    createdDate = json['createdDate'];
    deviceId = json['deviceId'];
    emailId = json['emailId'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    id = json['id'];
    image = json['image'];
    isActive = json['isActive'];
    isAdmin = json['is_admin'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    os = json['os'];
    otp = json['otp'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['createdDate'] = this.createdDate;
    data['deviceId'] = this.deviceId;
    data['emailId'] = this.emailId;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['id'] = this.id;
    data['image'] = this.image;
    data['isActive'] = this.isActive;
    data['is_admin'] = this.isAdmin;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['os'] = this.os;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}
