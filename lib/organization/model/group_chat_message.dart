class GroupChatMassage {
  List<GroupChatMessageContent>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  GroupChatMassage(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  GroupChatMassage.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <GroupChatMessageContent>[];
      json['content'].forEach((v) {
        content!.add(new GroupChatMessageContent.fromJson(v));
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

class GroupChatMessageContent {
  int? id;
  int? groupId;
  int? userId;
  String? message;
  String? imageUrl;
  int? date;
  String? displayName;

  GroupChatMessageContent(
      {this.id,
        this.groupId,
        this.userId,
        this.message,
        this.imageUrl,
        this.date,
        this.displayName});

  GroupChatMessageContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    userId = json['userId'];
    message = json['message'];
    imageUrl = json['imageUrl'];
    date = json['date'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['userId'] = this.userId;
    data['message'] = this.message;
    data['imageUrl'] = this.imageUrl;
    data['date'] = this.date;
    data['displayName'] = this.displayName;
    return data;
  }
}
