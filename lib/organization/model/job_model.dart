class JobModel {
  JobModel({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    this.sort,
    required this.first,
    required this.numberOfElements,
  });
  late final List<Job> content;
  late final int totalElements;
  late final int totalPages;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  JobModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Job.fromJson(e)).toList();
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort']?? '';
    first = json['first'];
    numberOfElements = json['numberOfElements'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['last'] = last;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort;
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    return _data;
  }
}

class Job {
  Job({
    required this.id,
    required this.userId,
    required this.type,
    required this.postingTime,
    required this.companyName,
    required this.nameOfPerson,
    this.companyRating,
    required this.content,
    required this.topicName,
    required this.tableName,
    this.companyLogo,
    required this.partLoadOrNot,
    this.reminderUserName,
    required this.sharableLink,
    this.deviceId,
    this.ratings,
    required this.mobileNumber,
    this.source,
    this.destination,
    required this.mainTag,
    required this.privatePost,
    this.makerName,
    this.modelName,
    this.mfgYear,
    this.estPrice,
    required this.dnd,
    this.vehicleSize,
    this.association,
    this.isPaid,
    this.website,
    this.alterativeNumber,
    this.companyDetailsName,
    this.isVerifiedByCompany,
  });
  late final int? id;
  late final int? userId;
  late final String? type;
  late final String? postingTime;
  late final String? companyName;
  late final String? nameOfPerson;
  late final String? companyRating;
  late final String? content;
  late final String? topicName;
  late final String? tableName;
  late final String? companyLogo;
  late final int? partLoadOrNot;
  late final String? reminderUserName;
  late final String? sharableLink;
  late final String? deviceId;
  late final double? ratings;
  late final int? mobileNumber;
  late final String? source;
  late final String? destination;
  late final String? mainTag;
  late final int? privatePost;
  late final String? makerName;
  late final String? modelName;
  late final String? mfgYear;
  late final String? estPrice;
  late final int? dnd;
  late final String? vehicleSize;
  late final String? association;
  late final int? isPaid;
  late final String? website;
  late final String? alterativeNumber;
  late final String? companyDetailsName;
  late final String? isVerifiedByCompany;

  Job.fromJson(Map<String, dynamic> json){
    id = json['id']?? 0;
    userId = json['userId']?? 0;
    type = json['type']?? '';
    postingTime = json['postingTime']?? '';
    companyName = json['companyName']?? '';
    nameOfPerson = json['nameOfPerson']?? '';
    companyRating = json['companyRating']?? '';
    content = json['content']?? '';
    topicName = json['topicName']?? '';
    tableName = json['tableName']?? '';
    companyLogo = json['companyLogo']?? '';
    partLoadOrNot = json['partLoadOrNot']?? 0;
    reminderUserName = json['reminderUserName']?? '';
    sharableLink = json['sharableLink']?? '';
    deviceId = json['deviceId']?? '';
    ratings = json['ratings']?? 0.0;
    mobileNumber = json['mobileNumber']?? 0;
    source = json['source']?? '';
    destination = json['destination']?? '';
    mainTag = json['mainTag']?? '';
    privatePost = json['privatePost']?? 0;
    makerName = json['makerName']?? '';
    modelName = json['modelName']?? '';
    mfgYear = json['mfgYear']?? '';
    estPrice = json['estPrice']?? '';
    dnd = json['dnd']?? 0;
    vehicleSize = json['vehicleSize']?? '';
    association = json['association']?? '';
    isPaid = json['isPaid']?? 0;
    website = json['website']?? '';
    alterativeNumber = json['alterativeNumber']?? '';
    companyDetailsName = json['companyDetailsName']?? '';
    isVerifiedByCompany = json['isVerifiedByCompany']?? '';
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
    _data['makerName'] = makerName;
    _data['modelName'] = modelName;
    _data['mfgYear'] = mfgYear;
    _data['estPrice'] = estPrice;
    _data['dnd'] = dnd;
    _data['vehicleSize'] = vehicleSize;
    _data['association'] = association;
    _data['isPaid'] = isPaid;
    _data['website'] = website;
    _data['alterativeNumber'] = alterativeNumber;
    _data['companyDetailsName'] = companyDetailsName;
    _data['isVerifiedByCompany'] = isVerifiedByCompany;
    return _data;
  }
}