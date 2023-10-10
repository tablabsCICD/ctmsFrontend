
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization/model/auth_api.dart';
import 'package:flutter_hr_management/organization/model/biding_user_model.dart';
import 'package:flutter_hr_management/organization/model/organization/org_biding_model.dart';
import 'package:flutter_hr_management/organization/model/organization/org_buy_sell_model.dart';
import 'package:flutter_hr_management/organization/model/organization/org_full_load_model.dart';
import 'package:flutter_hr_management/organization/model/organization/org_pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/organization/org_static_data_model.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';

class OrgProvider extends ChangeNotifier{
  List<Organization> orgVerifiedList = [];
  List<Organization> orgList = [];
  List<Organization> orgnization = [];
  List<User> userList = [];
  List<User> allUserList = [];
  List<User> rejectedUserList = [];
  List<User> approvedUserList = [];
  List<User> pendingUserList = [];

  List<ListOfFullTruckLoad> fullLoadList = [];
  List<ListOfBiding> bidList = [];
  List<ListOfBuySell> buySellList = [];
  List<ListOfBulkBuySell> orgoopPurchaseList = [];
  List<ListOfUsers> listOfUsers = [];

  List<OrgFullLoadModel> orgFullLoadList = [];
  List<OrgFullLoadModel> orgAllFullLoadList = [];
  List<OrgFullLoadModel> orgFLAList = [];
  List<OrgFullLoadModel> orgFLRList = [];
  List<OrgFullLoadModel> orgPLAList = [];
  List<OrgFullLoadModel> orgPLRList = [];

  List<OrgPoolPurchaseModel> orgPoolPurchaseList = [];
  List<OrgPoolPurchaseModel> orgAllPoolPurchaseList = [];
  List<OrgPoolPurchaseModel> orgVehicleList = [];
  List<OrgPoolPurchaseModel> orgTyreList = [];
  List<OrgPoolPurchaseModel> orgBodyBuildingList = [];
  List<OrgPoolPurchaseModel> orgFinanceList = [];
  List<OrgPoolPurchaseModel> orgInsuranceList = [];
  List<OrgPoolPurchaseModel> orgOtherList = [];

  List<OrgBuySellModel> orgBuySellList = [];
  List<OrgBuySellModel> orgBuyList = [];
  List<OrgBuySellModel> orgSellList = [];

  List<OrgBidingModel> orgBigingList = [];

  var response;
  int userCount=0,allPostCount=0,buySellPostCount=0,poolPurchasePostCount=0,fullLoadPostCount=0,bidCont=0;

  sendOtpByOrgId(String mobile) async {
    String myUrl = AppConstants.BASE_URL + 'sendMobileOTPForCompanyLogin?mobileNumber=${mobile}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtpByOrgId(String mobile,String otp,String deviceId) async {
    String myUrl = AppConstants.BASE_URL + 'verifyOTPForCompany?mobileNumber=${mobile}&otp=${otp}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var obj = Organization.fromJson(response[0]);
    print(response);
    notifyListeners();
    return obj;
  }


  sendOtpUsingEmail(String email) async {
    String myUrl = AppConstants.BASE_URL + 'SendOTPOnCompanyEmailId?emailId=${email}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtpUsingEmail(String email,String otp,String deviceId) async {
    String myUrl = AppConstants.BASE_URL + 'verifyOTPCompanyEmail?emailId=${email}&otp=${otp}&deviceId=${deviceId}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = OrganizationModel.fromJson(response);
    Organization organization = list as Organization;
    notifyListeners();
    return organization;
  }
  bool isLoading = false;

  getOrganizationList({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      orgVerifiedList.clear();
    }
    String myUrl = AppConstants.COMPANY + '?page=0&size=100';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    var response = json.decode(req.body);
    var type = OrganizationModel.fromJson(response);
    orgList.clear();
    orgVerifiedList.clear();
    orgList.addAll(type.content);
    orgList.forEach((element) {
      if(element.isVerified == 1){
        orgVerifiedList.add(element);
      }
      print("verifiedList length:   "+orgVerifiedList.length.toString());
    });
    notifyListeners();
  }

