class PostLead {
  String? message;
  Data? data;
  bool? success;

  PostLead({this.message, this.data, this.success});

  PostLead.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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
  bool? isRobinRound;

  Data(
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
        this.isRobinRound});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    coordinator = json['coordinator'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    sourceOfLead = json['sourceOfLead'];
    pinCode = json['pinCode'];
    city = json['city'];
    address = json['address'];
    typeOfBusiness = json['typeOfBusiness'];
    date = json['date'];

    isEnquiry = json['isEnquiry'];
    isRobinRound = json['isRobinRound'];
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
    data['isRobinRound'] = this.isRobinRound;
    return data;
  }
}
