class OrganizationModel {
  OrganizationModel({
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
  late final List<Organization> content;
  late final int totalPages;
  late final int totalElements;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  OrganizationModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Organization.fromJson(e)).toList();
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

class Organization {
  Organization({
    required this.id,
    required this.companyName,
    required this.companyLogo,
    required this.companyAddress,
    required this.isVerified,
    required this.website,
    required this.landlineNumber,
    required this.companyMobileNumber,
    required this.pointOfContact,
    required this.gstNumber,
    required this.gstNumber2,
    required this.typeOfRegistration,
    required this.panCardNumber,
    required this.tanCardNumber,
    required this.officialEmailId,
    required this.rating,
    required this.numberOfRatings,
    required this.city,
    required this.state,
  });
  late final int? id;
  late final String? companyName;
  late final String? companyAddress;
  late final int? isVerified;
  late final String? website;
  late final String? landlineNumber;
  late final String? companyMobileNumber;
  late final String? pointOfContact;
  late final String? gstNumber;
  late final String? gstNumber2;
  late final String? typeOfRegistration;
  late final String? panCardNumber;
  late final String? tanCardNumber;
  late final String? officialEmailId;
  late final int? rating;
  late final int? numberOfRatings;
  late final String? city;
  late final String? companyLogo;
  late final String? state;

  Organization.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    companyName = json['companyName']??'';
    companyAddress = json['companyAddress']??'';
    isVerified = json['isVerified']??0;
    website = json['website']??'';
    landlineNumber = json['landlineNumber']??'';
    companyMobileNumber = json['companyMobileNumber']??'';
    pointOfContact = json['pointOfContact']??'';
    gstNumber = json['gstNumber']??'';
    gstNumber2 = json['gstNumber2']??'';
    typeOfRegistration = json['typeOfRegistration']??'';
    panCardNumber = json['panCardNumber']??'';
    tanCardNumber = json['tanCardNumber']??'';
    officialEmailId = json['officialEmailId']??'';
    rating = json['rating']??0;
    numberOfRatings = json['numberOfRatings']??0;
    city = json['city']??'';
    state = json['state']??'';
    companyLogo = json['companyLogo']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['companyName'] = companyName;
    _data['companyAddress'] = companyAddress;
    _data['isVerified'] = isVerified;
    _data['website'] = website;
    _data['landlineNumber'] = landlineNumber;
    _data['companyMobileNumber'] = companyMobileNumber;
    _data['pointOfContact'] = pointOfContact;
    _data['gstNumber'] = gstNumber;
    _data['gstNumber2'] = gstNumber2;
    _data['typeOfRegistration'] = typeOfRegistration;
    _data['panCardNumber'] = panCardNumber;
    _data['tanCardNumber'] = tanCardNumber;
    _data['officialEmailId'] = officialEmailId;
    _data['rating'] = rating;
    _data['numberOfRatings'] = numberOfRatings;
    _data['city'] = city;
    _data['state'] = state;
    _data['companyLogo'] = companyLogo;
    return _data;
  }
}