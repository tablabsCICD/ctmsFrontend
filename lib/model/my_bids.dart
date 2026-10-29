

class MyPostBids {
  List<PostBidData>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  MyPostBids(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  MyPostBids.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <PostBidData>[];
      json['content'].forEach((v) {
        content!.add(PostBidData.fromJson(v));
      });
    }
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'];
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    data['last'] = last;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['sort'] = sort;
    data['first'] = first;
    data['numberOfElements'] = numberOfElements;
    data['size'] = size;
    data['number'] = number;
    return data;
  }
}

class PostBidData {
  GenericCardsDto? genericCardsDto;
  List<BidingDetails>? bidings;

  PostBidData({this.genericCardsDto, this.bidings});

  PostBidData.fromJson(Map<String, dynamic> json) {
    genericCardsDto = json['genericCardsDto'] != null
        ? GenericCardsDto.fromJson(json['genericCardsDto'])
        : null;
    if (json['bidings'] != null) {
      bidings = <BidingDetails>[];
      json['bidings'].forEach((v) {
        bidings!.add(BidingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genericCardsDto != null) {
      data['genericCardsDto'] = genericCardsDto!.toJson();
    }
    if (bidings != null) {
      data['bidings'] = bidings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BidingDetails {
  Bid? bidings;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? companyName;
  int? isVerified;
  int? isPaid;
  int? isAccepted;
  dynamic vehicleNumber;
  dynamic driverContact;

  BidingDetails({
    this.bidings,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.companyName,
    this.isVerified,
    this.isPaid,
    this.isAccepted,
    this.vehicleNumber,
    this.driverContact,
  });

  factory BidingDetails.fromJson(Map<String, dynamic> json) => BidingDetails(
    bidings: json["bidings"] == null ? null : Bid.fromJson(json["bidings"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    profileImage: json["profileImage"],
    companyName: json["companyName"],
    isVerified: json["isVerified"],
    isPaid: json["isPaid"],
    isAccepted: json["isAccepted"],
    vehicleNumber: json["vehicleNumber"],
    driverContact: json["driverContact"],
  );

  Map<String, dynamic> toJson() => {
    "bidings": bidings?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "profileImage": profileImage,
    "companyName": companyName,
    "isVerified": isVerified,
    "isPaid": isPaid,
    "isAccepted": isAccepted,
    "vehicleNumber": vehicleNumber,
    "driverContact": driverContact,
  };
}

class Bid {
  int? id;
  String? emailId;
  String? userName;
  String? type;
  int? idOfPost;
  String? amount;
  String? description;
  String? bidderUserName;
  int? mobileNumber;
  String? loggedUserName;
  int? loggedTime;
  int? isAccepted;

  Bid({
    this.id,
    this.emailId,
    this.userName,
    this.type,
    this.idOfPost,
    this.amount,
    this.description,
    this.bidderUserName,
    this.mobileNumber,
    this.loggedUserName,
    this.loggedTime,
    this.isAccepted,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    id: json["id"],
    emailId: json["emailId"],
    userName: json["userName"],
    type: json["type"],
    idOfPost: json["idOfPost"],
    amount: json["amount"],
    description: json["description"],
    bidderUserName: json["bidderUserName"],
    mobileNumber: json["mobileNumber"],
    loggedUserName: json["loggedUserName"],
    loggedTime: json["loggedTime"],
    isAccepted: json["isAccepted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "emailId": emailId,
    "userName": userName,
    "type": type,
    "idOfPost": idOfPost,
    "amount": amount,
    "description": description,
    "bidderUserName": bidderUserName,
    "mobileNumber": mobileNumber,
    "loggedUserName": loggedUserName,
    "loggedTime": loggedTime,
    "isAccepted": isAccepted,
  };
}

class GenericCardsDto {
  int? id;
  int? userId;
  String? type;
  DateTime? postingTime;
  String? companyName;
  String? nameOfPerson;
  dynamic companyRating;
  String? content;
  String? topicName;
  String? tableName;
  String? companyLogo;
  int? partLoadOrNot;
  dynamic reminderUserName;
  dynamic sharableLink;
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
  String? cargoType;
  String? vehicleWeight;
  dynamic mobileOrLandline;
  dynamic category;
  dynamic isSharedInGroup;
  int? isOpenForBid;
  dynamic expireDate;
  int? isRepeat;
  int? ispostOwnerVerifiedForTrack;
  int? isQuoteOwnerVerifiedForTrack;
  int? isCompleted;
  dynamic experience;
  dynamic department;
  dynamic vehicleRegistrationNumber;
  dynamic emailId;
  bool? isPaid99;

  GenericCardsDto({
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

  factory GenericCardsDto.fromJson(Map<String, dynamic> json) => GenericCardsDto(
    id: json["id"],
    userId: json["userId"],
    type: json["type"],
    postingTime: json["postingTime"] == null ? null : DateTime.parse(json["postingTime"]),
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
    expireDate: json["expireDate"],
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
    "postingTime": postingTime?.toIso8601String(),
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
