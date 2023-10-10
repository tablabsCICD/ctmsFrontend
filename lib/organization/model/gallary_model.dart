class GalleryModel {
  GalleryModel({
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
  late final List<Gallery> content;
  late final int totalElements;
  late final int totalPages;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  GalleryModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Gallery.fromJson(e)).toList();
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size']?? '';
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

class Gallery {
  Gallery({
    required this.id,
    required this.topicName,
    required this.description,
    required this.userId,
    required this.image,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    required this.isApproved,
    required this.date,
    required this.imageType,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.companyName,
    this.profilePicture,
  });
  late final int id;
  late final String? topicName;
  late final String? description;
  late final int? userId;
  late final String? image;
  late final String? image2;
  late final String? image3;
  late final String? image4;
  late final String? image5;
  late final int? isApproved;
  late final String? date;
  late final String? imageType;
  late final String? firstName;
  late final String? lastName;
  late final int? mobileNumber;
  late final String? companyName;
  late final String? profilePicture;

  Gallery.fromJson(Map<String, dynamic> json){
    id = json['id']?? 0;
    topicName = json['topicName']?? '';
    description = json['description']?? '';
    userId = json['userId']?? 0;
    image = json['image']?? '';
    image2 = json['image2']?? '';
    image3 = json['image3']?? '';
    image4 = json['image4']?? '';
    image5 = json['image5']?? '';
    isApproved = json['isApproved']?? 0;
    date = json['date']?? '';
    imageType = json['imageType']?? '';
    firstName = json['firstName']?? '';
    lastName = json['lastName']?? '';
    mobileNumber = json['mobileNumber']?? 0;
    companyName = json['companyName']?? '';
    profilePicture = json['profilePicture']?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['topicName'] = topicName;
    _data['description'] = description;
    _data['userId'] = userId;
    _data['image'] = image;
    _data['image2'] = image2;
    _data['image3'] = image3;
    _data['image4'] = image4;
    _data['image5'] = image5;
    _data['isApproved'] = isApproved;
    _data['date'] = date;
    _data['imageType'] = imageType;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['mobileNumber'] = mobileNumber;
    _data['companyName'] = companyName;
    _data['profilePicture'] = profilePicture;
    return _data;
  }
}