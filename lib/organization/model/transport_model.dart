class TransportModel {
  TransportModel({
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
  late final List<Content> content;
  late final int totalPages;
  late final int totalElements;
  late final bool last;
  late final int size;
  late final int number;
  late final Null sort;
  late final bool first;
  late final int numberOfElements;

  TransportModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Content.fromJson(e)).toList();
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
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

class Content {
  Content({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.mobileNumber,
    required this.companyName,
    required this.companyAddress,
    this.city,
    required this.state,
    required this.country,
    this.landlineNumber,
    required this.verified,
    this.companyLogo,
    this.aadharCard,
    this.ratings,
    this.profilePicture,
    this.loggedUserName,
    required this.loggedTime,
    this.transporterOrAgent,
    required this.isPaid,
    required this.paidStartDate,
    required this.validTill,
    this.website,
    required this.listOfPreferredRoutes,
  });
  late final int id;
  late final String userName;
  late final String firstName;
  late final String lastName;
  late final String emailId;
  late final int mobileNumber;
  late final String companyName;
  late final String companyAddress;
  late final String? city;
  late final String state;
  late final String country;
  late final Null landlineNumber;
  late final int verified;
  late final Null companyLogo;
  late final String? aadharCard;
  late final int? ratings;
  late final String? profilePicture;
  late final Null loggedUserName;
  late final int loggedTime;
  late final Null transporterOrAgent;
  late final int isPaid;
  late final String paidStartDate;
  late final String validTill;
  late final String? website;
  late final List<ListOfPreferredRoutes> listOfPreferredRoutes;

  Content.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    city = null;
    state = json['state'];
    country = json['country'];
    landlineNumber = null;
    verified = json['verified'];
    companyLogo = null;
    aadharCard = null;
    ratings = null;
    profilePicture = null;
    loggedUserName = null;
    loggedTime = json['loggedTime'];
    transporterOrAgent = null;
    isPaid = json['isPaid'];
    paidStartDate = json['paidStartDate'];
    validTill = json['validTill'];
    website = null;
    listOfPreferredRoutes = List.from(json['listOfPreferredRoutes']).map((e)=>ListOfPreferredRoutes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userName'] = userName;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['emailId'] = emailId;
    _data['mobileNumber'] = mobileNumber;
    _data['companyName'] = companyName;
    _data['companyAddress'] = companyAddress;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['landlineNumber'] = landlineNumber;
    _data['verified'] = verified;
    _data['companyLogo'] = companyLogo;
    _data['aadharCard'] = aadharCard;
    _data['ratings'] = ratings;
    _data['profilePicture'] = profilePicture;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    _data['transporterOrAgent'] = transporterOrAgent;
    _data['isPaid'] = isPaid;
    _data['paidStartDate'] = paidStartDate;
    _data['validTill'] = validTill;
    _data['website'] = website;
    _data['listOfPreferredRoutes'] = listOfPreferredRoutes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListOfPreferredRoutes {
  ListOfPreferredRoutes({
    required this.id,
    required this.userId,
    required this.routeSource,
    required this.routeDestination,
    required this.loggedUserName,
    required this.loggedTime,
  });
  late final int id;
  late final int userId;
  late final String routeSource;
  late final String routeDestination;
  late final String loggedUserName;
  late final int loggedTime;

  ListOfPreferredRoutes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    routeSource = json['routeSource'];
    routeDestination = json['routeDestination'];
    loggedUserName = json['loggedUserName'];
    //loggedTime = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['routeSource'] = routeSource;
    _data['routeDestination'] = routeDestination;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    return _data;
  }
}