class OrgBidingModel {
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
  String? amount;
  String? description;
  int? bidingId;

  OrgBidingModel(
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
        this.amount,
        this.description,
        this.bidingId});

  OrgBidingModel.fromJson(Map<String, dynamic> json) {
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
    amount = json['amount']??"";
    description = json['description']??"";
    bidingId = json['bidingId']??0;
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
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['bidingId'] = this.bidingId;
    return data;
  }
}
