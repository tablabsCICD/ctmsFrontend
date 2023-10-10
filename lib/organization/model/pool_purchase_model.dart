class PoolPurchaseModel {
  PoolPurchaseModel({
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
  late final List<PoolPurchase> content;
  late final int totalElements;
  late final int totalPages;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  PoolPurchaseModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>PoolPurchase.fromJson(e)).toList();
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = null;
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

class PoolPurchase {
  PoolPurchase({
    required this.id,
    required this.type,
    this.ownerName,
    required this.agentName,
    required this.contactNumber,
    required this.city,
    required this.emailId,
    required this.purchaseItem,
    required this.description,
    required this.purchasePlannedDate,
    required this.loggedUserName,
    required this.loggedTime,
    required this.privatePost,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    this.profilePicture,
  });
  late final int id;
  late final String? type;
  late final String? ownerName;
  late final String? agentName;
  late final int? contactNumber;
  late final String? city;
  late final String? emailId;
  late final String? purchaseItem;
  late final String? description;
  late final String? purchasePlannedDate;
  late final String? loggedUserName;
  late final int? loggedTime;
  late final int? privatePost;
  late final String? firstName;
  late final String? lastName;
  late final int? mobileNumber;
  late final String? profilePicture;

  PoolPurchase.fromJson(Map<String, dynamic> json){
    id = json['id']?? 0;
    type = json['type']?? '';
    ownerName = json['ownerName']?? '';
    agentName = json['agentName']?? '';
    contactNumber = json['contactNumber']?? 0;
    city = json['city']?? '';
    emailId = json['emailId']?? '';
    purchaseItem = json['purchaseItem']?? '';
    description = json['description']?? '';
    purchasePlannedDate = json['purchasePlannedDate']?? '';
    loggedUserName = json['loggedUserName']?? '';
    loggedTime = json['loggedTime']?? 0;
    privatePost = json['privatePost']?? 0;
    firstName = json['firstName']?? '';
    lastName = json['lastName']?? '';
    mobileNumber = json['mobileNumber']?? 0;
    profilePicture = json['profilePicture']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['ownerName'] = ownerName;
    _data['agentName'] = agentName;
    _data['contactNumber'] = contactNumber;
    _data['city'] = city;
    _data['emailId'] = emailId;
    _data['purchaseItem'] = purchaseItem;
    _data['description'] = description;
    _data['purchasePlannedDate'] = purchasePlannedDate;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['privatePost'] = privatePost;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['mobileNumber'] = mobileNumber;
    _data['profilePicture'] = profilePicture;
    return _data;
  }
}