class Advertise_Model {
  String? message;
  List<AdvertiseData>? data;
  bool? success;

  Advertise_Model({this.message, this.data, this.success});

  Advertise_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <AdvertiseData>[];
      json['data'].forEach((v) {
        data!.add(new AdvertiseData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class AdvertiseData {
  int? id;
  String? companyName;
  String? adImage;
  int? numberOfDays;
  String? transactionId;
  bool? active;
  String? startDate;
  String? endDate;
  String? bannerName;
  String? bannerHyperlink;
  int? organisationId;
  int? userId;
  String? conatctNumber;

  AdvertiseData(
      {this.id,
        this.companyName,
        this.adImage,
        this.numberOfDays,
        this.transactionId,
        this.active,
        this.startDate,
        this.endDate,
        this.bannerName,
        this.bannerHyperlink,
        this.organisationId,
        this.conatctNumber,
        this.userId});

  AdvertiseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName']??'';
    adImage = json['adImage']??'';
    numberOfDays = json['numberOfDays']??0;
    transactionId = json['transactionId']??'';
    active = json['active']??true;
    startDate = json['startDate']??'';
    endDate = json['endDate']??'';
    bannerName = json['bannerName']??"";
    bannerHyperlink = json['bannerHyperlink']??'';
    organisationId = json['organisationId'];
    userId = json['userId'];
    conatctNumber = json['conatctNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['adImage'] = this.adImage;
    data['numberOfDays'] = this.numberOfDays;
    data['transactionId'] = this.transactionId;
    data['active'] = this.active;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['bannerName'] = this.bannerName;
    data['bannerHyperlink'] = this.bannerHyperlink;
    data['organisationId'] = this.organisationId;
    data['userId'] = this.userId;
    data['conatctNumber'] = this.conatctNumber;
    return data;
  }
}
