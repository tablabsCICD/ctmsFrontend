class FeedbackModel {
  FeedbackModel({
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
  late final List<FeedBack> content;
  late final int totalElements;
  late final int totalPages;
  late final bool last;
  late final int size;
  late final int number;
  late final String? sort;
  late final bool first;
  late final int numberOfElements;

  FeedbackModel.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>FeedBack.fromJson(e)).toList();
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort']??'';
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

class FeedBack {
  FeedBack({
    required this.id,
    required this.userId,
    required this.postId,
    required this.type,
    required this.ratings,
    required this.feedbackDetails,
    required this.date,
  });
  late final int id;
  late final int userId;
  late final int postId;
  late final String type;
  late final int ratings;
  late final String feedbackDetails;
  late final int date;

  FeedBack.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    userId = json['userId']??0;
    postId = json['postId']??0;
    type = json['type']??'';
    ratings = json['ratings']??0;
    feedbackDetails = json['feedbackDetails']??'';
    date = json['date']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['postId'] = postId;
    _data['type'] = type;
    _data['ratings'] = ratings;
    _data['feedbackDetails'] = feedbackDetails;
    _data['date'] = date;
    return _data;
  }
}