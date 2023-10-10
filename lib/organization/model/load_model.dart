class LoadModel {
  LoadModel({
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
  late final List<Load> content;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;
  late final int size;
  late final int number;

  LoadModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Load.fromJson(e)).toList();
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

class Load {
  Load({
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
    this.listOfUserIds,
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
  late final int? date;
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
  late final List<int>? listOfUserIds;

  Load.fromJson(Map<String, dynamic> json){
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
    date = json['date']??0;
    os = json['os']??'';
    loggedUserName = json['loggedUserName']??'';
    loggedTime = json['loggedTime']??0;
    privatePost = json['privatePost']??0;
    dnd = json['dnd']??0;
    typeOfPayment = json['typeOfPayment']??'';
    tableName = json['tableName']??'';
    mainTag = json['mainTag']??'';
    postingTime = json['postingTime']??'';
    type =json['type']??'';
    topicName = json['topicName']??'';
    rating = json['rating']??0;
    listOfUserIds = List.castFrom<dynamic, int>(json['listOfUserIds']?? []);
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
    _data['listOfUserIds'] = listOfUserIds;
    return _data;
  }
}