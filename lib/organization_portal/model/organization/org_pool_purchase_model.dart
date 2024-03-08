class OrgPoolPurchaseModel {
  int? id;
  String? type;
  String? ownerName;
  String? agentName;
  int? contactNumber;
  String? city;
  String? emailId;
  String? purchaseItem;
  String? description;
  String? purchasePlannedDate;
  String? loggedUserName;
  int? loggedTime;
  int? privatePost;
  String? firstName;
  String? lastName;
  int? mobileNumber;
  String? profilePicture;

  OrgPoolPurchaseModel(
      {this.id,
        this.type,
        this.ownerName,
        this.agentName,
        this.contactNumber,
        this.city,
        this.emailId,
        this.purchaseItem,
        this.description,
        this.purchasePlannedDate,
        this.loggedUserName,
        this.loggedTime,
        this.privatePost,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.profilePicture});

  OrgPoolPurchaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    type = json['type']??'';
    ownerName = json['ownerName']??'';
    agentName = json['agentName']??'';
    contactNumber = json['contactNumber']??0;
    city = json['city']??'';
    emailId = json['emailId']??'';
    purchaseItem = json['purchaseItem']??'';
    description = json['description']??'';
    purchasePlannedDate = json['purchasePlannedDate']??'';
    loggedUserName = json['loggedUserName']??'';
    loggedTime = json['loggedTime']??0;
    privatePost = json['privatePost']??0;
    firstName = json['firstName']??'';
    lastName = json['lastName']??'';
    mobileNumber = json['mobileNumber']??0;
    profilePicture = json['profilePicture']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['ownerName'] = this.ownerName;
    data['agentName'] = this.agentName;
    data['contactNumber'] = this.contactNumber;
    data['city'] = this.city;
    data['emailId'] = this.emailId;
    data['purchaseItem'] = this.purchaseItem;
    data['description'] = this.description;
    data['purchasePlannedDate'] = this.purchasePlannedDate;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['privatePost'] = this.privatePost;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
