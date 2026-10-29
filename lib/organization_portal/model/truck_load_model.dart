class TruckLoadType {
  List<TruckLoad>? content;
  bool? last;
  int? totalElements;
  int? totalPages;
  int? numberOfElements;
  bool? first;
  dynamic sort;
  int? size;
  int? number;

  TruckLoadType({
    this.content,
    this.last,
    this.totalElements,
    this.totalPages,
    this.numberOfElements,
    this.first,
    this.sort,
    this.size,
    this.number,
  });

  factory TruckLoadType.fromJson(Map<String, dynamic> json) => TruckLoadType(
    content: json["content"] == null ? [] : List<TruckLoad>.from(json["content"]!.map((x) => TruckLoad.fromJson(x))),
    last: json["last"],
    totalElements: json["totalElements"],
    totalPages: json["totalPages"],
    numberOfElements: json["numberOfElements"],
    first: json["first"],
    sort: json["sort"],
    size: json["size"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
    "last": last,
    "totalElements": totalElements,
    "totalPages": totalPages,
    "numberOfElements": numberOfElements,
    "first": first,
    "sort": sort,
    "size": size,
    "number": number,
  };
}

class TruckLoad {
  int? id;
  int? userId;
  String? type;
  String? postingTime;
  String? companyName;
  String? nameOfPerson;
  dynamic companyRating;
  String? content;
  String? topicName;
  String? tableName;
  String? companyLogo;
  int? partLoadOrNot;
  dynamic reminderUserName;
  String? sharableLink;
  String? deviceId;
  double? ratings;
  int? mobileNumber;
  String? source;
  String? destination;
  String? mainTag;
  int? privatePost;
  dynamic makerName;
  dynamic modelName;
  dynamic mfgYear;
  dynamic estPrice;
  int? dnd;
  dynamic vehicleSize;
  dynamic association;
  dynamic isPaid;
  dynamic website;
  dynamic alterativeNumber;
  dynamic companyDetailsName;
  String? isVerifiedByCompany;
  dynamic typeOfPayment;
  int? isverified;
  dynamic typeName;
  List<String>? images;
  dynamic description;
  dynamic title;
  dynamic likes;
  dynamic comment;
  dynamic transporterOrAgent;
  List<dynamic>? postImages;
  List<dynamic>? listOfFullLoadImages;
  dynamic cargoType;
  dynamic vehicleWeight;
  dynamic mobileOrLandline;
  dynamic category;
  dynamic isSharedInGroup;
  int? isOpenForBid;
  String? expireDate;
  int? isRepeat;
  int? ispostOwnerVerifiedForTrack;
  int? isQuoteOwnerVerifiedForTrack;
  int? isCompleted;
  dynamic experience;
  dynamic department;
  dynamic vehicleRegistrationNumber;
  dynamic emailId;
  bool? isPaid99;

  TruckLoad({
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
    this.comment,
    this.transporterOrAgent,
    this.postImages,
    this.listOfFullLoadImages,
    this.cargoType,
    this.vehicleWeight,
    this.mobileOrLandline,
    this.category,
    this.isSharedInGroup,
    this.isOpenForBid,
    this.expireDate,
    this.isRepeat,
    this.ispostOwnerVerifiedForTrack,
    this.isQuoteOwnerVerifiedForTrack,
    this.isCompleted,
    this.experience,
    this.department,
    this.vehicleRegistrationNumber,
    this.emailId,
    this.isPaid99,
  });

  factory TruckLoad.fromJson(Map<String, dynamic> json) => TruckLoad(
    id: json["id"],
    userId: json["userId"],
    type: json["type"],
    postingTime: json["postingTime"].toString() ,
    companyName: json["companyName"],
    nameOfPerson: json["nameOfPerson"],
    companyRating: json["companyRating"],
    content: json["content"],
    topicName: json["topicName"],
    tableName: json["tableName"],
    companyLogo: json["companyLogo"],
    partLoadOrNot: json["partLoadOrNot"],
    reminderUserName: json["reminderUserName"],
    sharableLink: json["sharableLink"],
    deviceId: json["deviceId"],
    ratings: json["ratings"]?.toDouble(),
    mobileNumber: json["mobileNumber"],
    source: json["source"],
    destination: json["destination"],
    mainTag: json["mainTag"],
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
    companyDetailsName: json["companyDetailsName"],
    isVerifiedByCompany: json["isVerifiedByCompany"],
    typeOfPayment: json["typeOfPayment"],
    isverified: json["isverified"],
    typeName: json["typeName"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    title: json["title"],
    likes: json["likes"],
    comment: json["comment"],
    transporterOrAgent: json["transporterOrAgent"],
    postImages: json["postImages"] == null ? [] : List<dynamic>.from(json["postImages"]!.map((x) => x)),
    listOfFullLoadImages: json["listOfFullLoadImages"] == null ? [] : List<dynamic>.from(json["listOfFullLoadImages"]!.map((x) => x)),
    cargoType: json["cargoType"],
    vehicleWeight: json["vehicleWeight"],
    mobileOrLandline: json["mobileOrLandline"],
    category: json["category"],
    isSharedInGroup: json["isSharedInGroup"],
    isOpenForBid: json["isOpenForBid"],
    expireDate: json["expireDate"].toString(),
    isRepeat: json["isRepeat"],
    ispostOwnerVerifiedForTrack: json["ispostOwnerVerifiedForTrack"],
    isQuoteOwnerVerifiedForTrack: json["isQuoteOwnerVerifiedForTrack"],
    isCompleted: json["isCompleted"],
    experience: json["experience"],
    department: json["department"],
    vehicleRegistrationNumber: json["vehicleRegistrationNumber"],
    emailId: json["emailId"],
    isPaid99: json["isPaid99"],
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
    "comment": comment,
    "transporterOrAgent": transporterOrAgent,
    "postImages": postImages == null ? [] : List<dynamic>.from(postImages!.map((x) => x)),
    "listOfFullLoadImages": listOfFullLoadImages == null ? [] : List<dynamic>.from(listOfFullLoadImages!.map((x) => x)),
    "cargoType": cargoType,
    "vehicleWeight": vehicleWeight,
    "mobileOrLandline": mobileOrLandline,
    "category": category,
    "isSharedInGroup": isSharedInGroup,
    "isOpenForBid": isOpenForBid,
    "expireDate": expireDate,
    "isRepeat": isRepeat,
    "ispostOwnerVerifiedForTrack": ispostOwnerVerifiedForTrack,
    "isQuoteOwnerVerifiedForTrack": isQuoteOwnerVerifiedForTrack,
    "isCompleted": isCompleted,
    "experience": experience,
    "department": department,
    "vehicleRegistrationNumber": vehicleRegistrationNumber,
    "emailId": emailId,
    "isPaid99": isPaid99,
  };
}
