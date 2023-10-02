class SaveEmploye {
  String? address;
  String? deviceId;
  String? emailId;
  int? employeeId;
  String? firstName;
  int? isActive;
  String? lastName;
  String? mobileNumber;
  String? os;
  String? otp;
  String? password;
  int? role;

  SaveEmploye(
      {this.address,
        this.deviceId,
        this.emailId,
        this.employeeId,
        this.firstName,
        this.isActive,
        this.lastName,
        this.mobileNumber,
        this.os,
        this.otp,
        this.password,
        this.role});

  SaveEmploye.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    deviceId = json['deviceId'];
    emailId = json['emailId'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    isActive = json['isActive'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    os = json['os'];
    otp = json['otp'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['deviceId'] = this.deviceId;
    data['emailId'] = this.emailId;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['isActive'] = this.isActive;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['os'] = this.os;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['role'] = this.role;
    return data;
  }
}
