class BidModel {
  BidModel({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    this.sort,
    required this.first,
    required this.numberOfElements,
  });
  late final List<Bid> content;
  late final int totalPages;
  late final int totalElements;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  BidModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Bid.fromJson(e)).toList();
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
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
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['last'] = last;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort;
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    return _data;
  }
}

class Bid {
  Bid({
    required this.id,
    required this.emailId,
    required this.userName,
    required this.type,
    required this.idOfPost,
    required this.amount,
    required this.description,
    required this.bidderUserName,
    required this.mobileNumber,
    required this.loggedUserName,
    required this.loggedTime,
  });
  late final int? id;
  late final String? emailId;
  late final String? userName;
  late final String? type;
  late final int? idOfPost;
  late final String? amount;
  late final String? description;
  late final String? bidderUserName;
  late final int? mobileNumber;
  late final String? loggedUserName;
  late final int? loggedTime;

  Bid.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    emailId = json['emailId']?? '';
    userName = json['userName']?? '';
    type = json['type']?? '';
    idOfPost = json['idOfPost']?? 0;
    amount = json['amount']?? '';
    description = json['description']?? '';
    bidderUserName = json['bidderUserName']?? '';
    mobileNumber = json['mobileNumber']??0;
    loggedUserName = json['loggedUserName']??'';
    loggedTime = json['loggedTime']??0 ;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['emailId'] = emailId;
    _data['userName'] = userName;
    _data['type'] = type;
    _data['idOfPost'] = idOfPost;
    _data['amount'] = amount;
    _data['description'] = description;
    _data['bidderUserName'] = bidderUserName;
    _data['mobileNumber'] = mobileNumber;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    return _data;
  }
}