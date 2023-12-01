class OrgStaticDataModel {
  String? message;
  Data? data;
  bool? success;

  OrgStaticDataModel({this.message, this.data, this.success});

  OrgStaticDataModel.fromJson(Map<String, dynamic> json) {
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
  int? totalCompanyRegister;
  int? totalLoggedUserNameInFullTruck;
  int? totalLoggedUserNameWithPartLoad;
  int? totalLoggedUserNameInBiding;
  int? totalLoggedUserNameInBuySell;

  Data(
      {this.totalCompanyRegister,
        this.totalLoggedUserNameInFullTruck,
        this.totalLoggedUserNameWithPartLoad,
        this.totalLoggedUserNameInBiding,
        this.totalLoggedUserNameInBuySell});

  Data.fromJson(Map<String, dynamic> json) {
    totalCompanyRegister = json['totalCompanyRegister'];
    totalLoggedUserNameInFullTruck = json['totalLoggedUserNameInFullTruck'];
    totalLoggedUserNameWithPartLoad = json['totalLoggedUserNameWithPartLoad'];
    totalLoggedUserNameInBiding = json['totalLoggedUserNameInBiding'];
    totalLoggedUserNameInBuySell = json['totalLoggedUserNameInBuySell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCompanyRegister'] = this.totalCompanyRegister;
    data['totalLoggedUserNameInFullTruck'] =
        this.totalLoggedUserNameInFullTruck;
    data['totalLoggedUserNameWithPartLoad'] =
        this.totalLoggedUserNameWithPartLoad;
    data['totalLoggedUserNameInBiding'] = this.totalLoggedUserNameInBiding;
    data['totalLoggedUserNameInBuySell'] = this.totalLoggedUserNameInBuySell;
    return data;
  }
}


/*
class OrgStaticDataModel {
  OrgStaticDataModel({
    required this.numberOfEmployees,
    required this.numberOfFullLoadPosts,
    required this.numberOfBids,
    required this.numberOfBuySellPosts,
    required this.numberOfPoolPurchase,
    required this.listOfUsers,
    required this.listOfFullTruckLoad,
    required this.listOfBulkBuySell,
    required this.listOfBuySell,
    required this.listOfBiding,
  });
  late final int numberOfEmployees;
  late final int numberOfFullLoadPosts;
  late final int numberOfBids;
  late final int numberOfBuySellPosts;
  late final int numberOfPoolPurchase;
  late final List<ListOfUsers> listOfUsers;
  late final List<ListOfFullTruckLoad> listOfFullTruckLoad;
  late final List<ListOfBulkBuySell> listOfBulkBuySell;
  late final List<ListOfBuySell> listOfBuySell;
  late final List<ListOfBiding> listOfBiding;

  OrgStaticDataModel.fromJson(Map<String, dynamic> json){
    numberOfEmployees = json['numberOfEmployees']??0;
    numberOfFullLoadPosts = json['numberOfFullLoadPosts']??0;
    numberOfBids = json['numberOfBids']??0;
    numberOfBuySellPosts = json['numberOfBuySellPosts']??0;
    numberOfPoolPurchase = json['numberOfPoolPurchase']??0;
    listOfUsers = List.from(json['listOfUsers']).map((e)=>ListOfUsers.fromJson(e)).toList();
    listOfFullTruckLoad = List.from(json['listOfFullTruckLoad']).map((e)=>ListOfFullTruckLoad.fromJson(e)).toList();
    listOfBulkBuySell = List.from(json['listOfBulkBuySell']).map((e)=>ListOfBulkBuySell.fromJson(e)).toList();
    listOfBuySell = List.from(json['listOfBuySell']).map((e)=>ListOfBuySell.fromJson(e)).toList();
    listOfBiding = List.from(json['listOfBiding']).map((e)=>ListOfBiding.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['numberOfEmployees'] = numberOfEmployees;
    _data['numberOfFullLoadPosts'] = numberOfFullLoadPosts;
    _data['numberOfBids'] = numberOfBids;
    _data['numberOfBuySellPosts'] = numberOfBuySellPosts;
    _data['numberOfPoolPurchase'] = numberOfPoolPurchase;
    _data['listOfUsers'] = listOfUsers.map((e)=>e.toJson()).toList();
    _data['listOfFullTruckLoad'] = listOfFullTruckLoad.map((e)=>e.toJson()).toList();
    _data['listOfBulkBuySell'] = listOfBulkBuySell.map((e)=>e.toJson()).toList();
    _data['listOfBuySell'] = listOfBuySell.map((e)=>e.toJson()).toList();
    _data['listOfBiding'] = listOfBiding.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListOfUsers {
  ListOfUsers({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.mobileNumber,
    required this.companyName,
    required this.companyAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.landlineNumber,
    required this.mainBranch,
    required this.idOfMainBranch,
    required this.verified,
    required this.companyLogo,
    required this.aadharCard,
    required this.otp,
    required this.ratings,
    required this.numberOfTimesRating,
    required this.password,
    required this.deviceId,
    this.profilePicture,
    required this.os,
    this.loggedUserName,
    required this.loggedTime,
    required this.transporterOrAgent,
    required this.preferredRouresEntered,
    required this.isPaid,
    this.paidStartDate,
    this.validTill,
    required this.website,
    this.alternativeNumber,
    required this.companyId,
    required this.isUserVerifiedByCompany,
  });
  late final int? id;
  late final String? userName;
  late final String? firstName;
  late final String? lastName;
  late final String? emailId;
  late final int? mobileNumber;
  late final String? companyName;
  late final String? companyAddress;
  late final String? city;
  late final String? state;
  late final String? country;
  late final int? landlineNumber;
  late final int? mainBranch;
  late final int? idOfMainBranch;
  late final int? verified;
  late final String? companyLogo;
  late final String? aadharCard;
  late final String? otp;
  late final double? ratings;
  late final int? numberOfTimesRating;
  late final String? password;
  late final String? deviceId;
  late final String? profilePicture;
  late final String? os;
  late final String? loggedUserName;
  late final int? loggedTime;
  late final int? transporterOrAgent;
  late final int? preferredRouresEntered;
  late final int? isPaid;
  late final String? paidStartDate;
  late final String? validTill;
  late final String? website;
  late final String? alternativeNumber;
  late final int? companyId;
  late final int? isUserVerifiedByCompany;
  late final String? aadharCardForVerification;
  late final String? panCardForVerification;

  ListOfUsers.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    userName = json['userName']??'';
    firstName = json['firstName']??'';
    lastName = json['lastName']??'';
    emailId = json['emailId']??'';
    mobileNumber = json['mobileNumber']??0;
    companyName = json['companyName']??'';
    companyAddress = json['companyAddress']??'';
    city = json['city']??'';
    state = json['state']??'';
    country = json['country']??'';
    landlineNumber = json['landlineNumber']??0;
    mainBranch = json['mainBranch']??0;
    idOfMainBranch = json['idOfMainBranch']??0;
    verified = json['verified']??0;
    companyLogo = json['companyLogo']??'';
    aadharCard = json['aadharCard']??'';
    otp = json['otp']??
    '';
    ratings = json['ratings']??0.0;
    numberOfTimesRating = json['numberOfTimesRating']??0;
    password = json['password']??'';
    deviceId = json['deviceId']??'';
    profilePicture = json['profilePicture']??'';
    os = json['os']??'';
    loggedUserName = json['loggedUserName']??'';
    loggedTime = json['loggedTime']??0;
    transporterOrAgent = json['transporterOrAgent']??0;
    preferredRouresEntered = json['preferredRouresEntered']??0;
    isPaid = json['isPaid']??0;
    paidStartDate = json['paidStartDate']??'';
    validTill = json['validTill']??'';
    website = json['website']??'';
    alternativeNumber = json['alternativeNumber']??"";
    companyId = json['companyId']??0;
    isUserVerifiedByCompany = json['isUserVerifiedByCompany']??0;
    aadharCardForVerification = json['aadharCardForVerification']??"";
    panCardForVerification = json['panCardForVerification']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userName'] = userName;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['emailId'] = emailId;
    _data['mobileNumber'] = mobileNumber;
    _data['companyName'] = companyName;
    _data['companyAddress'] = companyAddress;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['landlineNumber'] = landlineNumber;
    _data['mainBranch'] = mainBranch;
    _data['idOfMainBranch'] = idOfMainBranch;
    _data['verified'] = verified;
    _data['companyLogo'] = companyLogo;
    _data['aadharCard'] = aadharCard;
    _data['otp'] = otp;
    _data['ratings'] = ratings;
    _data['numberOfTimesRating'] = numberOfTimesRating;
    _data['password'] = password;
    _data['deviceId'] = deviceId;
    _data['profilePicture'] = profilePicture;
    _data['os'] = os;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['transporterOrAgent'] = transporterOrAgent;
    _data['preferredRouresEntered'] = preferredRouresEntered;
    _data['isPaid'] = isPaid;
    _data['paidStartDate'] = paidStartDate;
    _data['validTill'] = validTill;
    _data['website'] = website;
    _data['alternativeNumber'] = alternativeNumber;
    _data['companyId'] = companyId;
    _data['isUserVerifiedByCompany'] = isUserVerifiedByCompany;
    _data['aadharCardForVerification'] = aadharCardForVerification;
    _data['panCardForVerification'] = panCardForVerification;
    return _data;
  }
}

class ListOfFullTruckLoad {
  ListOfFullTruckLoad({
    required this.id,
    required this.fullLoadChoice,
    required this.transporterOrCustomerName,
    required this.contactNumber,
    required this.emailId,
    required this.source,
    required this.destination,
    required this.typeOfCargo,
    required this.otherDetails,
    required this.vehicleSize,
    required this.loadWeight,
    required this.instructions,
    required this.partLoad,
    this.date,
    required this.os,
    required this.loggedUserName,
    required this.loggedTime,
    required this.privatePost,
    required this.dnd,
    required this.typeOfPayment,
    this.tableName,
    this.mainTag,
    this.postingTime,
    this.type,
    this.topicName,
    this.rating,
  });
  late final int? id;
  late final String? fullLoadChoice;
  late final String? transporterOrCustomerName;
  late final int? contactNumber;
  late final String? emailId;
  late final String? source;
  late final String? destination;
  late final String? typeOfCargo;
  late final String? otherDetails;
  late final String? vehicleSize;
  late final String? loadWeight;
  late final String? instructions;
  late final int? partLoad;
  late final String? date;
  late final String? os;
  late final String? loggedUserName;
  late final int? loggedTime;
  late final int? privatePost;
  late final int? dnd;
  late final String? typeOfPayment;
  late final String? tableName;
  late final String? mainTag;
  late final String? postingTime;
  late final String? type;
  late final String? topicName;
  late final int? rating;

  ListOfFullTruckLoad.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    fullLoadChoice = json['fullLoadChoice']??'';
    transporterOrCustomerName = json['transporterOrCustomerName']??'';
    contactNumber = json['contactNumber']??0;
    emailId = json['emailId']??'';
    source = json['source']??'';
    destination = json['destination']??'';
    typeOfCargo = json['typeOfCargo']??'';
    otherDetails = json['otherDetails']??'';
    vehicleSize = json['vehicleSize']??'';
    loadWeight = json['loadWeight']??'';
    instructions = json['instructions']??'';
    partLoad = json['partLoad']??0;
    date = json['typeOfPayment']??'';
    os = json['os']??'';
    loggedUserName = json['loggedUserName']??'';
    loggedTime = json['loggedTime']??0;
    privatePost = json['privatePost']??0;
    dnd = json['dnd']??0;
    typeOfPayment = json['typeOfPayment']??'';
    tableName = json['tableName']??'';
    mainTag = json['mainTag']??'';
    postingTime = json['postingTime']??'';
    type = json['type']??'';
    topicName = json['topicName']??'';
    rating = json['rating']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullLoadChoice'] = fullLoadChoice;
    _data['transporterOrCustomerName'] = transporterOrCustomerName;
    _data['contactNumber'] = contactNumber;
    _data['emailId'] = emailId;
    _data['source'] = source;
    _data['destination'] = destination;
    _data['typeOfCargo'] = typeOfCargo;
    _data['otherDetails'] = otherDetails;
    _data['vehicleSize'] = vehicleSize;
    _data['loadWeight'] = loadWeight;
    _data['instructions'] = instructions;
    _data['partLoad'] = partLoad;
    _data['date'] = date;
    _data['os'] = os;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['privatePost'] = privatePost;
    _data['dnd'] = dnd;
    _data['typeOfPayment'] = typeOfPayment;
    _data['tableName'] = tableName;
    _data['mainTag'] = mainTag;
    _data['postingTime'] = postingTime;
    _data['type'] = type;
    _data['topicName'] = topicName;
    _data['rating'] = rating;
    return _data;
  }
}

class ListOfBulkBuySell {
  ListOfBulkBuySell({
    required this.id,
    required this.type,
    required this.ownerName,
    required this.agentName,
    required this.contactNumber,
    required this.city,
    required this.emailId,
    required this.purchaseItem,
    required this.description,
    required this.purchasePlannedDate,
    required this.loggedUserName,
    required this.loggedTime,
    required this.privatePost,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.profilePicture,
  });
  late final int? id;
  late final String? type;
  late final String? ownerName;
  late final String? agentName;
  late final int? contactNumber;
  late final String? city;
  late final String? emailId;
  late final String? purchaseItem;
  late final String? description;
  late final String? purchasePlannedDate;
  late final String? loggedUserName;
  late final int? loggedTime;
  late final int? privatePost;
  late final String? firstName;
  late final String? lastName;
  late final String? mobileNumber;
  late final String? profilePicture;

  ListOfBulkBuySell.fromJson(Map<String, dynamic> json){
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
    mobileNumber = json['mobileNumber']??'';
    profilePicture = json['profilePicture']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['ownerName'] = ownerName;
    _data['agentName'] = agentName;
    _data['contactNumber'] = contactNumber;
    _data['city'] = city;
    _data['emailId'] = emailId;
    _data['purchaseItem'] = purchaseItem;
    _data['description'] = description;
    _data['purchasePlannedDate'] = purchasePlannedDate;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['privatePost'] = privatePost;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['mobileNumber'] = mobileNumber;
    _data['profilePicture'] = profilePicture;
    return _data;
  }
}

class ListOfBuySell {
  ListOfBuySell({
    required this.id,
    required this.type,
    required this.ownerName,
    required this.agentName,
    required this.contactNumber,
    required this.city,
    required this.maker,
    required this.model,
    required this.mfgYear,
    required this.vehicleRegistrationNumber,
    required this.yearOfBuying,
    required this.conditionOfVehicle,
    required this.conditionOfTyres,
    required this.insaurancePaidUpto,
    required this.estimatedPrice,
    required this.negotiable,
    required this.additionalInformation,
    required this.bodyType,
    required this.date,
    required this.os,
    required this.loggedUserName,
    required this.loggedTime,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.privatePost,
    this.tableName,
    this.mainTag,
    this.postingTime,
    this.buySelltype,
    this.topicName,
  });
  late final int? id;
  late final String? type;
  late final String? ownerName;
  late final String? agentName;
  late final int? contactNumber;
  late final String? city;
  late final String? maker;
  late final String? model;
  late final String? mfgYear;
  late final String? vehicleRegistrationNumber;
  late final String? yearOfBuying;
  late final String? conditionOfVehicle;
  late final String? conditionOfTyres;
  late final String? insaurancePaidUpto;
  late final int? estimatedPrice;
  late final int? negotiable;
  late final String? additionalInformation;
  late final String? bodyType;
  late final int? date;
  late final String? os;
  late final String? loggedUserName;
  late final int? loggedTime;
  late final String? image1;
  late final String? image2;
  late final String? image3;
  late final String? image4;
  late final int? privatePost;
  late final String? tableName;
  late final String? mainTag;
  late final String? postingTime;
  late final String? buySelltype;
  late final String? topicName;

  ListOfBuySell.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    type = json['type']??"";
    ownerName = json['ownerName']??"";
    agentName = json['agentName']??"";
    contactNumber = json['contactNumber']??0;
    city = json['city']??"";
    maker = json['maker']??"";
    model = json['model']??"";
    mfgYear = json['mfgYear']??"";
    vehicleRegistrationNumber = json['vehicleRegistrationNumber']??"";
    yearOfBuying = json['yearOfBuying']??"";
    conditionOfVehicle = json['conditionOfVehicle']??"";
    conditionOfTyres = json['conditionOfTyres']??"";
    insaurancePaidUpto = json['insaurancePaidUpto']??"";
    estimatedPrice = json['estimatedPrice']??0;
    negotiable = json['negotiable']??0;
    additionalInformation = json['additionalInformation']??"";
    bodyType = json['bodyType']??"";
    date = json['date']??0;
    os = json['os']??"";
    loggedUserName = json['loggedUserName']??"";
    loggedTime = json['loggedTime']??0;
    image1 = json['image1']??"";
    image2 = json['image2']??"";
    image3 = json['image3']??"";
    image4 = json['image4']??"";
    privatePost = json['privatePost']??0;
    tableName = json['tableName']??"";
    mainTag = json['mainTag']??"";
    postingTime = json['postingTime']??"";
    buySelltype = json['buySelltype']??"";
    topicName = json['topicName']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['ownerName'] = ownerName;
    _data['agentName'] = agentName;
    _data['contactNumber'] = contactNumber;
    _data['city'] = city;
    _data['maker'] = maker;
    _data['model'] = model;
    _data['mfgYear'] = mfgYear;
    _data['vehicleRegistrationNumber'] = vehicleRegistrationNumber;
    _data['yearOfBuying'] = yearOfBuying;
    _data['conditionOfVehicle'] = conditionOfVehicle;
    _data['conditionOfTyres'] = conditionOfTyres;
    _data['insaurancePaidUpto'] = insaurancePaidUpto;
    _data['estimatedPrice'] = estimatedPrice;
    _data['negotiable'] = negotiable;
    _data['additionalInformation'] = additionalInformation;
    _data['bodyType'] = bodyType;
    _data['date'] = date;
    _data['os'] = os;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['image1'] = image1;
    _data['image2'] = image2;
    _data['image3'] = image3;
    _data['image4'] = image4;
    _data['privatePost'] = privatePost;
    _data['tableName'] = tableName;
    _data['mainTag'] = mainTag;
    _data['postingTime'] = postingTime;
    _data['buySelltype'] = buySelltype;
    _data['topicName'] = topicName;
    return _data;
  }
}

class ListOfBiding {
  ListOfBiding({
    required this.id,
    required this.emailId,
    required this.userName,
    required this.type,
    required this.idOfPost,
    required this.amount,
    required this.description,
    required this.bidderUserName,
    required this.mobileNumber,
    required this.loggedUserName,
    required this.loggedTime,
  });
  late final int? id;
  late final String? emailId;
  late final String? userName;
  late final String? type;
  late final int? idOfPost;
  late final String? amount;
  late final String? description;
  late final String? bidderUserName;
  late final int? mobileNumber;
  late final String? loggedUserName;
  late final int? loggedTime;

  ListOfBiding.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    emailId = json['emailId']??"";
    userName = json['userName']??"";
    type = json['type']??"";
    idOfPost = json['idOfPost']??0;
    amount = json['amount']??'';
    description = json['description']??"";
    bidderUserName = json['bidderUserName']??"";
    mobileNumber = json['mobileNumber']??0;
    loggedUserName = json['loggedUserName']??"";
    loggedTime = json['loggedTime']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['emailId'] = emailId;
    _data['userName'] = userName;
    _data['type'] = type;
    _data['idOfPost'] = idOfPost;
    _data['amount'] = amount;
    _data['description'] = description;
    _data['bidderUserName'] = bidderUserName;
    _data['mobileNumber'] = mobileNumber;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    return _data;
  }
}*/
