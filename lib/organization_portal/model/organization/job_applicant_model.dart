class JobApplicantsModel {
  String? message;
  JobApplicantList? data;
  bool? success;

  JobApplicantsModel({this.message, this.data, this.success});

  JobApplicantsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new JobApplicantList.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class JobApplicantList {
  int? noOfApplicants;
  JobDetails? jobDetails;
  List<ApplicantList>? applicantList;

  JobApplicantList({this.noOfApplicants, this.jobDetails, this.applicantList});

  JobApplicantList.fromJson(Map<String, dynamic> json) {
    noOfApplicants = json['noOfApplicants'];
    jobDetails = json['jobDetails'] != null
        ? new JobDetails.fromJson(json['jobDetails'])
        : null;
    if (json['applicantList'] != null && json['applicantList'] is List) {
      applicantList = <ApplicantList>[];
      json['applicantList'].forEach((v) {
        applicantList!.add(new ApplicantList.fromJson(v));
      });
    } else {
      applicantList = []; // fallback if data is "", null, or not a list
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noOfApplicants'] = this.noOfApplicants;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.toJson();
    }
    if (this.applicantList != null) {
      data['applicantList'] =
          this.applicantList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobDetails {
  int? id;
  String? companyName;
  String? emailId;
  int? contactNumber;
  String? jobLocation;
  String? jobDescription;
  String? jobType;
  String? experience;
  String? jobDepartment;
  String? salary;
  int? isSalaryNegotiable;
  String? message;
  int? isSelected;
  int? removedDate;
  String? os;
  String? loggedUserName;
  int? loggedTime;
  int? privatePost;
  String? tableName;
  String? mainTag;
  String? postingTime;
  String? topicName;
  String? type;

  JobDetails(
      {this.id,
        this.companyName,
        this.emailId,
        this.contactNumber,
        this.jobLocation,
        this.jobDescription,
        this.jobType,
        this.experience,
        this.jobDepartment,
        this.salary,
        this.isSalaryNegotiable,
        this.message,
        this.isSelected,
        this.removedDate,
        this.os,
        this.loggedUserName,
        this.loggedTime,
        this.privatePost,
        this.tableName,
        this.mainTag,
        this.postingTime,
        this.topicName,
        this.type});

  JobDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    emailId = json['emailId'];
    contactNumber = json['contactNumber'];
    jobLocation = json['jobLocation'];
    jobDescription = json['jobDescription'];
    jobType = json['jobType'];
    experience = json['experience'];
    jobDepartment = json['jobDepartment'];
    salary = json['salary'];
    isSalaryNegotiable = json['isSalaryNegotiable'];
    message = json['message'];
    isSelected = json['isSelected'];
    removedDate = json['removedDate'];
    os = json['os'];
    loggedUserName = json['loggedUserName'];
    loggedTime = json['loggedTime'];
    privatePost = json['privatePost'];
    tableName = json['tableName']??'';
    mainTag = json['mainTag'];
    postingTime = json['postingTime'];
    topicName = json['topicName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['emailId'] = this.emailId;
    data['contactNumber'] = this.contactNumber;
    data['jobLocation'] = this.jobLocation;
    data['jobDescription'] = this.jobDescription;
    data['jobType'] = this.jobType;
    data['experience'] = this.experience;
    data['jobDepartment'] = this.jobDepartment;
    data['salary'] = this.salary;
    data['isSalaryNegotiable'] = this.isSalaryNegotiable;
    data['message'] = this.message;
    data['isSelected'] = this.isSelected;
    data['removedDate'] = this.removedDate;
    data['os'] = this.os;
    data['loggedUserName'] = this.loggedUserName;
    data['loggedTime'] = this.loggedTime;
    data['privatePost'] = this.privatePost;
    data['tableName'] = this.tableName;
    data['mainTag'] = this.mainTag;
    data['postingTime'] = this.postingTime;
    data['topicName'] = this.topicName;
    data['type'] = this.type;
    return data;
  }
}

class ApplicantList {
  int? id;
  int? jobId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? emailId;
  String? applyDate;
  String? document;
  String? qualification;
  List<String>? skills;
  String? applicationId;

  ApplicantList(
      {this.id,
        this.jobId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.emailId,
        this.applyDate,
        this.document,
        this.qualification,
        this.skills,
        this.applicationId});

  ApplicantList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    firstName = json['firstName']??"-";
    lastName = json['lastName']??'-';
    mobile = json['mobile']??"-";
    emailId = json['emailId']??'-';
    applyDate = json['applyDate']??"-";
    document = json['document']??"-";
    qualification = json['qualification']??'-';
    if (json['skills'] != null) {
      skills = <String>[];
      json['skills'].forEach((v) {
        skills!.add((v));
      });
    }
    applicationId = json['applicationId']??'-';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['emailId'] = this.emailId;
    data['applyDate'] = this.applyDate;
    data['document'] = this.document;
    data['qualification'] = this.qualification;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v).toList();
    }
    data['applicationId'] = this.applicationId;
    return data;
  }
}
