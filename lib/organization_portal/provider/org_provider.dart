import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/branch_model.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/branch_response_model.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/company/load_list.dart';
import 'package:flutter_hr_management/organization_portal/model/load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_quote_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/search_load_list.dart';
import 'package:flutter_hr_management/organization_portal/model/tkd_user_mobile_response.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/biding_user_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_biding_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_buy_sell_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_full_load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_static_data_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

class OrgProvider extends ChangeNotifier {
  List<Organization> orgVerifiedList = [];
  List<Organization> orgList = [];
  List<Organization> orgnization = [];

  List<ConnectUser> userList = [];
  List<ConnectUser> allUserList = [];
  List<ConnectUser> rejectedUserList = [];
  List<ConnectUser> approvedUserList = [];
  List<ConnectUser> pendingUserList = [];

  List<OrgFullLoadModel> orgFullLoadList = [];
  List<OrgFullLoadModel> orgAllFullLoadList = [];
  List<OrgFullLoadModel> orgFLAList = [];
  List<OrgFullLoadModel> orgFLRList = [];
  List<OrgFullLoadModel> orgPLAList = [];
  List<OrgFullLoadModel> orgPLRList = [];

  List<OrgBuySellModel1> orgBuySellList = [];
  List<OrgBuySellModel1> orgBuyList = [];
  List<OrgBuySellModel1> orgSellList = [];
  List<OrgBuySellModel1> finalBuySellList = [];

  List<QuoteWithPostDetailList> orgBigingList = [];
  List<QuoteWithPostDetailList> placedBigingList = [];
  List<QuoteWithPostDetailList> receivedBigingList = [];

  List<OrgPoolPurchaseModel> orgPoolPurchaseList = [];
  List<OrgPoolPurchaseModel> orgAllPoolPurchaseList = [];
  List<OrgPoolPurchaseModel> orgVehicleList = [];
  List<OrgPoolPurchaseModel> orgTyreList = [];
  List<OrgPoolPurchaseModel> orgBodyBuildingList = [];
  List<OrgPoolPurchaseModel> orgFinanceList = [];
  List<OrgPoolPurchaseModel> orgInsuranceList = [];
  List<OrgPoolPurchaseModel> orgOtherList = [];

  var response;
  int userCount = 0,
      allPostCount = 0,
      buySellPostCount = 0,
      poolPurchasePostCount = 0,
      fullLoadPostCount = 0,
      bidCont = 0,
      fullLoadCount = 0,
      partLoadCount = 0;

  sendOtpByOrgId(String mobile) async {
    String myUrl = AppConstants.BASE_URL +
        'sendMobileOTPForCompanyLogin?mobileNumber=${mobile}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtpByOrgId(String mobile, String otp, String deviceId) async {
    String myUrl = AppConstants.BASE_URL +
        'verifyOTPForCompany?mobileNumber=${mobile}&otp=${otp}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var obj = Organization.fromJson(response[0]);
    print(response);
    notifyListeners();
    return obj;
  }

  sendOtpUsingEmail(String email) async {
    String myUrl =
        AppConstants.BASE_URL + 'SendOTPOnCompanyEmailId?emailId=${email}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
    return response;
  }

