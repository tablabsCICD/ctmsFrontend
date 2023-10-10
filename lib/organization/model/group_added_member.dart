class GroupMemberModel {
  List<GroupMemberContent>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  Null? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  GroupMemberModel(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  GroupMemberModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <GroupMemberContent>[];
      json['content'].forEach((v) {
        content!.add(new GroupMemberContent.fromJson(v));
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

class GroupMemberContent {
  int? id;
  int? groupId;
  int? date;
  int? userId;
  int? isAvailable;
  int? addedByUserId;
  String? displayName;

  GroupMemberContent(
      {this.id,
        this.groupId,
        this.date,
        this.userId,
        this.isAvailable,
        this.addedByUserId,
        this.displayName});

  GroupMemberContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    date = json['date'];
    userId = json['userId'];
    isAvailable = json['isAvailable'];
    addedByUserId = json['addedByUserId'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['date'] = this.date;
    data['userId'] = this.userId;
    data['isAvailable'] = this.isAvailable;
    data['addedByUserId'] = this.addedByUserId;
    data['displayName'] = this.displayName;
    return data;
  }
}
