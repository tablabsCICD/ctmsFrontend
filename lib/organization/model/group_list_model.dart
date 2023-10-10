class GroupListModel {
  List<GroupContent>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  String? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  GroupListModel(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  GroupListModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <GroupContent>[];
      json['content'].forEach((v) {
        content!.add(new GroupContent.fromJson(v));
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

class GroupContent {
  int? id;
  int? createByUserId;
  int? date;
  String? groupName;
  int? isPrivate;
  String? imageUrl;

  GroupContent(
      {this.id,
        this.createByUserId,
        this.date,
        this.groupName,
        this.isPrivate,
        this.imageUrl});

  GroupContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createByUserId = json['createByUserId'];
    date = json['date'];
    groupName = json['groupName'];
    isPrivate = json['isPrivate'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createByUserId'] = this.createByUserId;
    data['date'] = this.date;
    data['groupName'] = this.groupName;
    data['isPrivate'] = this.isPrivate;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
