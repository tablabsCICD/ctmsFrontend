class Trackings {
  int? id;
  int? lead;
  String? followUpDate;
  String? time;
  String? result;
  String? nextFollowUpDate;

  Trackings({this.id, this.lead, this.followUpDate, this.time, this.result, this.nextFollowUpDate});

  Trackings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
    followUpDate = json['followUpDate'];
    time = json['time'];
    result = json['result'];
    nextFollowUpDate = json['nextFollowUpDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead'] = this.lead;
    data['followUpDate'] = this.followUpDate;
    data['time'] = this.time;
    data['result'] = this.result;
    data['nextFollowUpDate'] = this.nextFollowUpDate;
    return data;
  }
}