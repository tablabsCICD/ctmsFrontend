class MeetingList {
  String? message;
  List<MeetingData>? data;
  bool? success;

  MeetingList({this.message, this.data, this.success});

  MeetingList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MeetingData>[];
      json['data'].forEach((v) {
        data!.add(new MeetingData.fromJson(v));
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

class MeetingData {
  int? id;
  String? title;
  Lead? lead;
  String? meetingLink;
  String? date;
  String? time;
  String? description;
  String? employeeId;
  bool? active;
  CreatedMettingBy? createdMettingBy;

  MeetingData(
      {this.id,
        this.title,
        this.lead,
        this.meetingLink,
        this.date,
        this.time,
        this.description,
        this.employeeId,
        this.active,
        this.createdMettingBy});

  MeetingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    meetingLink = json['meetingLink'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    employeeId = json['employeeId'];
    active = json['active'];
    createdMettingBy = json['createdMettingBy'] != null
        ? new CreatedMettingBy.fromJson(json['createdMettingBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    data['meetingLink'] = this.meetingLink;
    data['date'] = this.date;
    data['time'] = this.time;
    data['description'] = this.description;
    data['employeeId'] = this.employeeId;
    data['active'] = this.active;
    if (this.createdMettingBy != null) {
      data['createdMettingBy'] = this.createdMettingBy!.toJson();
    }
    return data;
  }
}

class Lead {
  int? id;
  String? companyName;
  String? coordinator;
  String? mobileNumber;
  String? emailId;
  String? sourceOfLead;
  String? pinCode;
  String? city;
  String? address;
  String? typeOfBusiness;
  String? date;
  int? isEnquiry;
  String? addLogo;
  bool? isRobinRound;

  Lead(
      {this.id,
        this.companyName,
        this.coordinator,
        this.mobileNumber,
        this.emailId,
        this.sourceOfLead,
        this.pinCode,
        this.city,
        this.address,
        this.typeOfBusiness,
        this.date,
        this.isEnquiry,
        this.addLogo,
        this.isRobinRound});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName']??'';
    coordinator = json['coordinator']??'';
    mobileNumber = json['mobileNumber']??'';
    emailId = json['emailId']??'';
    sourceOfLead = json['sourceOfLead']??'';
    pinCode = json['pinCode']??'';
    city = json['city']??'';
    address = json['address']??"";
    typeOfBusiness = json['typeOfBusiness']??'';
    date = json['date']??'';
    isEnquiry = json['isEnquiry']??1;
    addLogo = json['addLogo']??'';
    isRobinRound = json['isRobinRound']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['coordinator'] = this.coordinator;
    data['mobileNumber'] = this.mobileNumber;
    data['emailId'] = this.emailId;
    data['sourceOfLead'] = this.sourceOfLead;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['address'] = this.address;
    data['typeOfBusiness'] = this.typeOfBusiness;
    data['date'] = this.date;
    data['isEnquiry'] = this.isEnquiry;
    data['addLogo'] = this.addLogo;
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}

class CreatedMettingBy {
  int? id;
  String? employeeId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? address;
  String? image;
  String? designation;
  String? contact;
  String? employeeLocation;
  int? departmentId;
  BoardingDeatails? boardingDeatails;
  dynamic? role;
  dynamic? isAdmin;
  dynamic? isActive;
  dynamic? otp;
  String? password;
  String? os;
  String? status;
  String? deviceId;
  String? createdDate;
  String? securityQuestion;
  String? securityAnswer;

  CreatedMettingBy(
      {this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.address,
        this.image,
        this.designation,
        this.contact,
        this.employeeLocation,
        this.departmentId,
        this.boardingDeatails,
        this.role,
        this.isAdmin,
        this.isActive,
        this.otp,
        this.password,
        this.os,
        this.status,
        this.deviceId,
        this.createdDate,
        this.securityQuestion,
        this.securityAnswer});

  CreatedMettingBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    image = json['image'];
    designation = json['designation'];
    contact = json['contact'];
    employeeLocation = json['employeeLocation'];
    departmentId = json['departmentId'];
    boardingDeatails = json['boardingDeatails'] != null
        ? new BoardingDeatails.fromJson(json['boardingDeatails'])
        : null;
    role = json['role'];
    isAdmin = json['is_admin'];
    isActive = json['isActive'];
    otp = json['otp'];
    password = json['password'];
    os = json['os'];
    status = json['status'];
    deviceId = json['deviceId'];
    createdDate = json['createdDate'];
    securityQuestion = json['securityQuestion'];
    securityAnswer = json['securityAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['address'] = this.address;
    data['image'] = this.image;
    data['designation'] = this.designation;
    data['contact'] = this.contact;
    data['employeeLocation'] = this.employeeLocation;
    data['departmentId'] = this.departmentId;
    if (this.boardingDeatails != null) {
      data['boardingDeatails'] = this.boardingDeatails!.toJson();
    }
    data['role'] = this.role;
    data['is_admin'] = this.isAdmin;
    data['isActive'] = this.isActive;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['os'] = this.os;
    data['status'] = this.status;
    data['deviceId'] = this.deviceId;
    data['createdDate'] = this.createdDate;
    data['securityQuestion'] = this.securityQuestion;
    data['securityAnswer'] = this.securityAnswer;
    return data;
  }
}

class BoardingDeatails {
  int? boardingId;
  String? tenthDCertificate;
  String? twelthCertificate;
  String? degreeCertificate;
  String? aadharCard;
  String? panCard;
  Null? experienceCertificate;
  String? active;
  List<String>? otherDocuments;

  BoardingDeatails(
      {this.boardingId,
        this.tenthDCertificate,
        this.twelthCertificate,
        this.degreeCertificate,
        this.aadharCard,
        this.panCard,
        this.experienceCertificate,
        this.active,
        this.otherDocuments});

  BoardingDeatails.fromJson(Map<String, dynamic> json) {
    boardingId = json['boardingId'];
    tenthDCertificate = json['tenthDCertificate'];
    twelthCertificate = json['twelthCertificate'];
    degreeCertificate = json['degreeCertificate'];
    aadharCard = json['aadharCard'];
    panCard = json['panCard'];
    experienceCertificate = json['experienceCertificate'];
    active = json['active'];
    otherDocuments = json['otherDocuments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boardingId'] = this.boardingId;
    data['tenthDCertificate'] = this.tenthDCertificate;
    data['twelthCertificate'] = this.twelthCertificate;
    data['degreeCertificate'] = this.degreeCertificate;
    data['aadharCard'] = this.aadharCard;
    data['panCard'] = this.panCard;
    data['experienceCertificate'] = this.experienceCertificate;
    data['active'] = this.active;
    data['otherDocuments'] = this.otherDocuments;
    return data;
  }
}
