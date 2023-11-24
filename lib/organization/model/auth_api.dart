class AuthApi {
  List<User>? content;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  String? sort;
  bool? first;
  int? numberOfElements;

  AuthApi(
      {this.content,
        this.totalPages,
        this.totalElements,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.numberOfElements});

  AuthApi.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = List.from(json['content']).map((e)=>User.fromJson(e)).toList();
    }
    totalPages = json['totalPages']??0;
    totalElements = json['totalElements']??0;
    last = json['last'];
    size = json['size']??0;
    number = json['number']??0;
    sort = json['sort']?? '';
    first = json['first'];
    numberOfElements = json['numberOfElements']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    data['sort'] = this.sort;
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    return data;
  }
}

class User {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  int? mobileNumber;
  String? companyName;
  String? companyAddress;
  String? city;
  String? state;
  String? country;
  int? landlineNumber;
  int? mainBranch;
  int? idOfMainBranch;
  int? verified;
  String? companyLogo;
  String? aadharCard;
  String? otp;
  double? ratings;
  int? numberOfTimesRating;
  String? password;
  String? deviceId;
  String? profilePicture;
  String? os;
  String? loggedUserName;
  int? loggedTime;
  int? transporterOrAgent;
  int? preferredRouresEntered;
  int? isPaid;
  String? paidStartDate;
  String? validTill;
  String? website;
  String? alternativeNumber;
  int? companyId;
  int? isUserVerifiedByCompany;
  bool? isSelected;
  bool? addedIngroup;
  String? aadharCardForVerification;
  String? panCardForVerification;

  User(
      {this.addedIngroup,this.isSelected,this.id,
        this.userName,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNumber,
        this.companyName,
        this.companyAddress,
        this.city,
        this.state,
        this.country,
        this.landlineNumber,
        this.mainBranch,
        this.idOfMainBranch,
        this.verified,
        this.companyLogo,
        this.aadharCard,
        this.otp,
        this.ratings,
        this.numberOfTimesRating,
        this.password,
        this.deviceId,
        this.profilePicture,
        this.os,
        this.loggedUserName,
        this.loggedTime,
        this.transporterOrAgent,
        this.preferredRouresEntered,
        this.isPaid,
        this.paidStartDate,
        this.validTill,
        this.website,
        this.alternativeNumber,
        this.companyId,
        this.isUserVerifiedByCompany,
        this.aadharCardForVerification,
        this.panCardForVerification
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']?? 0;
    userName = json['userName']?? '';
    firstName = json['firstName']?? '';
    lastName = json['lastName']?? '';
    emailId = json['emailId']?? '';
    mobileNumber = json['mobileNumber']?? 0;
    companyName = json['companyName']?? '';
    companyAddress = json['companyAddress']?? '';
    city = json['city']?? '';
    state = json['state']?? '';
    country = json['country']?? '';
    landlineNumber = json['landlineNumber']?? 0;
    mainBranch = json['mainBranch']?? 0;
    idOfMainBranch = json['idOfMainBranch']?? 0;
    verified = json['verified']?? 0;
    companyLogo = json['companyLogo']?? '';
    aadharCard = json['aadharCard']?? '';
    otp = json['otp']?? '';
    ratings = json['ratings']?? 0.0;
    numberOfTimesRating = json['numberOfTimesRating']?? 0;
    password = json['password']?? '';
    deviceId = json['deviceId']?? '';
    profilePicture = json['profilePicture']?? '';
    os = json['os']?? '';
    loggedUserName = json['loggedUserName']?? '';
    loggedTime = json['loggedTime']?? 0;
    transporterOrAgent = json['transporterOrAgent']?? 0;
    preferredRouresEntered = json['preferredRouresEntered']?? 0;
    isPaid = json['isPaid']?? 0;
    paidStartDate = json['paidStartDate']?? '';
    validTill = json['validTill']?? '';
    website = json['website']?? '';
    alternativeNumber = json['alternativeNumber']?? '';
    companyId = json['companyId']?? 0;
    isUserVerifiedByCompany = json['isUserVerifiedByCompany']?? 0;
    aadharCardForVerification = json['aadharCardForVerification']?? '';
    panCardForVerification = json['panCardForVerification']?? '';
    isSelected=false;
    addedIngroup=false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobileNumber'] = this.mobileNumber;
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['landlineNumber'] = this.landlineNumber;
    data['mainBranch'] = this.mainBranch;
    data['idOfMainBranch'] = this.idOfMainBranch;
    data['verified'] = this.verified;
    data['companyLogo'] = this.companyLogo;
    data['aadharCard'] = this.aadharCard;
    data['otp'] = this.otp;
    data['ratings'] = this.ratings;
    data['numberOfTimesRating'] = this.numberOfTimesRating;
    data['password'] = this.password;
    data['deviceId'] = this.deviceId;
    data['profilePicture'] = this.profilePicture;
    data['os'] = this.os;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['transporterOrAgent'] = this.transporterOrAgent;
    data['preferredRouresEntered'] = this.preferredRouresEntered;
    data['isPaid'] = this.isPaid;
    data['paidStartDate'] = this.paidStartDate;
    data['validTill'] = this.validTill;
    data['website'] = this.website;
    data['alternativeNumber'] = this.alternativeNumber;
    data['companyId'] = this.companyId;
    data['isUserVerifiedByCompany'] = this.isUserVerifiedByCompany;
    data['aadharCardForVerification'] = this.aadharCardForVerification;
    data['panCardForVerification'] = this.panCardForVerification;
    return data;
  }
}
