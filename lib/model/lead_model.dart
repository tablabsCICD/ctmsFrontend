
import 'package:flutter_hr_management/model/lead_update_model.dart';
import 'package:flutter_hr_management/model/simple_dto_model.dart';
import 'package:flutter_hr_management/model/tracking_model.dart';

class LeadData {
  SimpleDto? simpleDto;
  String? status;
  Lead? lead;
  List<LeadUpdates>? leadUpdates;
  List<Trackings>? trackings;

  LeadData({this.status, this.lead, this.leadUpdates, this.trackings});

  LeadData.fromJson(Map<String, dynamic> json) {
    simpleDto = json['simpleDto'] != null ? new SimpleDto.fromJson(json['simpleDto']) : null;
    status = json['status'];
    lead = json['lead'] != null ? new Lead.fromJson(json['lead']) : null;
    if (json['leadUpdates'] != null) {
      leadUpdates = <LeadUpdates>[];
      json['leadUpdates'].forEach((v) {
        leadUpdates!.add(new LeadUpdates.fromJson(v));
      });
    }
    if (json['trackings'] != null) {
      trackings = <Trackings>[];
      json['trackings'].forEach((v) { trackings!.add(new Trackings.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.simpleDto != null) {
      data['simpleDto'] = this.simpleDto!.toJson();
    }
    data['status'] = this.status;
    if (this.lead != null) {
      data['lead'] = this.lead!.toJson();
    }
    if (this.leadUpdates != null) {
      data['leadUpdates'] = this.leadUpdates!.map((v) => v.toJson()).toList();
    }
    if (this.trackings != null) {
      data['trackings'] = this.trackings!.map((v) => v).toList();
    }
    return data;
  }
}


class Lead {
  int? id;
  String? companyName;
  String? coordinator;
  String? mobileNumber;
  String? emailId;
  String? sourceOfLead;
  String? pinCode;
  String? city;
  String? address;
  String? typeOfBusiness;
  String? date;
  int? isEnquiry;
  bool? isRoundRobin;
  String? addLogo;
  String? document;
  bool? isRobinRound;
  bool? isSelected;
  int? organisationId;
  Lead(
      {this.id,
        this.companyName,
        this.coordinator,
        this.mobileNumber,
        this.emailId,
        this.sourceOfLead,
        this.pinCode,
        this.city,
        this.address,
        this.typeOfBusiness,
        this.date,
        this.isEnquiry,
        this.isRoundRobin,
        this.addLogo,
        this.document,
        this.organisationId,
        this.isSelected});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName']??'';
    coordinator = json['coordinator']??"";
    mobileNumber = json['mobileNumber']??"";
    emailId = json['emailId']??"";
    sourceOfLead = json['sourceOfLead']??'';
    pinCode = json['pinCode']??'';
    city = json['city']??'';
    address = json['address']??'';
    typeOfBusiness = json['typeOfBusiness']??'';
    date = json['date']??'';
    isEnquiry = json['isEnquiry']??0;
    isRoundRobin = json['isRoundRobin']??false;
    addLogo = json['addLogo']??"";
    document = json['document']??"";
    organisationId = json['organisationId'];
    isSelected=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['coordinator'] = this.coordinator;
    data['mobileNumber'] = this.mobileNumber;
    data['emailId'] = this.emailId;
    data['sourceOfLead'] = this.sourceOfLead;
    data['pinCode'] = this.pinCode;
    data['city'] = this.city;
    data['address'] = this.address;
    data['typeOfBusiness'] = this.typeOfBusiness;
    data['date'] = this.date;
    data['isEnquiry'] = this.isEnquiry;
    data['addLogo'] = this.addLogo;
    data['document'] = this.document;
    data['isRobinRound'] = this.isRobinRound;
    data['organisationId'] = this.organisationId;
    return data;
  }
}