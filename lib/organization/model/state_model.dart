class StateModel {
  StateModel({
    required this.result,
  });
  late final List<States> result;

  StateModel.fromJson(Map<String, dynamic> json){
    result = List.from(json['result']).map((e)=>States.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class States {
  States({
    required this.id,
    required this.country,
    required this.region,
    this.abbr,
    this.area,
    this.largestCity,
    this.capital,
  });
  late final int id;
  late final String country;
  late final String region;
  late final String? abbr;
  late final String? area;
  late final String? largestCity;
  late final String? capital;

  States.fromJson(Map<String, dynamic> json){
    id = json['id'];
    country = json['country'];
    region = json['region'];
    abbr = json['abbr']??'';
    area = json['area']??'';
    largestCity = json['largestCity']??'';
    capital = json['capital']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['country'] = country;
    _data['region'] = region;
    _data['abbr'] = abbr;
    _data['area'] = area;
    _data['largest_city'] = largestCity;
    _data['capital'] = capital;
    return _data;
  }
}