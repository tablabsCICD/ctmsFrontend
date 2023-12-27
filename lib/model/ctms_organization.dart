class CtmsOrganization {
  int? id;
  bool? active;
  String? city;
  String? orgAddress;
  String? orgMobileNumber;
  String? orgName;
  String? gstNumber;
  String? gstNumber2;
  int? isVerified;
  String? landLineNumber;
  String? officialEmailId;
  String? panCardNumber;
  String? state;
  String? tanCardNumber;
  String? typeOfRegistration;
  String? website;
  String? logo;
  String? unloadingLogo;
  String? invoiceLogo;
  String? emailId;
  String? description;
  String? instructions;

  CtmsOrganization(
      {this.id,
        this.active,
        this.city,
        this.orgAddress,
        this.orgMobileNumber,
        this.orgName,
        this.gstNumber,
        this.gstNumber2,
        this.isVerified,
        this.landLineNumber,
        this.officialEmailId,
        this.panCardNumber,
        this.state,
        this.tanCardNumber,
        this.typeOfRegistration,
        this.website,
        this.logo,
        this.unloadingLogo,
        this.invoiceLogo,
        this.emailId,
        this.description,
        this.instructions});

  CtmsOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    city = json['city']??"";
    orgAddress = json['orgAddress']??"";
    orgMobileNumber = json['orgMobileNumber']??"";
    orgName = json['orgName']??"";
    gstNumber = json['gstNumber']??"";
    gstNumber2 = json['gstNumber2']??"";
    isVerified = json['isVerified']??"";
    landLineNumber = json['landLineNumber']??"";
    officialEmailId = json['officialEmailId']??'';
    panCardNumber = json['panCardNumber']??"";
    state = json['state']??"";
    tanCardNumber = json['tanCardNumber']??'';
    typeOfRegistration = json['typeOfRegistration']??"";
    website = json['website']??"";
    logo = json['logo']??"";
    unloadingLogo = json['unloadingLogo']??"";
    invoiceLogo = json['invoiceLogo']??"";
    emailId = json['emailId']??"";
    description = json['description']??"";
    instructions = json['instructions']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['city'] = this.city;
    data['orgAddress'] = this.orgAddress;
    data['orgMobileNumber'] = this.orgMobileNumber;
    data['orgName'] = this.orgName;
    data['gstNumber'] = this.gstNumber;
    data['gstNumber2'] = this.gstNumber2;
    data['isVerified'] = this.isVerified;
    data['landLineNumber'] = this.landLineNumber;
    data['officialEmailId'] = this.officialEmailId;
    data['panCardNumber'] = this.panCardNumber;
    data['state'] = this.state;
    data['tanCardNumber'] = this.tanCardNumber;
    data['typeOfRegistration'] = this.typeOfRegistration;
    data['website'] = this.website;
    data['logo'] = this.logo;
    data['unloadingLogo'] = this.unloadingLogo;
    data['invoiceLogo'] = this.invoiceLogo;
    data['emailId'] = this.emailId;
    data['description'] = this.description;
    data['instructions'] = this.instructions;
    return data;
  }
}