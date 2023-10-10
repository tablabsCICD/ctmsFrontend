class FeetModel {
  FeetModel({
    required this.content,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    this.sort,
    required this.first,
    required this.numberOfElements,
  });
  late final List<Fleet> content;
  late final bool last;
  late final int totalElements;
  late final int totalPages;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  FeetModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Fleet.fromJson(e)).toList();
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = json['sort']?? '';
    first = json['first'];
    numberOfElements = json['numberOfElements'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['last'] = last;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort;
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    return _data;
  }
}

class Fleet {
  Fleet({
    required this.id,
    required this.userId,
    required this.vehicleNumber,
    required this.weightInTonnes,
    required this.typeOfVehicle,
    required this.organisationId,
    required this.loggedUserName,
    required this.loggedTime,
  });
  late final int? id;
  late final int? userId;
  late final String? vehicleNumber;
  late final String? weightInTonnes;
  late final String? typeOfVehicle;
  late final int? organisationId;
  late final String? loggedUserName;
  late final int? loggedTime;

  Fleet.fromJson(Map<String, dynamic> json){
    id = json['id']?? 0;
    userId = json['userId']?? 0;
    vehicleNumber = json['vehicleNumber']?? '';
    weightInTonnes = json['weightInTonnes']?? '';
    typeOfVehicle = json['typeOfVehicle']?? '';
    organisationId = json['organisationId']?? 0;
    loggedUserName = json['loggedUserName']?? '';
    loggedTime = json['loggedTime']?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['vehicleNumber'] = vehicleNumber;
    _data['weightInTonnes'] = weightInTonnes;
    _data['typeOfVehicle'] = typeOfVehicle;
    _data['organisationId'] = organisationId;
    _data['loggedUserName'] = loggedUserName;
    _data['loggedTime'] = loggedTime;
    return _data;
  }
}