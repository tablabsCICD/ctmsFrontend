import 'package:flutter_hr_management/organization_portal/model/all_user_model.dart';

class CompanyRatingResponse {
  String? message;
  List<CompanyRating>? data;
  bool? success;

  CompanyRatingResponse({this.message, this.data, this.success});

  CompanyRatingResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CompanyRating>[];
      json['data'].forEach((v) {
        data!.add(new CompanyRating.fromJson(v));
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

class CompanyRating {
  double? rating;
  ComanyDetails? comanyDetails;
  List<Rating>? list;
  List<UserModel>? companyRegistrations;

  CompanyRating({this.rating, this.comanyDetails, this.list, this.companyRegistrations});

  CompanyRating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    comanyDetails = json['comanyDetails'] != null
        ? new ComanyDetails.fromJson(json['comanyDetails'])
        : null;
    if (json['list'] != null) {
      list = <Rating>[];
      json['list'].forEach((v) {
        list!.add(new Rating.fromJson(v));
      });
    }
    if (json['companyRegistrations'] != null) {
      companyRegistrations = <UserModel>[];
      json['companyRegistrations'].forEach((v) {
        companyRegistrations!.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    if (this.comanyDetails != null) {
      data['comanyDetails'] = this.comanyDetails!.toJson();
    }
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.companyRegistrations != null) {
      data['companyRegistrations'] =
          this.companyRegistrations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComanyDetails {
  int? id;
  String? companyName;
  String? companyAddress;
  int? isVerified;
  String? website;
  String? landlineNumber;
  String? companyMobileNumber;
  String? pointOfContact;
  String? gstNumber;
  String? gstNumber2;
  String? typeOfRegistration;
  String? panCardNumber;
  String? tanCardNumber;
  String? officialEmailId;
  double? rating;
  double? numberOfRatings;
  String? city;
  String? state;
  String? otp;
  String? active;
  String? logo;

  ComanyDetails(
      {this.id,
        this.companyName,
        this.companyAddress,
        this.isVerified,
        this.website,
        this.landlineNumber,
        this.companyMobileNumber,
        this.pointOfContact,
        this.gstNumber,
        this.gstNumber2,
        this.typeOfRegistration,
        this.panCardNumber,
        this.tanCardNumber,
        this.officialEmailId,
        this.rating,
        this.numberOfRatings,
        this.city,
        this.state,
        this.otp,
        this.active,
        this.logo});

  ComanyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    isVerified = json['isVerified'];
    website = json['website'];
    landlineNumber = json['landlineNumber'];
    companyMobileNumber = json['companyMobileNumber'];
    pointOfContact = json['pointOfContact'];
    gstNumber = json['gstNumber'];
    gstNumber2 = json['gstNumber2'];
    typeOfRegistration = json['typeOfRegistration'];
    panCardNumber = json['panCardNumber'];
    tanCardNumber = json['tanCardNumber'];
    officialEmailId = json['officialEmailId'];
    rating = json['rating'];
    numberOfRatings = json['numberOfRatings'];
    city = json['city'];
    state = json['state'];
    otp = json['otp'];
    active = json['active'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['isVerified'] = this.isVerified;
    data['website'] = this.website;
    data['landlineNumber'] = this.landlineNumber;
    data['companyMobileNumber'] = this.companyMobileNumber;
    data['pointOfContact'] = this.pointOfContact;
    data['gstNumber'] = this.gstNumber;
    data['gstNumber2'] = this.gstNumber2;
    data['typeOfRegistration'] = this.typeOfRegistration;
    data['panCardNumber'] = this.panCardNumber;
    data['tanCardNumber'] = this.tanCardNumber;
    data['officialEmailId'] = this.officialEmailId;
    data['rating'] = this.rating;
    data['numberOfRatings'] = this.numberOfRatings;
    data['city'] = this.city;
    data['state'] = this.state;
    data['otp'] = this.otp;
    data['active'] = this.active;
    data['logo'] = this.logo;
    return data;
  }
}

class Rating {
  int? id;
  int? company;
  int? rating;
  String? review;
  int? userId;
  int? date;

  Rating(
      {this.id,
        this.company,
        this.rating,
        this.review,
        this.userId,
        this.date});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    rating = json['rating'];
    review = json['review'];
    userId = json['userId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company'] = this.company;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['userId'] = this.userId;
    data['date'] = this.date;
    return data;
  }
}


