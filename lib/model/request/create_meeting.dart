class CreateMeeting {
  bool? active;
  int? createdMettingBy;
  String? date;
  String? description;
  List<int>? employeeId;
  int? leadId;
  String? meetingLink;
  String? status;
  String? time;
  String? title;
  int? id;
  int? organisationId;

  CreateMeeting(

      {this.active,
        this.id,
        this.createdMettingBy,
        this.date,
        this.description,
        this.employeeId,
        this.leadId,
        this.meetingLink,
        this.status,
        this.time,
        this.organisationId,
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
    status = json['status'];
    time = json['time'];
    title = json['title'];
    organisationId = json['organisationId'];
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
    data['status'] = this.status;
    data['time'] = this.time;
    data['title'] = this.title;
    data['organisationId'] = this.organisationId;
    return data;
  }
}

