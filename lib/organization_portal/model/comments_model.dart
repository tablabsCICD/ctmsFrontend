class CommentModel {
  List<CommentsContent>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  Null? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  CommentModel(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <CommentsContent>[];
      json['content'].forEach((v) {
        content!.add(new CommentsContent.fromJson(v));
      });
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['size'] = this.size;
    data['number'] = this.number;
    return data;
  }
}

class CommentsContent {
  int? id;
  int? discussionId;
  int? userId;
  String? comment;
  String? date;
  String? firstName;
  String? lastName;

  CommentsContent(
      {this.id,
        this.discussionId,
        this.userId,
        this.comment,
        this.date,
        this.firstName,
        this.lastName});

  CommentsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discussionId = json['discussionId'];
    userId = json['userId'];
    comment = json['comment'];
    date = json['date'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discussionId'] = this.discussionId;
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    data['date'] = this.date;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
