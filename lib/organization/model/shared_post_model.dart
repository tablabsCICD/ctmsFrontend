class SharedPost {
  SharedPost({
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
  late final List<SharedPostModel> content;
  late final int totalElements;
  late final int totalPages;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  SharedPost.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>SharedPostModel.fromJson(e)).toList();
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


class SharedPostModel {
  int? id;
  String? fullLoadChoice;
  String? transporterOrCustomerName;
  int? contactNumber;
  String? emailId;
  String? source;
  String? destination;
  String? typeOfCargo;
  String? otherDetails;
  String? vehicleSize;
  String? loadWeight;
  String? instructions;
  int? partLoad;
  String? date;
  String? os;
  String? loggedUserName;
  int? loggedTime;
  int? privatePost;
  int? dnd;
  String? typeOfPayment;
  String? tableName;
  String? mainTag;
  String? postingTime;
  String? type;
  String? topicName;
  String? rating;
  String? listOfUserIds;

  SharedPostModel(
      {this.id,
        this.fullLoadChoice,
        this.transporterOrCustomerName,
        this.contactNumber,
        this.emailId,
        this.source,
        this.destination,
        this.typeOfCargo,
        this.otherDetails,
        this.vehicleSize,
        this.loadWeight,
        this.instructions,
        this.partLoad,
        this.date,
        this.os,
        this.loggedUserName,
        this.loggedTime,
        this.privatePost,
        this.dnd,
        this.typeOfPayment,
        this.tableName,
        this.mainTag,
        this.postingTime,
        this.type,
        this.topicName,
        this.rating,
        this.listOfUserIds});

  SharedPostModel.fromJson(Map<String, dynamic> json) {
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
    date = json['date']??'';
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
    rating = json['rating']??'';
    listOfUserIds = json['listOfUserIds']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullLoadChoice'] = this.fullLoadChoice;
    data['transporterOrCustomerName'] = this.transporterOrCustomerName;
    data['contactNumber'] = this.contactNumber;
    data['emailId'] = this.emailId;
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['typeOfCargo'] = this.typeOfCargo;
    data['otherDetails'] = this.otherDetails;
    data['vehicleSize'] = this.vehicleSize;
    data['loadWeight'] = this.loadWeight;
    data['instructions'] = this.instructions;
    data['partLoad'] = this.partLoad;
    data['date'] = this.date;
    data['os'] = this.os;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['privatePost'] = this.privatePost;
    data['dnd'] = this.dnd;
    data['typeOfPayment'] = this.typeOfPayment;
    data['tableName'] = this.tableName;
    data['mainTag'] = this.mainTag;
    data['postingTime'] = this.postingTime;
    data['type'] = this.type;
    data['topicName'] = this.topicName;
    data['rating'] = this.rating;
    data['listOfUserIds'] = this.listOfUserIds;
    return data;
  }
}