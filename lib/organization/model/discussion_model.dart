class DiscussionModel {
  List<DiscussionContent>? content;
  bool? last;
  int? totalPages;
  int? totalElements;
  Null? sort;
  bool? first;
  int? numberOfElements;
  int? size;
  int? number;

  DiscussionModel(
      {this.content,
        this.last,
        this.totalPages,
        this.totalElements,
        this.sort,
        this.first,
        this.numberOfElements,
        this.size,
        this.number});

  DiscussionModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <DiscussionContent>[];
      json['content'].forEach((v) {
        content!.add(new DiscussionContent.fromJson(v));
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


class DiscussionData {
  List<DiscussionContent>? content;


  DiscussionData(
      {this.content,
       });

  DiscussionData.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <DiscussionContent>[];
      json['content'].forEach((v) {
        content!.add(new DiscussionContent.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiscussionContent {
  int? id;
  String? topic;
  String? description;
  String? active;
  String? loggedUserName;
  String? loggedTime;
  String? firstName;
  String? lastName;
  String? emailId;
  int? mobileNumber;
  String? profilePicture;
  String? latestComment;
  String? totalComments;
  String? firstNameForComment;
  String? lastNameForComment;
  String? companyName;
  int? like;
  int? dislikes;
  String? likedByUser;

  DiscussionContent(
      {this.id,
        this.topic,
        this.description,
        this.active,
        this.loggedUserName,
        this.loggedTime,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.profilePicture,
        this.latestComment,
        this.totalComments,
        this.firstNameForComment,
        this.lastNameForComment,
        this.companyName,
        this.like,
        this.dislikes,
        this.likedByUser});

  DiscussionContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    description = json['description'];
    active = json['active'];
    loggedUserName = json['loggedUserName'];
    loggedTime = json['loggedTime'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobileNumber = json['mobileNumber'];
    profilePicture = json['profilePicture'];
    latestComment = json['latestComment']==null?"0":json['latestComment'];
    totalComments = json['totalComments'] == null?"0":json['totalComments'];
    firstNameForComment = json['firstNameForComment']==null?"0":json['firstNameForComment'];
    lastNameForComment = json['lastNameForComment']==null?"0":json['lastNameForComment'];
    companyName = json['companyName'];
    like = json['like'];
    dislikes = json['dislikes'];
    likedByUser = json['likedByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    data['description'] = this.description;
    data['active'] = this.active;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['profilePicture'] = this.profilePicture;
    data['latestComment'] = this.latestComment;
    data['totalComments'] = this.totalComments;
    data['firstNameForComment'] = this.firstNameForComment;
    data['lastNameForComment'] = this.lastNameForComment;
    data['companyName'] = this.companyName;
    data['like'] = this.like;
    data['dislikes'] = this.dislikes;
    data['likedByUser'] = this.likedByUser;
    return data;
  }
}