  verifyOtpUsingEmail(String email, String otp, String deviceId) async {
    String myUrl = AppConstants.BASE_URL +
        'verifyOTPCompanyEmail?emailId=${email}&otp=${otp}&deviceId=${deviceId}';
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
    if (currentPage == 0) {
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
      if (element.isVerified == 1) {
        orgVerifiedList.add(element);
      }
      print("verifiedList length:   " + orgVerifiedList.length.toString());
    });
    notifyListeners();
  }

  setCompanyVisitingFlag(bool flag) async {
    if (flag == false) {
      orgnization = [];
      notifyListeners();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Visited", flag);
    notifyListeners();
  }

  setCompanyOrgId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("c_id", id);
  }

  Future<bool?> getCompanyVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? alreadyVisited = await preferences.getBool("Visited") ?? false;
    return alreadyVisited;
  }

  Future<int?> getCompanyOrgId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = await preferences.getInt("c_id")!;
    return id;
  }

  bool isLoad = false;
  Branch? branch;
  List<Branch> branchList=[];
  List<String> branchNameList=['Shreeji'];
  Future<void> getAllBranch(int orgId) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.BASE_URL +
        "api/branch/getAll?organisationId=${orgId}&page=0&size=10&sortDir=asc";
    print("Get All Branch :" + myUrl
    );
    final dio = Dio();
    final response = await dio.get(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      BranchResponse branchResponse =
      BranchResponse.fromJson(jsonDecode(response.data));
      branchNameList.clear();
      branchList.clear();
      branchList.addAll(branchResponse.data!.content as Iterable<Branch>);
      debugPrint("Branch List:: ${branchList}\n ");
      branchList.forEach((element) {
          branchNameList.add(element.branchName!);
      });
      debugPrint("Branch Name List:: ${branchNameList}\n ");
    }
    notifyListeners();
  }

  createOrg(
      {String? panCard,
        String? tanCard,
        String? city,
        String? companyAddress,
        String? cMobile,
        String? gst,
        String? companyName,
        String? gst1,
        String? typeOfRegistration,
        String? landlineNumber,
        int? numberOfTimesRating,
        int? rating,
        int? verified,
        String? state,
        String? offEmail,
        String? pointName,
        String? website}) async {
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
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    var jsonData = jsonDecode(createResponse.body);
    Organization dataObj = Organization.fromJson(jsonData);
    orgVerifiedList.add(dataObj);
    notifyListeners();
  }

  void filterSearchResults(String query, String type) {
    if (type == "User") {
      userList.clear();
      allUserList.forEach((element) {
        if (element.firstName!.toLowerCase().contains(query.toLowerCase()) ||
            element.lastName!.toLowerCase().contains(query.toLowerCase()) ||
            element.mobileNumber!.toString().contains(query)) {
          userList.add(element);
        }
      });
      debugPrint('Final Users : ${userList.length}');
      notifyListeners();
    } else if (type == "Load") {
      orgFullLoadList.clear();
      orgAllFullLoadList.forEach((element) {
        if (element.source!.toLowerCase().contains(query.toLowerCase()) ||
            element.destination!.toLowerCase().contains(query.toLowerCase()) ||
            element.mobileNumber!.toString().contains(query)) {
          orgFullLoadList.add(element);
        }
      });
      debugPrint('Final Load List : ${orgFullLoadList.length}');
      notifyListeners();
    }
  }

  bool isOrgLoading = false;

  getCompanyDetails(int id) async {
    isOrgLoading=true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + 'CompanyDetails/getByID?id=${id}';
    // String myUrl = AppConstants.BASE_URL + 'CompanyDetails/${id}';
    print("GetOrg Details:" + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isOrgLoading=false;
   if(req.statusCode==200){
     response = await json.decode(req.body);
     print("Org Response : "+req.body);
     Organization organizationModel = Organization.fromJson(response);
     orgnization.add(organizationModel);
     notifyListeners();
     return orgnization;
   }else{
     notifyListeners();
     return null;
   }
  }

  int? connectUserId;
  List<String> userNameList = [];

  getUsersByCompanyId(int id) async {
    selectedTab = "All Users";
    String myUrl =
        AppConstants.BASE_URL + 'companyRegistration/byCompany?companyId=${id}';
    print("All users by company::" + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    print("All User response:"+req.body);
    response = await json.decode(req.body);
    var list = AuthApi.fromJson(response);
    userList.clear();
    userList = list.content!;
    allUserList.clear();
    allUserList.addAll(userList);
    approvedUserList.clear();
    pendingUserList.clear();
    userNameList.clear();
    rejectedUserList.clear();
    userList.forEach((element) {
      userNameList.add(element.firstName.toString()+" "+element.lastName.toString());
      if(element.mobileNumber==loginDeatils!.data!.contact){
        connectUserId = element.id;
      }
      if (element.isUserVerifiedByCompany == 1) {
        approvedUserList.add(element);
      } else if (element.isUserVerifiedByCompany == 0) {
        rejectedUserList.add(element);
      } else {
        pendingUserList.add(element);
      }
    });
    userCount = userList.length;
    notifyListeners();
  }

  LoginDeatils? loginDeatils;
  CtmsOrganization? ctmsOrganization;
  getCtmsOrganization() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    final dio = Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    final response = await dio.get(ApiConstant.GET_CTMS_ORG +"?Id=${loginDeatils!.data!.organisationId}",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    CtmsOrganizationResponse ctmsOrganizationResponse = CtmsOrganizationResponse.fromJson(jsonDecode(response.data));
    print(ctmsOrganizationResponse.data);
    ctmsOrganization = ctmsOrganizationResponse.data;
    LocalSharePreferences().setString(SharedPreferencesConstant.connectOrganizationId, ctmsOrganization!.connectOrgId!.toString());
    LocalSharePreferences().setString(SharedPreferencesConstant.connectUserId, ctmsOrganization!.connectUserId!.toString());
    print(ctmsOrganization!.connectOrgId!.toString());
    print(ctmsOrganization!.connectUserId!.toString());
    setCompanyOrgId(ctmsOrganization!.connectOrgId!);
  }

  ConnectUser? connectUser;
  getTkdUserByMobile(BuildContext context,String mobileNumber) async {
    String myUrl = AppConstants.BASE_URL +'/getByMobileNumber?mobileNumber=${mobileNumber}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    if(req.statusCode==200){
      var response = await json.decode(req.body);
      if(response["success"]==true){
        var list = TkdUserByMobileResponse.fromJson(response);
        connectUser = list.data;
      }else{
        showCustomToast(context, response["message"], Icons.check, Colors.green);
      }
    }else{
      showCustomToast(context, "Please try again!!", Icons.close, Colors.red);
    }
    notifyListeners();
    return req;
  }

  getOrgDetails() async {
    getCtmsOrganization();
    List<Organization> organization = await getCompanyDetails(ctmsOrganization!.connectOrgId!);
    print(organization[0].companyName);
    setCompanyOrgId(organization[0].id!);
    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    notifyListeners();
    return organization[0];
  }

  getUserList(String title) {
    userList.clear();

    if (title == "All Users") {
      userList.addAll(allUserList);
      notifyListeners();
    }
    if (title == "Approved") {
      userList.addAll(approvedUserList);
      notifyListeners();
    }
    if (title == "Rejected") {
      userList.addAll(rejectedUserList);
      notifyListeners();
    }
    if (title == "Pending") {
      userList.addAll(pendingUserList);
      notifyListeners();
    }
  }

  String selectedBuySellTab = "Buy a Vehicle";
  String selectedTab = "All Users";



  getStaticData(int id) async {
    isLoading = true;
    notifyListeners();
    //String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getStastitcs?organizationId=${id}";
    String myUrl = AppConstants.BASE_URL+"fullTruckStatistics?companyId=${id}";
     //   "https://api.tkdost.com/tkd2/api/getStastitcs?organizationId=${id}";
    print("GET Statistics URL : " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    var response = json.decode(req.body);
    if(response['data']==''){

    }else{
      var type = OrgStaticDataModel.fromJson(response);
      print(response);
      userCount = type.data!.totalCompanyRegister!;
      fullLoadPostCount = type.data!.totalLoggedUserNameInFullTruck!+type.data!.totalLoggedUserNameWithPartLoad!;
      bidCont = type.data!.totalLoggedUserNameInBiding!;
      buySellPostCount = type.data!.totalLoggedUserNameInBuySell!;
    }
    notifyListeners();
  }

  getReceivedQuoteList(int id) async {
    isLoading = true;
    String myUrl = AppConstants.BASE_URL+ "getOwnPostAndBidByCompanyId?companyId=${id}&latestPost=yes";
    print("Get Received Quote Data by OrgId - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    receivedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);

      receivedBigingList.addAll(orgQuoteModel.content!);
      receivedBigingList.forEach((element) {
        if(element.bidingList!.length == 0 || element.bidingList==[]){

        }else{
          orgBigingList.addAll(receivedBigingList);
          bidCont = receivedBigingList.length;
        }
      });
      notifyListeners();
    }
  }

  getPlacedQuoteList(int id) async {
    isLoading = true;

    String myUrl = AppConstants.BASE_URL+ "getBidderPostAndBidByCompanyId?companyId=${id}&latestPost=yes";
    print("Get Placed Quote Data by OrgId - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    placedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);
      placedBigingList.addAll(orgQuoteModel.content!);
      orgBigingList.addAll(placedBigingList);
      print('Low to high in biding amount: $orgBigingList');
      bidCont = orgBigingList.length;
      orgBigingList.forEach((element) {
        debugPrint("total bids : ${element.bidingList!.length}");
      });
      notifyListeners();
    }
  }

  getPlacedQuoteListByDate(String fromDate,String toDate,int id) async {
    isLoading = true;

    String myUrl = AppConstants.BASE_URL+ "getBidderPostAndBidByCompanyIdWithDateFilter?companyId=${1}&latestPost=yes&startDate=${fromDate}&endDate=${toDate}";
    print("Get Placed Quote Data by Date - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    placedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);
      placedBigingList.addAll(orgQuoteModel.content!);
      orgBigingList.addAll(placedBigingList);
      print('Low to high in biding amount: $orgBigingList');
      bidCont = orgBigingList.length;
      orgBigingList.forEach((element) {
        debugPrint("total bids : ${element.bidingList!.length}");
      });
      notifyListeners();
    }
  }

  String selectedQuoteTab = "Placed Quotes";
  getFinalQuoteList(String title, int? orgId) {
    selectedQuoteTab = title;
    orgBigingList.clear();
    if(selectedQuoteTab=="Placed Quotes"){
      getPlacedQuoteList(orgId!);
      orgBigingList.addAll(placedBigingList);
    }else if(selectedQuoteTab=="Received Quotes"){
      getReceivedQuoteList(orgId!);
      orgBigingList.addAll(receivedBigingList);
    }
    print(selectedQuoteTab +"List"+finalBuySellList.length.toString());
    notifyListeners();
  }

  getBuyVehicles(int id) async {
    // String myUrl = AppConstants.BASE_URL + "getBuySell/ForOrganisation?organizationId=${id}";
    String myUrl = AppConstants.BASE_URL + "GetbuysellcompanyId?company_id=${id}";
    selectedBuySellTab="Buy a Vehicle";
    print("Get BuySell Data By OrgId - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    final response = json.decode(req.body);
    print(response);
    if(req.statusCode ==200) {
      orgBuySellList.clear();
      BuySellModel buySellModel = BuySellModel.fromJson(response);
      orgBuySellList.addAll(buySellModel.data!);
      orgBuyList.clear();
      orgSellList.clear();
      finalBuySellList.clear();
     buySellPostCount = orgBuySellList.length;
     orgBuySellList.forEach((element) {
        if (element.type == "Buy") {
          orgBuyList.add(element);
        } else {
          orgSellList.add(element);
        }
      });
      if(selectedBuySellTab=="Buy"){
        finalBuySellList.addAll(orgBuyList);
      }else{
        finalBuySellList.addAll(orgSellList);
      }
    }
    notifyListeners();
  }

  getFinalBuySellList(String title) {
    selectedBuySellTab = title;
    finalBuySellList.clear();
    if(selectedBuySellTab=="Buy a Vehicle"){
      finalBuySellList.addAll(orgBuyList);
    }else{
      finalBuySellList.addAll(orgSellList);
    }
    print(selectedBuySellTab +"List"+finalBuySellList.length.toString());
    notifyListeners();
  }

  getOrgFullLoadList(int id) async {
    isLoading = true;
    notifyListeners();
    //String myUrl = "https://api.tkdost.com/tkd2/api/getFullLoad/ForOrganisation?organizationId=${id}";
    // String myUrl = AppConstants.BASE_URL+"GetFullLoadByCompanyId?companyId=${id}";
    String myUrl = AppConstants.BASE_URL + "getFullLoadByCompanyIdForMonitoring?companyId=${id}";
    print("Get All Load Truck Data - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    final response = json.decode(req.body);
    print(response);
    isLoading = false;
    notifyListeners();
    if (req.statusCode == 200) {
      FullLoadModel fullLoadModel = FullLoadModel.fromJson(response);
      orgFullLoadList = fullLoadModel.data!;
     /* orgFullLoadList = List<OrgFullLoadModel>.from(
          response.map((json) => OrgFullLoadModel.fromJson(json)));*/
      orgAllFullLoadList.clear();
      orgAllFullLoadList.addAll(orgFullLoadList);
      allPostCount = orgAllFullLoadList.length;
      orgFLAList.clear();
      orgFLRList.clear();
      orgPLAList.clear();
      orgPLRList.clear();
      orgFullLoadList.forEach((element) {
        if (element.mainTag == "Full load available") {
          orgFLAList.add(element);
        } else if (element.mainTag == "Full load required") {
          orgFLRList.add(element);
        } else if (element.mainTag == "Part load available") {
          orgPLAList.add(element);
        } else {
          orgPLRList.add(element);
        }
      });
      fullLoadCount = orgFLRList.length + orgFLAList.length;
      partLoadCount = orgPLRList.length + orgPLAList.length;
    }
  }

  getOrgFullLoadListByBranch(int id,String branchName) async {
    orgFullLoadList.clear();
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL+"GetFullLoadByCompanyIdAndBranchName?companyId=${id}&branchName=${branchName}";
    print("Get All Load Truck Data By Branch - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    final response = json.decode(req.body);
    print(response);
    isLoading = false;
    if (req.statusCode == 200) {
      FullLoadModel fullLoadModel = FullLoadModel.fromJson(response);
      orgFullLoadList.addAll(fullLoadModel.data!);
    }
    notifyListeners();
  }

  getOrgFullLoadListByEmployee(int id,int userId) async {
    orgFullLoadList.clear();
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL+"getFullLoadByUserIdForMonitoring?userId=${userId}";
    print("Get All Load Truck Data By UserName - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    final response = json.decode(req.body);
    print(response);
    isLoading = false;
    if (req.statusCode == 200) {
      FullLoadModel fullLoadModel = FullLoadModel.fromJson(response);
      orgFullLoadList.addAll(fullLoadModel.data!);
    }
    notifyListeners();
  }

  getFilterFullLoadList(String title) {
    orgFullLoadList.clear();
    if (title == "All Loads") {
      orgFullLoadList.addAll(orgAllFullLoadList);
    }
    if (title == "Part Loads") {
      orgFullLoadList.addAll(orgPLAList);
      orgFullLoadList.addAll(orgPLRList);
    }
    if (title == "Full Loads") {
      orgFullLoadList.addAll(orgFLAList);
      orgFullLoadList.addAll(orgFLRList);
    }
    if (title == "Full Load Available") {
      orgFullLoadList.addAll(orgFLAList);
    }
    if (title == "Full Load Required") {
      orgFullLoadList.addAll(orgFLRList);
      notifyListeners();
    }
    if (title == "Part Load Available") {
      orgFullLoadList.addAll(orgPLAList);
    }
    if (title == "Part Load Required") {
      orgFullLoadList.addAll(orgPLRList);
    }
    notifyListeners();
  }

  getSearchByNameList(int id,String name, String source, String dest) async {
    isLoading = true;
    notifyListeners();
    orgFullLoadList.clear();
        String myUrl = AppConstants.BASE_URL+"/getFullTRuckLoadOfUsersBasedOnSourceAndDesination?source=${source}&destination=${dest}&companyId=${id}";
    print("Get Data By Source and Destination : "+myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    print(response);
    if(response['success']==false){
      orgAllFullLoadList = [];
      orgFullLoadList=[];
    }else{
    FullLoadModel fullLoadModel = FullLoadModel.fromJson(response);
    orgFullLoadList.clear();
    orgFullLoadList = fullLoadModel.data!;
    orgAllFullLoadList.clear();
    orgAllFullLoadList.addAll(orgFullLoadList);}
    notifyListeners();
  }

  getOrgPoolPurchaseList(int id) async {
    isLoading = true;
    notifyListeners();
    // String myUrl = "http://ec2-13-233-64-33.ap-south-1.compute.amazonaws.com:8080/tkd2/api/getBulkBuySell/ForOrganisation?organizationId=26";
    String myUrl = AppConstants.BASE_URL +
        "getBulkBuySell/ForOrganisation?organizationId=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      orgPoolPurchaseList = List<OrgPoolPurchaseModel>.from(
          response.map((json) => OrgPoolPurchaseModel.fromJson(json)));
      orgAllPoolPurchaseList.clear();
      orgAllPoolPurchaseList.addAll(orgPoolPurchaseList);
      orgVehicleList.clear();
      orgTyreList.clear();
      orgBodyBuildingList.clear();
      orgFinanceList.clear();
      orgInsuranceList.clear();
      orgOtherList.clear();
      orgPoolPurchaseList.forEach((element) {
        if (element.purchaseItem == "Vehicle") {
          orgVehicleList.add(element);
        } else if (element.purchaseItem == "Tyres") {
          orgTyreList.add(element);
        } else if (element.purchaseItem == "Body Building") {
          orgBodyBuildingList.add(element);
        } else if (element.purchaseItem == "Insurance") {
          orgInsuranceList.add(element);
        } else if (element.purchaseItem == "Finance") {
          orgFinanceList.add(element);
        } else {
          orgOtherList.add(element);
        }
      });
      notifyListeners();
    }
  }

  getFilterPoolPurchaseList(String title) {
    orgPoolPurchaseList.clear();
    if (title == "All Requirement") {
      orgPoolPurchaseList.addAll(orgAllPoolPurchaseList);
      notifyListeners();
    }
    if (title == "Vehicles") {
      orgPoolPurchaseList.addAll(orgVehicleList);
      notifyListeners();
    }
    if (title == "Tyres") {
      orgPoolPurchaseList.addAll(orgTyreList);
      notifyListeners();
    }
    if (title == "Body Building") {
      orgPoolPurchaseList.addAll(orgBodyBuildingList);
      notifyListeners();
    }
    if (title == "Finance") {
      orgPoolPurchaseList.addAll(orgFinanceList);
      notifyListeners();
    }
    if (title == "Insurance") {
      orgPoolPurchaseList.addAll(orgInsuranceList);
      notifyListeners();
    }
    if (title == "Other") {
      orgPoolPurchaseList.addAll(orgOtherList);
      notifyListeners();
    }
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

  deleteBid(OrgBidingModel bid) async {
    String myUrl = AppConstants.BID_TO_POST + '?id=${bid.bidingId}';
    print(myUrl);
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    print(response);
    orgBigingList.remove(bid);
    notifyListeners();
  }

  deletePoolPurchase(OrgPoolPurchaseModel obj) async {
    String myUrl = AppConstants.BULK_DATA + '?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    orgPoolPurchaseList.remove(obj);
    notifyListeners();
  }

  String? image;
  String? uploadedDocs;

  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }

  uploadCompanyDocuments(
      {String? imageFilePath,
      Uint8List? imageBytes,
      PlatformFile? objectFile}) async {
    String myUrl = AppConstants.IMG_UPLOAD;

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String, String> headers = {"Content-Type": "multipart/form-data"};

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
