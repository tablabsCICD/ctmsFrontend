class CreateMeeting {
  bool? active;
  int? createdMettingBy;
  String? date;
  String? description;
  List<int>? employeeId;
  int? leadId;
  String? meetingLink;
  String? time;
  String? title;
  int? id;

  CreateMeeting(

      {this.active,
        this.id,
        this.createdMettingBy,
        this.date,
        this.description,
        this.employeeId,
        this.leadId,
        this.meetingLink,
        this.time,
        this.title});

  CreateMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    createdMettingBy = json['createdMettingBy'];
    date = json['date'];
    description = json['description'];
    employeeId = json['employeeId'].cast<int>();
    leadId = json['leadId'];
    meetingLink = json['meetingLink'];
    time = json['time'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['active'] = this.active;
    data['createdMettingBy'] = this.createdMettingBy;
    data['date'] = this.date;
    data['description'] = this.description;
    data['employeeId'] = this.employeeId;
    data['leadId'] = this.leadId;
    data['meetingLink'] = this.meetingLink;
    data['time'] = this.time;
    data['title'] = this.title;
    return data;
  }
}

