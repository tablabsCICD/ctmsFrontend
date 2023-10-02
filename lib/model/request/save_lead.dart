class SaveLeadRequest {
  String? address;
  String? city;
  String? companyName;
  String? coordinator;
  String? date;
  String? emailId;
  int? isEnquiry;
  int? leadAddedBy;
  int? leadAssignedTo;
  String? mobileNumber;
  String? pinCode;
  String? sourceOfLead;
  String? typeOfBusiness;

  SaveLeadRequest(
      {this.address,
        this.city,
        this.companyName,
        this.coordinator,
        this.date,
        this.emailId,
        this.isEnquiry,
        this.leadAddedBy,
        this.leadAssignedTo,
        this.mobileNumber,
        this.pinCode,
        this.sourceOfLead,
        this.typeOfBusiness});

  SaveLeadRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    companyName = json['companyName'];
    coordinator = json['coordinator'];
    date = json['date'];
    emailId = json['emailId'];
    isEnquiry = json['isEnquiry'];
    leadAddedBy = json['leadAddedBy'];
    leadAssignedTo = json['leadAssignedTo'];
    mobileNumber = json['mobileNumber'];
    pinCode = json['pinCode'];
    sourceOfLead = json['sourceOfLead'];
    typeOfBusiness = json['typeOfBusiness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['companyName'] = this.companyName;
    data['coordinator'] = this.coordinator;
    data['date'] = this.date;
    data['emailId'] = this.emailId;
    data['isEnquiry'] = this.isEnquiry;
    data['leadAddedBy'] = this.leadAddedBy;
    data['leadAssignedTo'] = this.leadAssignedTo;
    data['mobileNumber'] = this.mobileNumber;
    data['pinCode'] = this.pinCode;
    data['sourceOfLead'] = this.sourceOfLead;
    data['typeOfBusiness'] = this.typeOfBusiness;
    return data;
  }
}
