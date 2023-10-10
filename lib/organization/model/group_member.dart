class GroupMember {
  String? displayName;
  int? userId;

  GroupMember({this.displayName, this.userId});

  GroupMember.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['userId'] = this.userId;
    return data;
  }

}