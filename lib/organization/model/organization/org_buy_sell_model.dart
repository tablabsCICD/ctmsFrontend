class BuySellModel {
  String? message;
  List<OrgBuySellModel1>? data;
  bool? success;

  BuySellModel({this.message, this.data, this.success});

  BuySellModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <OrgBuySellModel1>[];
      json['data'].forEach((v) {
        data!.add(new OrgBuySellModel1.fromJson(v));
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

class OrgBuySellModel1 {
  int? id;
  String? type;
  String? ownerName;
  String? agentName;
  int? contactNumber;
  String? city;
  String? maker;
  String? model;
  String? mfgYear;
  String? vehicleRegistrationNumber;
  String? yearOfBuying;
  String? conditionOfVehicle;
  String? conditionOfTyres;
  String? insaurancePaidUpto;
  int? estimatedPrice;
  int? negotiable;
  String? additionalInformation;
  String? bodyType;
  int? date;
  String? os;
  String? loggedUserName;
  int? loggedTime;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  int? privatePost;
  String? vehicleInfo;
  String? enginePower;
  String? documents;
  String? weight;
  String? driverType;
  String? transmission;
  String? tableName;
  String? mainTag;
  String? postingTime;
  String? buySelltype;
  String? topicName;

  OrgBuySellModel1(
      {this.id,
        this.type,
        this.ownerName,
        this.agentName,
        this.contactNumber,
        this.city,
        this.maker,
        this.model,
        this.mfgYear,
        this.vehicleRegistrationNumber,
        this.yearOfBuying,
        this.conditionOfVehicle,
        this.conditionOfTyres,
        this.insaurancePaidUpto,
        this.estimatedPrice,
        this.negotiable,
        this.additionalInformation,
        this.bodyType,
        this.date,
        this.os,
        this.loggedUserName,
        this.loggedTime,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.privatePost,
        this.vehicleInfo,
        this.enginePower,
        this.documents,
        this.weight,
        this.driverType,
        this.transmission,
        this.tableName,
        this.mainTag,
        this.postingTime,
        this.buySelltype,
        this.topicName});

  OrgBuySellModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    ownerName = json['ownerName'];
    agentName = json['agentName'];
    contactNumber = json['contactNumber'];
    city = json['city'];
    maker = json['maker'];
    model = json['model'];
    mfgYear = json['mfgYear'];
    vehicleRegistrationNumber = json['vehicleRegistrationNumber'];
    yearOfBuying = json['yearOfBuying'];
    conditionOfVehicle = json['conditionOfVehicle'];
    conditionOfTyres = json['conditionOfTyres'];
    insaurancePaidUpto = json['insaurancePaidUpto'];
    estimatedPrice = json['estimatedPrice'];
    negotiable = json['negotiable'];
    additionalInformation = json['additionalInformation'];
    bodyType = json['bodyType'];
    date = json['date'];
    os = json['os'];
    loggedUserName = json['loggedUserName'];
    loggedTime = json['loggedTime'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    privatePost = json['privatePost'];
    vehicleInfo = json['vehicleInfo'];
    enginePower = json['enginePower'];
    documents = json['documents'];
    weight = json['weight'];
    driverType = json['driverType'];
    transmission = json['transmission'];
    tableName = json['tableName'];
    mainTag = json['mainTag'];
    postingTime = json['postingTime'];
    buySelltype = json['buySelltype'];
    topicName = json['topicName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['ownerName'] = this.ownerName;
    data['agentName'] = this.agentName;
    data['contactNumber'] = this.contactNumber;
    data['city'] = this.city;
    data['maker'] = this.maker;
    data['model'] = this.model;
    data['mfgYear'] = this.mfgYear;
    data['vehicleRegistrationNumber'] = this.vehicleRegistrationNumber;
    data['yearOfBuying'] = this.yearOfBuying;
    data['conditionOfVehicle'] = this.conditionOfVehicle;
    data['conditionOfTyres'] = this.conditionOfTyres;
    data['insaurancePaidUpto'] = this.insaurancePaidUpto;
    data['estimatedPrice'] = this.estimatedPrice;
    data['negotiable'] = this.negotiable;
    data['additionalInformation'] = this.additionalInformation;
    data['bodyType'] = this.bodyType;
    data['date'] = this.date;
    data['os'] = this.os;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['privatePost'] = this.privatePost;
    data['vehicleInfo'] = this.vehicleInfo;
    data['enginePower'] = this.enginePower;
    data['documents'] = this.documents;
    data['weight'] = this.weight;
    data['driverType'] = this.driverType;
    data['transmission'] = this.transmission;
    data['tableName'] = this.tableName;
    data['mainTag'] = this.mainTag;
    data['postingTime'] = this.postingTime;
    data['buySelltype'] = this.buySelltype;
    data['topicName'] = this.topicName;
    return data;
  }
}

class OrgBuySellModel {
  int? id;
  String? type;
  String? ownerName;
  String? agentName;
  int? contactNumber;
  String? city;
  String? maker;
  String? model;
  String? mfgYear;
  String? vehicleRegistrationNumber;
  String? yearOfBuying;
  String? conditionOfVehicle;
  String? conditionOfTyres;
  String? insaurancePaidUpto;
  int? estimatedPrice;
  int? negotiable;
  String? additionalInformation;
  String? bodyType;
  int? date;
  String? os;
  String? loggedUserName;
  int? loggedTime;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  int? privatePost;
  String? vehicleInfo;
  String? enginePower;
  String? documents;
  String? weight;
  String? driverType;
  String? transmission;
  Null? tableName;
  Null? mainTag;
  Null? postingTime;
  Null? buySelltype;
  Null? topicName;

  OrgBuySellModel(
      {this.id,
        this.type,
        this.ownerName,
        this.agentName,
        this.contactNumber,
        this.city,
        this.maker,
        this.model,
        this.mfgYear,
        this.vehicleRegistrationNumber,
        this.yearOfBuying,
        this.conditionOfVehicle,
        this.conditionOfTyres,
        this.insaurancePaidUpto,
        this.estimatedPrice,
        this.negotiable,
        this.additionalInformation,
        this.bodyType,
        this.date,
        this.os,
        this.loggedUserName,
        this.loggedTime,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.privatePost,
        this.vehicleInfo,
        this.enginePower,
        this.documents,
        this.weight,
        this.driverType,
        this.transmission,
        this.tableName,
        this.mainTag,
        this.postingTime,
        this.buySelltype,
        this.topicName});

  OrgBuySellModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    ownerName = json['ownerName'];
    agentName = json['agentName'];
    contactNumber = json['contactNumber'];
    city = json['city'];
    maker = json['maker'];
    model = json['model'];
    mfgYear = json['mfgYear'];
    vehicleRegistrationNumber = json['vehicleRegistrationNumber'];
    yearOfBuying = json['yearOfBuying'];
    conditionOfVehicle = json['conditionOfVehicle'];
    conditionOfTyres = json['conditionOfTyres'];
    insaurancePaidUpto = json['insaurancePaidUpto'];
    estimatedPrice = json['estimatedPrice'];
    negotiable = json['negotiable'];
    additionalInformation = json['additionalInformation'];
    bodyType = json['bodyType'];
    date = json['date'];
    os = json['os'];
    loggedUserName = json['loggedUserName'];
    loggedTime = json['loggedTime'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    privatePost = json['privatePost']??"";
    vehicleInfo = json['vehicleInfo']??"";
    enginePower = json['enginePower']??'';
    documents = json['documents']??'';
    weight = json['weight']??'';
    driverType = json['driverType']??'';
    transmission = json['transmission']??'';
    tableName = json['tableName']??'';
    mainTag = json['mainTag']??"";
    postingTime = json['postingTime']??'';
    buySelltype = json['buySelltype']??'';
    topicName = json['topicName']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['ownerName'] = this.ownerName;
    data['agentName'] = this.agentName;
    data['contactNumber'] = this.contactNumber;
    data['city'] = this.city;
    data['maker'] = this.maker;
    data['model'] = this.model;
    data['mfgYear'] = this.mfgYear;
    data['vehicleRegistrationNumber'] = this.vehicleRegistrationNumber;
    data['yearOfBuying'] = this.yearOfBuying;
    data['conditionOfVehicle'] = this.conditionOfVehicle;
    data['conditionOfTyres'] = this.conditionOfTyres;
    data['insaurancePaidUpto'] = this.insaurancePaidUpto;
    data['estimatedPrice'] = this.estimatedPrice;
    data['negotiable'] = this.negotiable;
    data['additionalInformation'] = this.additionalInformation;
    data['bodyType'] = this.bodyType;
    data['date'] = this.date;
    data['os'] = this.os;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['privatePost'] = this.privatePost;
    data['vehicleInfo'] = this.vehicleInfo;
    data['enginePower'] = this.enginePower;
    data['documents'] = this.documents;
    data['weight'] = this.weight;
    data['driverType'] = this.driverType;
    data['transmission'] = this.transmission;
    data['tableName'] = this.tableName;
    data['mainTag'] = this.mainTag;
    data['postingTime'] = this.postingTime;
    data['buySelltype'] = this.buySelltype;
    data['topicName'] = this.topicName;
    return data;
  }
}


/*
class OrgBuySellModel {
  int? id;
  int? userId;
  String? type;
  String? postingTime;
  String? companyName;
  String? nameOfPerson;
  int? companyRating;
  String? content;
  String? topicName;
  String? tableName;
  String? companyLogo;
  int? partLoadOrNot;
  int? reminderUserName;
  String? sharableLink;
  String? deviceId;
  int? ratings;
  int? mobileNumber;
  String? source;
  String? destination;
  String? mainTag;
  int? privatePost;
  String? makerName;
  String? modelName;
  String? mfgYear;
  String? estPrice;
  int? dnd;
  String? vehicleSize;
  String? association;
  int? isPaid;
  String? website;
  int? alterativeNumber;
  String? companyDetailsName;
  int? isVerifiedByCompany;
  String? typeOfPayment;

  OrgBuySellModel(
      {this.id,
        this.userId,
        this.type,
        this.postingTime,
        this.companyName,
        this.nameOfPerson,
        this.companyRating,
        this.content,
        this.topicName,
        this.tableName,
        this.companyLogo,
        this.partLoadOrNot,
        this.reminderUserName,
        this.sharableLink,
        this.deviceId,
        this.ratings,
        this.mobileNumber,
        this.source,
        this.destination,
        this.mainTag,
        this.privatePost,
        this.makerName,
        this.modelName,
        this.mfgYear,
        this.estPrice,
        this.dnd,
        this.vehicleSize,
        this.association,
        this.isPaid,
        this.website,
        this.alterativeNumber,
        this.companyDetailsName,
        this.isVerifiedByCompany,
        this.typeOfPayment});

  OrgBuySellModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['userId']??0;
    type = json['type']??"";
    postingTime = json['postingTime']??"";
    companyName = json['companyName']??"";
    nameOfPerson = json['nameOfPerson']??"";
    companyRating = json['companyRating']??0;
    content = json['content']??"";
    topicName = json['topicName']??"";
    tableName = json['tableName']??"";
    companyLogo = json['companyLogo']??"";
    partLoadOrNot = json['partLoadOrNot']??0;
    reminderUserName = json['reminderUserName']??0;
    sharableLink = json['sharableLink']??"";
    deviceId = json['deviceId']??"";
    ratings = json['ratings']??0;
    mobileNumber = json['mobileNumber']??0;
    source = json['source']??"";
    destination = json['destination']??"";
    mainTag = json['mainTag']??"";
    privatePost = json['privatePost']??0;
    makerName = json['makerName']??"";
    modelName = json['modelName']??"";
    mfgYear = json['mfgYear']??"";
    estPrice = json['estPrice']??"";
    dnd = json['dnd']??0;
    vehicleSize = json['vehicleSize']??"";
    association = json['association']??"";
    isPaid = json['isPaid']??0;
    website = json['website']??"";
    alterativeNumber = json['alterativeNumber']??0;
    companyDetailsName = json['companyDetailsName']??"";
    isVerifiedByCompany = json['isVerifiedByCompany']??0;
    typeOfPayment = json['typeOfPayment']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['postingTime'] = this.postingTime;
    data['companyName'] = this.companyName;
    data['nameOfPerson'] = this.nameOfPerson;
    data['companyRating'] = this.companyRating;
    data['content'] = this.content;
    data['topicName'] = this.topicName;
    data['tableName'] = this.tableName;
    data['companyLogo'] = this.companyLogo;
    data['partLoadOrNot'] = this.partLoadOrNot;
    data['reminderUserName'] = this.reminderUserName;
    data['sharableLink'] = this.sharableLink;
    data['deviceId'] = this.deviceId;
    data['ratings'] = this.ratings;
    data['mobileNumber'] = this.mobileNumber;
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['mainTag'] = this.mainTag;
    data['privatePost'] = this.privatePost;
    data['makerName'] = this.makerName;
    data['modelName'] = this.modelName;
    data['mfgYear'] = this.mfgYear;
    data['estPrice'] = this.estPrice;
    data['dnd'] = this.dnd;
    data['vehicleSize'] = this.vehicleSize;
    data['association'] = this.association;
    data['isPaid'] = this.isPaid;
    data['website'] = this.website;
    data['alterativeNumber'] = this.alterativeNumber;
    data['companyDetailsName'] = this.companyDetailsName;
    data['isVerifiedByCompany'] = this.isVerifiedByCompany;
    data['typeOfPayment'] = this.typeOfPayment;
    return data;
  }
}
*/
