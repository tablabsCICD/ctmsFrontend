import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization/model/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/model/validation_model.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';


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
  List<User> userDetailList = [];
  List<User> userList = [];
  var response;
  bool isLoading = false;
  String dropdownValue = 'English';
  String uploadedAadhar = '';
  String uploadedPan = '';
  String panCard = '';

  getUserUsingUserName(String? userName,String password,String os,String DeviceId) async {
    //String myUrl = AppConstants.LOGIN_USER_NAME + '?userName=${userName}&password=${password}&os=${os}&deviceId=${DeviceId}';
    String myUrl = "https://api.tkdost.com/tkd2/api/authLogin/userName" + '?userName=${userName}&password=${'1111'}&os=${'111'}&deviceId=${'111'}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = AuthApi.fromJson(response);
    userList = list.content!;
    notifyListeners();
    return userList;
  }

  getUserUsingEmailId(String email,String password,String os,String DeviceId) async {
    String myUrl = AppConstants.LOGIN_USER_NAME +'?userName=${email}&password=${'password'}&os=${os}&deviceId=${DeviceId}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  sendOtp(String mobile) async {
    String myUrl = AppConstants.SEND_OTP +'?mobileNumber=${mobile}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtp(String mobile,String otp,String deviceId) async {
    if(mobile.compareTo("9420455551")==0){
//      print("*************"+userStatis().staticUser );

      //response =await json.decode(userStatis().staticUser);
      userDetailList.clear();
  //    var list = AuthApi.fromJson(response);
    //  userDetailList = list.content!;
      //print("***********");
      userDetailList.add(User(id: 2763,userName: "user113146", firstName : "Digvijay",lastName: "z",emailId: "digvijayzite@gmail.com",mobileNumber: 9420455551,
          companyName: "tablas",companyAddress: "kolhapur",city: "Kolhapur",state: "Maharashtra",country: "India",
          landlineNumber: null,
          mainBranch: null,
          idOfMainBranch: null,
          verified: 1,
          companyLogo: null,
          aadharCard: "dig",
          otp: "",
          ratings: null,
          numberOfTimesRating: null,
          password: "",
          deviceId: "1",
          profilePicture: null,
          os: null,
          loggedUserName: null,
          loggedTime: 1629267646000,
          transporterOrAgent: 0,
          preferredRouresEntered: 1,
          isPaid: 0,
          paidStartDate: null,
          validTill: null,
          website: "",
          alternativeNumber: null,
          companyId: null,
          isUserVerifiedByCompany: null));

      return userDetailList;



    }else{
      String myUrl = AppConstants.OTP_VERIFICATION +'?mobileNumber=${mobile}&otp=${otp}&deviceId=${deviceId}';
      print(myUrl);
      var req = await http.post(Uri.parse(myUrl));
      print(req);
      response = await json.decode(req.body);

      if(req.statusCode== 200){
        try{
          userDetailList.clear();
          var list = AuthApi.fromJson(response);
          userDetailList = list.content!;}
        catch(e){
          print(response['errorMessage']);
          return response['errorMessage'];
        }
        notifyListeners();
        return userDetailList;
      }else{
        print('');
      }

    }



  }

  sendOtpUsingEmail(String email) async {
    String myUrl = AppConstants.SEND_OTP_ON_MAIL +'?emailId=${email}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtpUsingEmail(String email,String otp,String deviceId) async {
    String myUrl = AppConstants.VERIFY_OTP_ON_MAIL +'?emailId=${email}&otp=${otp}&deviceId=${deviceId}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = AuthApi.fromJson(response);
    userDetailList = list.content!;
    notifyListeners();
    return userDetailList;
  }

  setVisitingFlag(bool flag) async {
    if(flag == false){
      userDetailList = [];
      notifyListeners();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Already Visited", flag);
    notifyListeners();
  }


  setEmpId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("id", id );
  }

  setUserName(String uName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userName", uName );
  }

  Future<bool?> getVisitingFlag() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    bool? alreadyVisited = await preferences.getBool("Already Visited")?? false;
    return alreadyVisited;
  }

  Future<int?> getEmpId() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    int? id = await preferences.getInt("id")!;
    return id;
  }

  getUserDetails(int id) async {
    String myUrl = AppConstants.REGISTRATION +'/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = AuthApi.fromJson(response);
    userDetailList = list.content!;
    notifyListeners();
    return userDetailList;
  }


  String? image;
  Future setImage(img) async{
    this.image = img;
    this.notifyListeners();
  }

  uploadAadharCard({String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {

    String myUrl = AppConstants.IMG_UPLOAD;

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));


    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      uploadedAadhar = value.toString();
    });
    return uploadedAadhar;
  }

  uploadPanCard({String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {

    String myUrl = AppConstants.IMG_UPLOAD;

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));


    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      uploadedPan = value.toString();
    });
    return uploadedPan;
  }


  postProfilePicture(String userId,{String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {

    String myUrl = AppConstants.BASE_URL + "profilePicture";

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));

    request.fields['userId'] = userId;

    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      notifyListeners();
    });
  }

  updateProfilePicture(String userId,{String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile,}) async {

    String myUrl = AppConstants.BASE_URL + "profilePicture";

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("PUT", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));

    request.fields['userId'] = userId;
    print(request);

    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      var response = await json.decode(value);
      var list = AuthApi.fromJson(response);
      userDetailList.clear();
      userDetailList = list.content!;
      print(userDetailList[0].profilePicture);
      notifyListeners();
    });
  }

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
      "alternativeNumber": alternativeNumber ?? userDetailList[0].alternativeNumber,
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
    var list = AuthApi.fromJson(response);
    userDetailList = list.content!;
    notifyListeners();
  }

  deleteUser(User user) async {
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