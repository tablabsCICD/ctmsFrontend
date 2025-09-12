

class OrgQuoteModel {
  List<QuoteWithPostDetailList>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  OrgQuoteModel(
      {this.content,
      this.last,
      this.totalPages,
      this.totalElements,
      this.sort,
      this.first,
      this.numberOfElements,
      this.size,
      this.number});

  OrgQuoteModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null && json['content'] is List) {
      content = <QuoteWithPostDetailList>[];
      json['content'].forEach((v) {
        content!.add(new QuoteWithPostDetailList.fromJson(v));
      });
    } else {
      content = []; // fallback if data is "", null, or not a list
    }

    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort'] ?? '';
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}

class QuoteWithPostDetailList {
  GenericCardsDto? genericCardsDto;
  List<BidList>? bidingList;

  QuoteWithPostDetailList({this.genericCardsDto, this.bidingList});

  QuoteWithPostDetailList.fromJson(Map<String, dynamic> json) {
    genericCardsDto = json['genericCardsDto'] != null
        ? new GenericCardsDto.fromJson(json['genericCardsDto'])
        : null;
    if (json['bidings'] != null) {
      bidingList = <BidList>[];
      json['bidings'].forEach((v) {
        bidingList!.add(new BidList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genericCardsDto != null) {
      data['genericCardsDto'] = this.genericCardsDto!.toJson();
    }
    if (this.bidingList != null) {
      data['bidings'] = this.bidingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenericCardsDto {
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
  String? isPaid;
  String? website;
  String? alterativeNumber;
  String? companyDetailsName;
  String? isVerifiedByCompany;
  String? typeOfPayment;
  String? typeName;
  List<String>? images;
  String? description;
  String? title;
  String? likes;
  String? comment;
  List<String>? postImages;
  List<String>? listOfFullLoadImages;

  GenericCardsDto(
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
      this.typeOfPayment,
      this.typeName,
      this.images,
      this.description,
      this.title,
      this.likes,
      this.comment,
      this.postImages,
      this.listOfFullLoadImages});

  GenericCardsDto.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 1;
    userId = json['userId'] ?? 1;
    type = json['type'] ?? '';
    postingTime = json['postingTime'] ?? '';
    companyName = json['companyName'] ?? '';
    nameOfPerson = json['nameOfPerson'] ?? '';
    companyRating = json['companyRating'] ?? '';
    content = json['content'] ?? '';
    topicName = json['topicName'] ?? '';
    tableName = json['tableName'] ?? '';
    companyLogo = json['companyLogo'] ?? '';
    partLoadOrNot = json['partLoadOrNot'] ?? 0;
    reminderUserName = json['reminderUserName'] ?? '';
    sharableLink = json['sharableLink'] ?? '';
    deviceId = json['deviceId'] ?? '';
    ratings = json['ratings'] ?? 0;
    mobileNumber = json['mobileNumber'] ?? 0;
    source = json['source'] ?? '';
    destination = json['destination'] ?? '';
    mainTag = json['mainTag'] ?? '';
    privatePost = json['privatePost'] ?? 0;
    makerName = json['makerName'] ?? '';
    modelName = json['modelName'] ?? '';
    mfgYear = json['mfgYear'] ?? '';
    estPrice = json['estPrice'] ?? '';
    dnd = json['dnd'] ?? 0;
    vehicleSize = json['vehicleSize'] ?? '';
    association = json['association'] ?? '';
    isPaid = json['isPaid'] ?? '';
    website = json['website'] ?? '';
    alterativeNumber = json['alterativeNumber'] ?? '';
    companyDetailsName = json['companyDetailsName'] ?? '';
    isVerifiedByCompany = json['isVerifiedByCompany'] ?? '';
    typeOfPayment = json['typeOfPayment'] ?? '';
    typeName = json['typeName'] ?? '';
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    description = json['description'] ?? '';
    title = json['title'] ?? '';
    likes = json['likes'] ?? '';
    comment = json['comment'] ?? '';
    if (json['postImages'] != null) {
      postImages = <String>[];
      json['postImages'].forEach((v) {
        postImages!.add(v);
      });
    }
    if (json['listOfFullLoadImages'] != null) {
      listOfFullLoadImages = <String>[];
      json['listOfFullLoadImages'].forEach((v) {
        listOfFullLoadImages!.add(v);
      });
    }
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
    data['typeName'] = this.typeName;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v).toList();
    }
    data['description'] = this.description;
    data['title'] = this.title;
    data['likes'] = this.likes;
    data['comment'] = this.comment;
    if (this.postImages != null) {
      data['postImages'] = this.postImages!.map((v) => v).toList();
    }
    if (this.listOfFullLoadImages != null) {
      data['listOfFullLoadImages'] =
          this.listOfFullLoadImages!.map((v) => v).toList();
    }
    return data;
  }
}

class BidList {
  Bidings? bidings;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? companyName;
  int? isVerified;
  int? isPaid;

  BidList(
      {this.bidings,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.companyName,
      this.isVerified,
      this.isPaid});

  BidList.fromJson(Map<String, dynamic> json) {
    bidings =
        json['bidings'] != null ? new Bidings.fromJson(json['bidings']) : null;
    firstName = json['firstName'];
    lastName = json['lastName'];
    profileImage = json['profileImage'];
    companyName = json['companyName'];
    isVerified = json['isVerified'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bidings != null) {
      data['bidings'] = this.bidings!.toJson();
    }
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profileImage'] = this.profileImage;
    data['companyName'] = this.companyName;
    data['isVerified'] = this.isVerified;
    data['isPaid'] = this.isPaid;
    return data;
  }
}

class Bidings {
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
  String? km;
  String? bestMatch;
  String? totalBids;
  bool? status;
  String? endTime;

  Bidings(
      {this.id,
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
      this.km,
      this.bestMatch,
      this.totalBids,
      this.status,
      this.endTime});

  Bidings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailId = json['emailId'];
    userName = json['userName'];
    type = json['type'];
    idOfPost = json['idOfPost'];
    amount = json['amount'];
    description = json['description'];
    bidderUserName = json['bidderUserName'];
    mobileNumber = json['mobileNumber'];
    loggedUserName = json['loggedUserName'];
    loggedTime = json['loggedTime'];
    km = json['km'];
    bestMatch = json['bestMatch'];
    totalBids = json['totalBids'];
    status = json['status'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emailId'] = this.emailId;
    data['userName'] = this.userName;
    data['type'] = this.type;
    data['idOfPost'] = this.idOfPost;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['bidderUserName'] = this.bidderUserName;
    data['mobileNumber'] = this.mobileNumber;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['km'] = this.km;
    data['bestMatch'] = this.bestMatch;
    data['totalBids'] = this.totalBids;
    data['status'] = this.status;
    data['endTime'] = this.endTime;
    return data;
  }
}
