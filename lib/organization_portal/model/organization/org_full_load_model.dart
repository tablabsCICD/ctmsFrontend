class FullLoadModel {
  int? number;
  int? size;
  int? numberOfElements;
  bool? last;
  int? totalPages;
  dynamic sort;
  List<OrgFullLoadModel>? content;
  bool? first;
  int? totalElements;

  FullLoadModel({
    this.number,
    this.size,
    this.numberOfElements,
    this.last,
    this.totalPages,
    this.sort,
    this.content,
    this.first,
    this.totalElements,
  });

  factory FullLoadModel.fromJson(Map<String, dynamic> json) => FullLoadModel(
    number: json["number"],
    size: json["size"],
    numberOfElements: json["numberOfElements"],
    last: json["last"],
    totalPages: json["totalPages"],
    sort: json["sort"],
    content: json["content"] == null ? [] : List<OrgFullLoadModel>.from(json["content"]!.map((x) => OrgFullLoadModel.fromJson(x))),
    first: json["first"],
    totalElements: json["totalElements"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "size": size,
    "numberOfElements": numberOfElements,
    "last": last,
    "totalPages": totalPages,
    "sort": sort,
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
    "first": first,
    "totalElements": totalElements,
  };
}

class OrgFullLoadModel {
  int? id;
  int? userId;
  String? type;
  String? postingTime;
  String? companyName;
  String? nameOfPerson;
  String? companyRating;
  String? content;
  String? topicName;
  String? tableName;
  String? companyLogo;
  int? partLoadOrNot;
  String? reminderUserName;
  String? sharableLink;
  String? deviceId;
  double? ratings;
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
  String? alterativeNumber;
  String? companyDetailsName;
  String? isVerifiedByCompany;
  String? typeOfPayment;
  int? isverified;
  String? typeName;
  List<String>? images;
  String? description;
  String? title;
  int? likes;
  int? transporterOrAgent;
  String? cargoType;
  String? vehicleWeight;
  String? mobileOrLandline;
  String? category;
  bool? isSharedInGroup;
  int? isOpenForBid;
  String? expireDate;
  int? isRepeat;

  OrgFullLoadModel({
    this.id,
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
    this.typeOfPayment,
    this.isverified,
    this.typeName,
    this.images,
    this.description,
    this.title,
    this.likes,
    this.transporterOrAgent,
    this.cargoType,
    this.vehicleWeight,
    this.mobileOrLandline,
    this.category,
    this.isSharedInGroup,
    this.isOpenForBid,
    this.expireDate,
    this.isRepeat,
  });

  factory OrgFullLoadModel.fromJson(Map<String, dynamic> json) => OrgFullLoadModel(
    id: json["id"],
    userId: json["userId"],
    type: json["type"]??'',
    postingTime: json["postingTime"],
    companyName: json["companyName"]??"",
    nameOfPerson: json["nameOfPerson"]??"",
    companyRating: json["companyRating"],
    content: json["content"],
    topicName: json["topicName"],
    tableName: json["tableName"]??"",
    companyLogo: json["companyLogo"],
    partLoadOrNot: json["partLoadOrNot"],
    reminderUserName: json["reminderUserName"],
    sharableLink: json["sharableLink"],
    deviceId: json["deviceId"]??"",
    ratings: json["ratings"],
    mobileNumber: json["mobileNumber"],
    source: json["source"]??"",
    destination: json["destination"],
    mainTag: json["mainTag"]??"",
    privatePost: json["privatePost"],
    makerName: json["makerName"],
    modelName: json["modelName"],
    mfgYear: json["mfgYear"],
    estPrice: json["estPrice"],
    dnd: json["dnd"],
    vehicleSize: json["vehicleSize"],
    association: json["association"],
    isPaid: json["isPaid"],
    website: json["website"],
    alterativeNumber: json["alterativeNumber"],
    companyDetailsName: json["companyDetailsName"]!,
    isVerifiedByCompany: json["isVerifiedByCompany"],
    typeOfPayment: json["typeOfPayment"]??"",
    isverified: json["isverified"],
    typeName: json["typeName"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    title: json["title"],
    likes: json["likes"],
    transporterOrAgent: json["transporterOrAgent"],
    cargoType:json["cargoType"]??"",
    vehicleWeight: json["vehicleWeight"],
    mobileOrLandline: json["mobileOrLandline"],
    category: json["category"],
    isSharedInGroup: json["isSharedInGroup"],
    isOpenForBid: json["isOpenForBid"],
    expireDate: json["expireDate"],
    isRepeat: json["isRepeat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "type": type,
    "postingTime": postingTime,
    "companyName": companyName,
    "nameOfPerson": nameOfPerson,
    "companyRating": companyRating,
    "content": content,
    "topicName": topicName,
    "tableName": tableName,
    "companyLogo": companyLogo,
    "partLoadOrNot": partLoadOrNot,
    "reminderUserName": reminderUserName,
    "sharableLink": sharableLink,
    "deviceId": deviceId,
    "ratings": ratings,
    "mobileNumber": mobileNumber,
    "source": source,
    "destination": destination,
    "mainTag": mainTag,
    "privatePost": privatePost,
    "makerName": makerName,
    "modelName": modelName,
    "mfgYear": mfgYear,
    "estPrice": estPrice,
    "dnd": dnd,
    "vehicleSize": vehicleSize,
    "association": association,
    "isPaid": isPaid,
    "website": website,
    "alterativeNumber": alterativeNumber,
    "companyDetailsName": companyDetailsName,
    "isVerifiedByCompany": isVerifiedByCompany,
    "typeOfPayment": typeOfPayment,
    "isverified": isverified,
    "typeName": typeName,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "description": description,
    "title": title,
    "likes": likes,
    "transporterOrAgent": transporterOrAgent,
    "cargoType": cargoType,
    "vehicleWeight": vehicleWeight,
    "mobileOrLandline": mobileOrLandline,
    "category": category,
    "isSharedInGroup": isSharedInGroup,
    "isOpenForBid": isOpenForBid,
    "expireDate": expireDate,
    "isRepeat": isRepeat,
  };
}