  setCompanyVisitingFlag(bool flag) async {
    if(flag == false){
      orgnization = [];
      notifyListeners();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Visited", flag);
    notifyListeners();
  }

  setCompanyOrgId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("c_id", id );
  }

  Future<bool?> getCompanyVisitingFlag() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    bool? alreadyVisited = await preferences.getBool("Visited")?? false;
    return alreadyVisited;
  }

  Future<int?> getCompanyOrgId() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    int? id = await preferences.getInt("c_id")!;
    return id;
  }

  getCompanyDetails(int id) async {
    String myUrl = AppConstants.BASE_URL + 'CompanyDetails/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = OrganizationModel.fromJson(response);
    orgnization = list.content;
    notifyListeners();
    return orgnization;
  }

  getUsersByCompanyId(int id) async {
    String myUrl = AppConstants.BASE_URL + 'companyRegistration/byCompany?companyId=${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = AuthApi.fromJson(response);
    userList = list.content!;
    allUserList.clear();
    allUserList.addAll(userList);
    approvedUserList.clear();
    pendingUserList.clear();
    rejectedUserList.clear();
    userList.forEach((element) {
      if(element.isUserVerifiedByCompany == 1){
        approvedUserList.add(element);
      }else if(element.isUserVerifiedByCompany == 0){
        rejectedUserList.add(element);
      }
      else{
        pendingUserList.add(element);
      }
    });
    userCount = userList.length;
    notifyListeners();
  }

  getUserList(String title){
    userList.clear();
    if(title == "All Users"){
      userList.addAll(allUserList);
      notifyListeners();}
    if(title == "Approved"){
      userList.addAll(approvedUserList);
      notifyListeners();}
    if(title == "Rejected"){
      userList.addAll(rejectedUserList);
      notifyListeners();}
    if(title == "Pending") {
      userList.addAll(pendingUserList);
      notifyListeners();
    }
  }
  createOrg({String? panCard,String? tanCard,String? city,String? companyAddress,String? cMobile,String? gst,
    String? companyName,String? gst1,String? typeOfRegistration,String? landlineNumber,int? numberOfTimesRating, int? rating,
    int? verified,String? state,String? offEmail,String? pointName,String? website
  }) async {
    String myUrl = AppConstants.COMPANY;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "city": city,
      "companyAddress": companyAddress,
      "companyMobileNumber": cMobile,
      "companyName": companyName,
      "gstNumber": gst,
      "gstNumber2": uploadedDocs,
      "id": 0,
      "isVerified": verified,
      "landlineNumber": landlineNumber,
      "numberOfRatings": numberOfTimesRating,
      "officialEmailId": offEmail,
      "panCardNumber": panCard,
      "pointOfContact": pointName,
      "rating": rating,
      "state": state,
      "tanCardNumber": tanCard,
      "typeOfRegistration": typeOfRegistration,
      "website": website
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var jsonData = jsonDecode(createResponse.body);
    Organization dataObj = Organization.fromJson(jsonData);
    orgVerifiedList.add(dataObj);
    notifyListeners();
  }

  getStaticData(int id) async {
    isLoading = true;
    notifyListeners();
    //String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getStastitcs?organizationId=${id}";
    String myUrl = AppConstants.BASE_URL+"/getStastitcs?organizationId=${id}";
    print("GET COUNT URL : "+myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    var response = json.decode(req.body);
    var type = OrgStaticDataModel.fromJson(response);
    print(response);
    userCount = type.numberOfEmployees;
    fullLoadPostCount = type.numberOfFullLoadPosts;
    bidCont = type.numberOfBids;
    poolPurchasePostCount = type.numberOfPoolPurchase;
    buySellPostCount = type.numberOfBuySellPosts;
    fullLoadList = type.listOfFullTruckLoad;
    buySellList = type.listOfBuySell;
    orgoopPurchaseList = type.listOfBulkBuySell;
    bidList = type.listOfBiding;
    listOfUsers = type.listOfUsers;
    notifyListeners();
  }


  getOrgBidingList(int id) async {
    isLoading = true;
    notifyListeners();
  //  String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getBiding/ForOrganisation?organizationId=26";
    String myUrl = AppConstants.BASE_URL+ "/getBiding/ForOrganisation?organizationId=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      final response = json.decode(req.body);
      orgBigingList = List<OrgBidingModel>.from(response.map((json) => OrgBidingModel.fromJson(json)));
      orgBigingList.sort((a, b) => int.parse(a.amount!).compareTo(int.parse(b.amount!)));
      print('Low to hight in biding amount: $orgBigingList');
      orgBigingList.forEach((element) {print("amount : "+element.amount.toString());});
      notifyListeners();
    }
  }

 getBuyVehicles(int id) async {
    isLoading = true;
    notifyListeners();
   // String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getBuySell/ForOrganisation?organizationId=26";
    String myUrl = AppConstants.BASE_URL + "getBuySell/ForOrganisation?organizationId=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    final response = json.decode(req.body);
    orgBuySellList = List<OrgBuySellModel>.from(response.map((json) => OrgBuySellModel.fromJson(json)));
    orgBuyList.clear();
    orgSellList.clear();
    orgBuySellList.forEach((element) {
      if(element.mainTag == "Buy vehicle"){
        orgBuyList.add(element);
      }else {
        orgSellList.add(element);
      }
    });
    notifyListeners();
  }

  getOrgFullLoadList(int id) async {
    isLoading = true;
    notifyListeners();
    //String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getFullLoad/ForOrganisation?organizationId=26";
    String myUrl = AppConstants.BASE_URL+"getFullLoad/ForOrganisation?organizationId=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      final response = json.decode(req.body);
      orgFullLoadList = List<OrgFullLoadModel>.from(response.map((json) => OrgFullLoadModel.fromJson(json)));
      orgAllFullLoadList.clear();
      orgAllFullLoadList.addAll(orgFullLoadList);
      orgFLAList.clear();
      orgFLRList.clear();
      orgPLAList.clear();
      orgPLRList.clear();
      orgFullLoadList.forEach((element) {
        if(element.mainTag == "Full load available"){
          orgFLAList.add(element);
        }else if(element.mainTag == "Full load required"){
          orgFLRList.add(element);
        }else if(element.mainTag == "Part load available"){
          orgPLAList.add(element);
        }
        else{
          orgPLRList.add(element);
        }
      });
      notifyListeners();
    }
  }

  getFilterFullLoadList(String title){
    orgFullLoadList.clear();
    if(title == "All Loads"){
      orgFullLoadList.addAll(orgAllFullLoadList);
      notifyListeners();}
    if(title == "Full Load Available"){
      orgFullLoadList.addAll(orgFLAList);
      notifyListeners();}
    if(title == "Full Load Required"){
      orgFullLoadList.addAll(orgFLRList);
      notifyListeners();}
    if(title == "Part Load Available") {
      orgFullLoadList.addAll(orgPLAList);
      notifyListeners();
    }
    if(title == "Part Load Required") {
      orgFullLoadList.addAll(orgPLRList);
      notifyListeners();
    }
  }
  getOrgPoolPurchaseList(int id) async {
    isLoading = true;
    notifyListeners();
   // String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getBulkBuySell/ForOrganisation?organizationId=26";
    String myUrl = AppConstants.BASE_URL + "getBulkBuySell/ForOrganisation?organizationId=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      final response = json.decode(req.body);
      orgPoolPurchaseList = List<OrgPoolPurchaseModel>.from(response.map((json) => OrgPoolPurchaseModel.fromJson(json)));
      orgAllPoolPurchaseList.clear();
      orgAllPoolPurchaseList.addAll(orgPoolPurchaseList);
      orgVehicleList.clear();
      orgTyreList.clear();
      orgBodyBuildingList.clear();
      orgFinanceList.clear();
      orgInsuranceList.clear();
      orgOtherList.clear();
      orgPoolPurchaseList.forEach((element) {
        if(element.purchaseItem == "Vehicle"){
          orgVehicleList.add(element);
        }else if(element.purchaseItem == "Tyres"){
          orgTyreList.add(element);
        }else if(element.purchaseItem == "Body Building"){
          orgBodyBuildingList.add(element);
        }else if(element.purchaseItem == "Insurance"){
          orgInsuranceList.add(element);
        }else if(element.purchaseItem == "Finance"){
          orgFinanceList.add(element);
        }
        else{
          orgOtherList.add(element);
        }
      });
      notifyListeners();
    }
  }

  getFilterPoolPurchaseList(String title){
    orgPoolPurchaseList.clear();
    if(title == "All Requirement"){
      orgPoolPurchaseList.addAll(orgAllPoolPurchaseList);
      notifyListeners();}
    if(title == "Vehicles"){
      orgPoolPurchaseList.addAll(orgVehicleList);
      notifyListeners();}
    if(title == "Tyres"){
      orgPoolPurchaseList.addAll(orgTyreList);
      notifyListeners();}
    if(title == "Body Building") {
      orgPoolPurchaseList.addAll(orgBodyBuildingList);
      notifyListeners();
    }
    if(title == "Finance") {
      orgPoolPurchaseList.addAll(orgFinanceList);
      notifyListeners();
    }
    if(title == "Insurance") {
      orgPoolPurchaseList.addAll(orgInsuranceList);
      notifyListeners();
    }
    if(title == "Other") {
      orgPoolPurchaseList.addAll(orgOtherList);
      notifyListeners();
    }
  }

  getSearchByNameList(String name,String source,String dest) async {
    isLoading = true;
    notifyListeners();
    orgFullLoadList.clear();
    String myUrl = AppConstants.FULL_LOAD_ALL_CARD +'?nameOfPerson=${name}&source=${source}&destination=${dest}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading == false;
    response = json.decode(req.body);
    orgFullLoadList = List<OrgFullLoadModel>.from(response.map((json) => OrgFullLoadModel.fromJson(json)));
    notifyListeners();
  }


  deleteFullLoad(OrgFullLoadModel truckLoad) async {
    String myUrl = AppConstants.BASE_URL + 'fullTruckLoad?id=${truckLoad.id}';
    print(myUrl);

    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    print(deleteResponse);
    truckLoad.type == 'Full Load'
        ? orgFullLoadList.remove(truckLoad)
        : orgFullLoadList.remove(truckLoad);
    notifyListeners();
  }

  deleteBuySell(OrgBuySellModel truckLoad) async {
    String myUrl = AppConstants.POST_BUY_SELL + '?id=${truckLoad.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    orgBuySellList.remove(truckLoad);
    notifyListeners();
  }

 deletePoolPurchase(OrgPoolPurchaseModel obj) async {
    String myUrl = AppConstants.BULK_DATA + '?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    orgPoolPurchaseList.remove(obj);
    notifyListeners();
  }

  deleteBid(OrgBidingModel bid) async {
    String myUrl = AppConstants.BID_TO_POST + '?id=${bid.bidingId}';
    print(myUrl);
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    print(response);
    orgBigingList.remove(bid);
    notifyListeners();
  }

  String? image;
  String? uploadedDocs;
  Future setImage(img) async{
    this.image = img;
    this.notifyListeners();
  }

  uploadCompanyDocuments({String? imageFilePath,
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
      uploadedDocs = null;
      uploadedDocs = value.toString();
    });
    return uploadedDocs;
  }
}