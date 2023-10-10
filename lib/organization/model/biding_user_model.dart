class BidingUserModel {
  BidingUserModel({
    required this.content,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    this.sort,
    required this.first,
    required this.numberOfElements,
    required this.size,
    required this.number,
  });
  late final List<BidingUser> content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int? sort;
  late final bool first;
  late final int numberOfElements;
  late final int size;
  late final int number;

  BidingUserModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>BidingUser.fromJson(e)).toList();
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    sort = json['sort']??0;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['sort'] = sort;
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['size'] = size;
    _data['number'] = number;
    return _data;
  }
}

class BidingUser {
  BidingUser({
    required this.id,
    required this.userId,
    required this.type,
    required this.postingTime,
    required this.companyName,
    required this.nameOfPerson,
    this.companyRating,
    this.content,
    required this.topicName,
    required this.tableName,
    this.companyLogo,
    required this.partLoadOrNot,
    this.reminderUserName,
    this.sharableLink,
    required this.deviceId,
    required this.ratings,
    required this.mobileNumber,
    required this.source,
    required this.destination,
    required this.mainTag,
    required this.privatePost,
    required this.amount,
    required this.description,
    required this.bidingId,
  });
  late final int id;
  late final int userId;
  late final String type;
  late final String postingTime;
  late final String companyName;
  late final String nameOfPerson;
  late final int? companyRating;
  late final String? content;
  late final String topicName;
  late final String tableName;
  late final String? companyLogo;
  late final int partLoadOrNot;
  late final String? reminderUserName;
  late final String? sharableLink;
  late final String deviceId;
  late final double? ratings;
  late final int mobileNumber;
  late final String source;
  late final String destination;
  late final String mainTag;
  late final int privatePost;
  late final String amount;
  late final String description;
  late final int bidingId;

  BidingUser.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    userId = json['userId']??0;
    type = json['type']??'';
    postingTime = json['postingTime']??'';
    companyName = json['companyName']??'';
    nameOfPerson = json['nameOfPerson']??"";
    companyRating = json['companyRating']??0;
    content =json['content']??'';
    topicName = json['topicName']??'';
    tableName = json['tableName']??'';
    companyLogo = json['companyLogo']??'';;
    partLoadOrNot = json['partLoadOrNot']??0;
    reminderUserName = json['reminderUserName']??'';
    sharableLink = json['sharableLink']??'';
    deviceId = json['deviceId']??'';
    ratings = json['ratings']??0.0;
    mobileNumber = json['mobileNumber']??0;
    source = json['source']??'';
    destination = json['destination']??'';
    mainTag = json['mainTag']??'';
    privatePost = json['privatePost']??0;
    amount = json['amount']??'';
    description = json['description']??'';
    bidingId = json['bidingId']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['type'] = type;
    _data['postingTime'] = postingTime;
    _data['companyName'] = companyName;
    _data['nameOfPerson'] = nameOfPerson;
    _data['companyRating'] = companyRating;
    _data['content'] = content;
    _data['topicName'] = topicName;
    _data['tableName'] = tableName;
    _data['companyLogo'] = companyLogo;
    _data['partLoadOrNot'] = partLoadOrNot;
    _data['reminderUserName'] = reminderUserName;
    _data['sharableLink'] = sharableLink;
    _data['deviceId'] = deviceId;
    _data['ratings'] = ratings;
    _data['mobileNumber'] = mobileNumber;
    _data['source'] = source;
    _data['destination'] = destination;
    _data['mainTag'] = mainTag;
    _data['privatePost'] = privatePost;
    _data['amount'] = amount;
    _data['description'] = description;
    _data['bidingId'] = bidingId;
    return _data;
  }
}