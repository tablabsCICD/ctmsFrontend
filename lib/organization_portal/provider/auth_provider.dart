import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/model/validation_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';


extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

class  AuthProvider extends ChangeNotifier{
  List<ConnectUser> userDetailList = [];
  List<ConnectUser> userList = [];
  var response;
  bool isLoading = false;
  String dropdownValue = 'English';
  String uploadedAadhar = '';
  String uploadedPan = '';
  String panCard = '';

   saveUser({String? aadharCard,String? alternativeNumber,String? city,String? companyAddress,int? companyId,String? companyLogo,
    String? companyName,String? country,String? deviceId,String? emailId,String? firstName,int? id,int? idOfMainBranch,int? isPaid,
    int? isUserVerifiedByCompany,int? landlineNumber,String? lastName,String? loggedTime,String? loggedUserName,
    int? mainBranch,int? mobileNumber ,int? numberOfTimesRating,
    String? os,String? otp,String? paidStartDate,String? password,int? preferredRouresEntered,String? profilePicture,int? rating,
    int? transporterOrAgent,int? verified,String? state,String? userName,String? validTill,String? website
  }) async {
    String myUrl = AppConstants.REGISTRATION;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "aadharCard": aadharCard,
      "alternativeNumber": alternativeNumber,
      "city": city,
      "companyAddress": companyAddress,
      "companyId": companyId?? 0,
      "companyLogo": companyLogo,
      "companyName": companyName,
      "country": country,
      "deviceId": deviceId,
      "emailId": emailId,
      "firstName": firstName,
      "id": 0,
      "idOfMainBranch": idOfMainBranch?? 0,
      "isPaid": isPaid?? 0,
      "isUserVerifiedByCompany": isUserVerifiedByCompany??0,
      "landlineNumber": landlineNumber??0,
      "lastName": lastName,
      "loggedTime": " ",
      "loggedUserName": loggedUserName,
      "mainBranch": mainBranch?? 0,
      "mobileNumber": mobileNumber?? 0,
      "numberOfTimesRating": numberOfTimesRating?? 0,
      "os": os,
      "otp": otp,
      "paidStartDate":paidStartDate,
      "password": password,
      "preferredRouresEntered": preferredRouresEntered??0,
      "profilePicture": profilePicture,
      "ratings": rating?? 0,
      "state": state,
      "transporterOrAgent": transporterOrAgent?? 0,
      "userName": userName,
      "validTill": validTill,
      "verified": verified??0,
      "website": website
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = AuthApi.fromJson(response);
    userDetailList = list.content!;
    notifyListeners();
  }

  updateUser({String? aadharCard,String? alternativeNumber,String? city,String? companyAddress,int? companyId,String? companyLogo,
    String? companyName,String? country,String? deviceId,String? emailId,String? firstName,int? id,int? idOfMainBranch,int? isPaid,
    int? isUserVerifiedByCompany,int? landlineNumber,String? lastName,String? loggedTime,String? loggedUserName,
    int? mainBranch,int? mobileNumber ,int? numberOfTimesRating,
    String? os,String? otp,String? paidStartDate,String? password,int? preferredRouresEntered,String? profilePicture,double? rating,
    int? transporterOrAgent,int? verified,String? state,String? userName,String? validTill,String? website
  }) async {
    String myUrl = AppConstants.REGISTRATION;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "aadharCard": aadharCard ?? userDetailList[0].aadharCard ?? '',
      "aadharCardForVerification": aadharCard ?? userDetailList[0].aadharCard ?? '',
      "alternativeNumber": aadharCard ?? userDetailList[0].alternativeNumber,
      "city": city ?? userDetailList[0].city,
      "companyAddress": companyAddress ?? userDetailList[0].companyAddress,
      "companyId": companyId ?? userDetailList[0].companyId ?? 0,
      "companyLogo": companyLogo ?? userDetailList[0].companyLogo,
      "companyName": companyName ?? userDetailList[0].companyName,
      "country": country ?? userDetailList[0].country,
      "deviceId": deviceId ?? userDetailList[0].deviceId,
      "emailId": emailId ?? userDetailList[0].emailId,
      "firstName": firstName ?? userDetailList[0].firstName,
      "id": id ?? userDetailList[0].id?? 0 ,
      "idOfMainBranch": idOfMainBranch ?? userDetailList[0].idOfMainBranch ?? 0,
      "isPaid": isPaid ?? userDetailList[0].isPaid ?? 0,
      "isUserVerifiedByCompany": isUserVerifiedByCompany ?? userDetailList[0].isUserVerifiedByCompany ?? 0,
      "landlineNumber": landlineNumber ?? userDetailList[0].landlineNumber ?? 0,
      "lastName": lastName ?? userDetailList[0].lastName,
      "loggedTime": '',
      "loggedUserName": loggedUserName ?? userDetailList[0].loggedUserName,
      "mainBranch": mainBranch ?? userDetailList[0].mainBranch ?? 0,
      "mobileNumber": mobileNumber ?? userDetailList[0].mobileNumber ?? 0,
      "numberOfTimesRating": numberOfTimesRating ?? userDetailList[0].numberOfTimesRating ?? 0,
      "os": os ?? userDetailList[0].os,
      "otp": otp ?? userDetailList[0].otp,
      "paidStartDate":paidStartDate ?? userDetailList[0].paidStartDate,
      "password": password ?? userDetailList[0].password,
      "preferredRouresEntered": preferredRouresEntered?? userDetailList[0].preferredRouresEntered ?? 0,
      "profilePicture": profilePicture ?? userDetailList[0].profilePicture,
      "ratings": rating ?? userDetailList[0].ratings ?? 0,
      "state": state ?? userDetailList[0].state,
      "transporterOrAgent": transporterOrAgent ?? userDetailList[0].transporterOrAgent ?? 0,
      "userName": userName ?? userDetailList[0].userName,
      "validTill": validTill ?? userDetailList[0].validTill,
      "verified": verified ?? userDetailList[0].verified ?? 0,
      "website": website ?? userDetailList[0].website

    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    print(createResponse.body);
    var response = await json.decode(createResponse.body);
    AuthApi authApi = AuthApi.fromJson(response);
    userDetailList = authApi.content!;
    notifyListeners();
    return authApi;
  }

