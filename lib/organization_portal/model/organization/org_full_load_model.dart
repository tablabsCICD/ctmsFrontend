class FullLoadModel {
  String? message;
  List<OrgFullLoadModel>? data;
  bool? success;

  FullLoadModel({this.message, this.data, this.success});

  FullLoadModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <OrgFullLoadModel>[];
      json['data'].forEach((v) {
        data!.add(new OrgFullLoadModel.fromJson(v));
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

class OrgFullLoadModel {
  int? id;
  int? userId;
  String? type;
  String? postingTime;
  String? companyName;
  String? nameOfPerson;
  double? companyRating;
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
  int? comment;
  int? transporterOrAgent;
  List<String>? postImages;
  List<String>? listOfFullLoadImages;
  String? cargoType;
  String? vehicleWeight;
  int? mobileOrLandline;
  String? category;

  OrgFullLoadModel(
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
        this.category});

  OrgFullLoadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    type = json['type'];
    postingTime = json['postingTime'];
    companyName = json['companyName'];
    nameOfPerson = json['nameOfPerson'];
    companyRating = json['companyRating'];
    content = json['content'];
    topicName = json['topicName'];
    tableName = json['tableName'];
    companyLogo = json['companyLogo'];
    partLoadOrNot = json['partLoadOrNot'];
    reminderUserName = json['reminderUserName'];
    sharableLink = json['sharableLink'];
    deviceId = json['deviceId'];
    ratings = json['ratings'];
    mobileNumber = json['mobileNumber'];
    source = json['source'];
    destination = json['destination'];
    mainTag = json['mainTag'];
    privatePost = json['privatePost'];
    makerName = json['makerName'];
    modelName = json['modelName'];
    mfgYear = json['mfgYear'];
    estPrice = json['estPrice'];
    dnd = json['dnd'];
    vehicleSize = json['vehicleSize'];
    association = json['association'];
    isPaid = json['isPaid'];
    website = json['website'];
    alterativeNumber = json['alterativeNumber'];
    companyDetailsName = json['companyDetailsName'];
    isVerifiedByCompany = json['isVerifiedByCompany'];
    typeOfPayment = json['typeOfPayment'];
    isverified = json['isverified'];
    typeName = json['typeName'];
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    description = json['description'];
    title = json['title'];
    likes = json['likes'];
    comment = json['comment'];
    transporterOrAgent = json['transporterOrAgent'];
    if (json['postImages'] != null) {
      postImages = <String>[];
      json['postImages'].forEach((v) {
        postImages!.add(v);
      });
    }
    if (json['listOfFullLoadImages'] != null) {
      listOfFullLoadImages = <String>[];
      json['listOfFullLoadImages'].forEach((v) {
        listOfFullLoadImages!.add((v));
      });
    }
    cargoType = json['cargoType'];
    vehicleWeight = json['vehicleWeight'];
    mobileOrLandline = json['mobileOrLandline'];
    category = json['category'];
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
    data['isverified'] = this.isverified;
    data['typeName'] = this.typeName;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v).toList();
    }
    data['description'] = this.description;
    data['title'] = this.title;
    data['likes'] = this.likes;
    data['comment'] = this.comment;
    data['transporterOrAgent'] = this.transporterOrAgent;
    if (this.postImages != null) {
      data['postImages'] = this.postImages!.map((v) => v).toList();
    }
    if (this.listOfFullLoadImages != null) {
      data['listOfFullLoadImages'] =
          this.listOfFullLoadImages!.map((v) => v).toList();
    }
    data['cargoType'] = this.cargoType;
    data['vehicleWeight'] = this.vehicleWeight;
    data['mobileOrLandline'] = this.mobileOrLandline;
    data['category'] = this.category;
    return data;
  }
}
