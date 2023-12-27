class SimpleDto {
  String? leadAddedBy;
  String? leadUpdatedByUser;
  String? leadNextFollowUpBy;
  String? leadAssignedTo;

  SimpleDto(
      {this.leadAddedBy,
        this.leadUpdatedByUser,
        this.leadNextFollowUpBy,
        this.leadAssignedTo});

  SimpleDto.fromJson(Map<String, dynamic> json) {
    leadAddedBy = json['LeadAddedBy'];
    leadUpdatedByUser = json['LeadUpdatedBy User'];
    leadNextFollowUpBy = json['LeadNextFollowUpBy'];
    leadAssignedTo = json['LeadAssignedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadAddedBy'] = this.leadAddedBy;
    data['LeadUpdatedBy User'] = this.leadUpdatedByUser;
    data['LeadNextFollowUpBy'] = this.leadNextFollowUpBy;
    data['LeadAssignedTo'] = this.leadAssignedTo;
    return data;
  }
}