  deleteUser(ConnectUser user) async {
    String myUrl = AppConstants.REGISTRATION + '?id=${user.id}';
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    userDetailList.remove(user);
    notifyListeners();
  }

  saveTestingUser({String? aadharCard,String? aadharCardForVerification,String? panCardForVerification,String? alternativeNumber,String? city,String? companyAddress,int? companyId,String? companyLogo,
    String? companyName,String? country,String? deviceId,String? emailId,String? firstName,int? id,int? idOfMainBranch,int? isPaid,
    int? isUserVerifiedByCompany,int? landlineNumber,String? lastName,String? loggedTime,String? loggedUserName,
    int? mainBranch,int? mobileNumber ,int? numberOfTimesRating,
    String? os,String? otp,String? paidStartDate,String? password,int? preferredRouresEntered,String? profilePicture,int? rating,
    int? transporterOrAgent,int? verified,String? state,String? userName,String? validTill,String? website
  }) async {
    String myUrl = AppConstants.REGISTRATION;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
    "aadharCard": aadharCard,
    "aadharCardForVerification": aadharCard,
    "alternativeNumber": alternativeNumber,
    "city": city,
    "companyAddress": companyAddress,
    "companyId": companyId ?? 0,
    "companyLogo": companyLogo,
    "companyName": companyName,
    "country": country,
    "deviceId": deviceId,
    "emailId": emailId,
    "firstName": firstName,
    "id": id ?? 0,
    "idOfMainBranch": idOfMainBranch ?? 0,
    "isPaid": isPaid ?? 0,
    "isUserVerifiedByCompany": isUserVerifiedByCompany ?? 0,
    "landlineNumber": landlineNumber ?? 0,
    "lastName": lastName,
    "loggedTime":loggedTime,
    "loggedUserName": loggedUserName,
    "mainBranch": mainBranch ?? 0,
    "mobileNumber": mobileNumber ?? 0,
    "numberOfTimesRating": numberOfTimesRating ?? 0,
    "os": os,
    "otp": otp,
    "paidStartDate": paidStartDate,
    "panCardForVerification": panCardForVerification,
    "password": password,
    "preferredRouresEntered": preferredRouresEntered ?? 0,
    "profilePicture": profilePicture,
    "ratings": 5,
    "state": state,
    "transporterOrAgent": transporterOrAgent ?? 0,
    "userName": userName,
    "validTill": validTill,
    "verified": verified ?? 0,
    "website": website

    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = AuthApi.fromJson(response);
    userDetailList = list.content!;
    notifyListeners();
  }






  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _phone = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get phone => _phone;
  ValidationModel get name => _name;

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please Enter a Valid Email');
    }
    notifyListeners();
  }
  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
    } else {
      _password = ValidationModel(null,
          'Password must contain an uppercase, lowercase, numeric digit and special character');
    }
    notifyListeners();
  }
  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationModel(val, null);
    } else {
      _name = ValidationModel(null, 'Please enter a valid name');
    }
    notifyListeners();
  }
  void validatePhone(String? val) {
    if (val != null && val.isValidPhone) {
      _phone = ValidationModel(val, null);
    } else {
      _phone = ValidationModel(null, 'Phone Number must be up to 11 digits');
    }
    notifyListeners();
  }
  bool get validate {
    return _email.value != null &&
        _password.value != null &&
        _phone.value != null &&
        _name.value != null;
  }
}