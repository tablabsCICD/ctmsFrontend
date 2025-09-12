import 'dart:convert';
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
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/organization_portal/company/load_list.dart';
import 'package:flutter_hr_management/organization_portal/model/load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_quote_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/search_load_list.dart';
import 'package:flutter_hr_management/organization_portal/model/tkd_user_mobile_response.dart';
import 'package:flutter_hr_management/organization_portal/model/userdata.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';

import 'package:flutter_hr_management/organization_portal/model/organization/org_buy_sell_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_full_load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_static_data_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

import '../../pages/widget/toast.dart';
import '../../route/app_routes.dart';
import '../delete_user.dart';

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

  bool isLoading = false;

  bool isLoad = false;
  Branch? branch;
  List<Branch> branchList = [];
  List<String> branchNameList = ['Shreeji'];

  /// Get all branches for current user's organization
  Future<void> getAllBranch(int orgId) async {
    try {
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      LoginDeatils currentUser =
      await LocalSharePreferences.localSharePreferences.getLoginData();
      String myUrl = ApiConstant.BASE_URL +
          "api/branch/getAll?organisationId=${currentUser.data!.organisationId!}&page=0&size=10&sortDir=asc";
      print("Get All Branch : $myUrl");
      final dio = Dio();
      final response = await dio.get(myUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          }));
      print(response.data);
      if (response.statusCode == 200) {
        // response.data may already be Map or String
        final parsed = response.data is String
            ? jsonDecode(response.data)
            : response.data as Map<String, dynamic>;
        BranchResponse branchResponse = BranchResponse.fromJson(parsed);
        branchNameList.clear();
        branchList.clear();
        if (branchResponse.data?.content != null) {
          branchList.addAll(branchResponse.data!.content as Iterable<Branch>);
        }
        debugPrint("Branch List:: $branchList");
        for (var element in branchList) {
          if (element.branchName != null) branchNameList.add(element.branchName!);
        }
        debugPrint("Branch Name List:: $branchNameList");
      }
    } catch (e) {
      debugPrint("getAllBranch error: $e");
    } finally {
      notifyListeners();
    }
  }

  void filterSearchResults(String query, String type) {
    if (type == "User") {
      userList.clear();
      for (var element in allUserList) {
        final first = element.firstName ?? '';
        final last = element.lastName ?? '';
        final mobile = element.mobileNumber?.toString() ?? '';
        if (first.toLowerCase().contains(query.toLowerCase()) ||
            last.toLowerCase().contains(query.toLowerCase()) ||
            mobile.contains(query)) {
          userList.add(element);
        }
      }
      debugPrint('Final Users : ${userList.length}');
      notifyListeners();
    } else if (type == "Load") {
      orgFullLoadList.clear();
      for (var element in orgAllFullLoadList) {
        final source = element.source ?? '';
        final dest = element.destination ?? '';
        final mobile = element.mobileNumber?.toString() ?? '';
        if (source.toLowerCase().contains(query.toLowerCase()) ||
            dest.toLowerCase().contains(query.toLowerCase()) ||
            mobile.contains(query)) {
          orgFullLoadList.add(element);
        }
      }
      debugPrint('Final Load List : ${orgFullLoadList.length}');
      notifyListeners();
    }
  }

  bool isOrgLoading = false;

  /// Get company details by id
  Future<Organization?> getCompanyDetails(int id) async {
    isOrgLoading = true;
    notifyListeners();
    try {
      String myUrl = AppConstants.COMPANY_BY_ID + '${id}';
      print("GetOrg TKD Details: $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      if (req.statusCode == 200) {
        final parsed = json.decode(req.body);
        print("Org Response : ${req.body}");
        Organization organizationModel = Organization.fromJson(parsed);
        orgnization.add(organizationModel);
        return organizationModel;
      } else {
        debugPrint("getCompanyDetails failed: ${req.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("getCompanyDetails exception: $e");
      return null;
    } finally {
      isOrgLoading = false;
      notifyListeners();
    }
  }

  int? connectUserId;
  List<String> userNameList = [];

  /// Get users by company id
  Future<void> getUsersByCompanyId(int id) async {
    try {
      selectedTab = "All Users";
      String myUrl = AppConstants.USER_BY_COMP_ID + '${id}';
      print("All users by company:: $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      print("All User response: ${req.body}");
      final parsed = json.decode(req.body);
      final list = AuthApi.fromJson(parsed);
      userList.clear();
      userList = list.content ?? [];
      allUserList.clear();
      allUserList.addAll(userList);
      approvedUserList.clear();
      pendingUserList.clear();
      userNameList.clear();
      rejectedUserList.clear();

      // Try to get local login details once
      LoginDeatils? localLogin;
      try {
        localLogin = await LocalSharePreferences.localSharePreferences.getLoginData();
      } catch (_) {
        localLogin = null;
      }

      for (var element in userList) {
        userNameList.add('${element.firstName ?? ''} ${element.lastName ?? ''}');
        if (localLogin?.data?.contact != null &&
            element.mobileNumber == localLogin!.data!.contact) {
          connectUserId = element.id;
        }
        if (element.isUserVerifiedByCompany == 1) {
          approvedUserList.add(element);
        } else if (element.isUserVerifiedByCompany == 0) {
          rejectedUserList.add(element);
        } else {
          pendingUserList.add(element);
        }
      }
      userCount = userList.length;
    } catch (e) {
      debugPrint("getUsersByCompanyId error: $e");
    } finally {
      notifyListeners();
    }
  }

  LoginDeatils? loginDeatils;
  CtmsOrganization? ctmsOrganization;

  /// Get CTMS organization details and save connect ids to preferences
  Future<void> getCtmsOrganization() async {
    try {
      loginDeatils =
      await LocalSharePreferences.localSharePreferences.getLoginData();
      final dio = Dio();
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      final response = await dio.get(
          ApiConstant.GET_CTMS_ORG +
              "?Id=${loginDeatils?.data?.organisationId ?? ''}",
          options: Options(headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          }));
      debugPrint(response.data.toString());
      final parsed = response.data is String ? jsonDecode(response.data) : response.data;
      CtmsOrganizationResponse ctmsOrganizationResponse =
      CtmsOrganizationResponse.fromJson(parsed);
      ctmsOrganization = ctmsOrganizationResponse.data;
      if (ctmsOrganization != null) {
        await LocalSharePreferences().setString(
            SharedPreferencesConstant.connectOrganizationId,
            ctmsOrganization!.connectOrgId?.toString() ?? '');
        await LocalSharePreferences().setString(
            SharedPreferencesConstant.connectUserId,
            ctmsOrganization!.connectUserId?.toString() ?? '');
        debugPrint("Connect Org Id:::" +
            (await LocalSharePreferences().getString(
                SharedPreferencesConstant.connectOrganizationId)));
        debugPrint(ctmsOrganization!.connectUserId?.toString() ?? '');
      }
    } catch (e) {
      debugPrint("getCtmsOrganization error: $e");
    }
  }

  ConnectUser? connectUser;

  /// Get TKD user by mobile number
  Future<http.Response> getTkdUserByMobile(
      BuildContext context, String mobileNumber) async {
    String myUrl = AppConstants.get_TkdUser_By_Mobile + '${mobileNumber}';
    print(myUrl);
    final req = await http.get(Uri.parse(myUrl));
    if (req.statusCode == 200) {
      final parsed = json.decode(req.body);
      if (parsed is Map && parsed["success"] == true) {
        var list = TkdUserByMobileResponse.fromJson(json.decode(req.body));
        connectUser = list.data;
      } else {
        showCustomToast(context, parsed["message"]?.toString() ?? "No user",
            Icons.check, Colors.green);
      }
    } else {
      showCustomToast(context, "Please try again!!", Icons.close, Colors.red);
    }
    notifyListeners();
    return req;
  }

  /// Get organization details using saved connectOrganizationId
  Future<Organization?> getOrgDetails() async {
    try {
      final connectIdStr = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.connectOrganizationId);
      final orgId = int.tryParse(connectIdStr ?? '');
      debugPrint(
          "TKDORGID:::::::::::::::::::::::::::::::::::::::::::::::::::::::: $orgId");
      if (orgId == null) return null;
      final organization = await getCompanyDetails(orgId);
      if (organization != null) {
        debugPrint(organization.companyName ?? '');
      }
      loginDeatils =
      await LocalSharePreferences.localSharePreferences.getLoginData();
      notifyListeners();
      return organization;
    } catch (e) {
      debugPrint("getOrgDetails error: $e");
      notifyListeners();
      return null;
    }
  }

  void getUserList(String title) {
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

  /// Get static organization statistics
  Future<void> getStaticData(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      String myUrl = AppConstants.get_Static_Data + "${id}";
      print("GET Statistics URL : $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      final parsed = json.decode(req.body);
      if (parsed is Map && parsed['data'] != '') {
        final type = OrgStaticDataModel.fromJson(json.decode(req.body));
        debugPrint(parsed.toString());
        userCount = type.data?.totalCompanyRegister ?? 0;
        fullLoadPostCount = (type.data?.totalLoggedUserNameInFullTruck ?? 0) +
            (type.data?.totalLoggedUserNameWithPartLoad ?? 0);
        bidCont = type.data?.totalLoggedUserNameInBiding ?? 0;
        buySellPostCount = type.data?.totalLoggedUserNameInBuySell ?? 0;
      }
    } catch (e) {
      debugPrint("getStaticData error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Get buy/sell posts by organization id
  Future<void> getBuyVehicles(int id) async {
    try {
      String myUrl = AppConstants.get_Buy_Sell_Vehicles + "${id}";
      selectedBuySellTab = "Buy a Vehicle";
      print("Get BuySell Data By OrgId - $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      final parsed = json.decode(req.body);
      debugPrint(parsed.toString());
      if (req.statusCode == 200) {
        orgBuySellList.clear();
        final buySellModel = BuySellModel.fromJson(parsed);
        orgBuySellList.addAll(buySellModel.data ?? []);
        orgBuyList.clear();
        orgSellList.clear();
        finalBuySellList.clear();
        buySellPostCount = orgBuySellList.length;
        for (var element in orgBuySellList) {
          final typeField = element.type ?? element.type ?? '';
          if (typeField.toLowerCase().contains("buy")) {
            orgBuyList.add(element);
          } else {
            orgSellList.add(element);
          }
        }
        // If selectedBuySellTab contains 'Buy' show buy list else show sell
        if (selectedBuySellTab.toLowerCase().contains("buy")) {
          finalBuySellList.addAll(orgBuyList);
        } else {
          finalBuySellList.addAll(orgSellList);
        }
      }
    } catch (e) {
      debugPrint("getBuyVehicles error: $e");
    } finally {
      notifyListeners();
    }
  }

  void getFinalBuySellList(String title) {
    selectedBuySellTab = title;
    finalBuySellList.clear();
    if (selectedBuySellTab == "Buy a Vehicle") {
      finalBuySellList.addAll(orgBuyList);
    } else {
      finalBuySellList.addAll(orgSellList);
    }
    debugPrint("$selectedBuySellTab List ${finalBuySellList.length}");
    notifyListeners();
  }

  /// Get full load list for organization
  Future<void> getOrgFullLoadList(int id) async {
    try {
      isLoading = true;
      String myUrl = AppConstants.get_Org_FullLoadList + "${id}";
      print("Get All Load Truck Data Url - $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      print("Get All Load Truck Data Response- ${req.body}");
      final parsed = json.decode(req.body);
      debugPrint(parsed.toString());
      if (req.statusCode == 200) {
        final fullLoadModel = FullLoadModel.fromJson(parsed);
        orgFullLoadList = fullLoadModel.data ?? [];
        orgAllFullLoadList.clear();
        orgAllFullLoadList.addAll(orgFullLoadList);
        allPostCount = orgAllFullLoadList.length;
        orgFLAList.clear();
        orgFLRList.clear();
        orgPLAList.clear();
        orgPLRList.clear();
        for (var element in orgFullLoadList) {
          final tag = element.mainTag ?? '';
          if (tag.toLowerCase() == "full load available") {
            orgFLAList.add(element);
          } else if (tag.toLowerCase() == "full load required") {
            orgFLRList.add(element);
          } else if (tag.toLowerCase() == "part load available") {
            orgPLAList.add(element);
          } else {
            orgPLRList.add(element);
          }
        }
        fullLoadCount = orgFLRList.length + orgFLAList.length;
        partLoadCount = orgPLRList.length + orgPLAList.length;
      }
    } catch (e) {
      debugPrint("getOrgFullLoadList error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  /// Get full load by branch
  Future<void> getOrgFullLoadListByBranch(int id, String branchName) async {
    try {
      isLoading = true;
      notifyListeners();

      orgFullLoadList.clear();

      final url =
          "${AppConstants.get_Org_FullLoadList_ByBranch}$id&branchName=$branchName";
      print("Get All Load Truck Data By Branch - $url");

      final response = await http.get(Uri.parse(url));
      print("Get All Load Truck By Branch Response - ${response.body}");
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        debugPrint(parsed.toString());

        final fullLoadModel = FullLoadModel.fromJson(parsed);

        if (fullLoadModel.success == true) {
          orgFullLoadList.addAll(fullLoadModel.data ?? []);
        } else {
          debugPrint("getOrgFullLoadListByBranch: ${fullLoadModel.message}");
          orgFullLoadList.clear();
        }
      } else {
        debugPrint("getOrgFullLoadListByBranch error: ${response.statusCode}");
        orgFullLoadList.clear();
      }
    } catch (e) {
      debugPrint("getOrgFullLoadListByBranch error: $e");
      orgFullLoadList.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  /// Get full load by employee (userId)
  Future<void> getOrgFullLoadListByEmployee(int id, int userId) async {
    try {
      isLoading = true;
      notifyListeners();

      orgFullLoadList.clear();

      final url = "${AppConstants.get_Org_FullLoadList_ByEmployee}$userId";
      print("Get All Load Truck Data By UserName - $url");

      final response = await http.get(Uri.parse(url));
      print("Get All Load Truck Data By UserName Response - ${response.body}");
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        debugPrint(parsed.toString());

        final fullLoadModel = FullLoadModel.fromJson(parsed);

        if (fullLoadModel.success == true) {
          orgFullLoadList.addAll(fullLoadModel.data ?? []);
        } else {
          debugPrint("getOrgFullLoadListByEmployee: ${fullLoadModel.message}");
          orgFullLoadList.clear();
        }
      } else {
        debugPrint("getOrgFullLoadListByEmployee error: ${response.statusCode}");
        orgFullLoadList.clear();
      }
    } catch (e) {
      debugPrint("getOrgFullLoadListByEmployee error: $e");
      orgFullLoadList.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void getFilterFullLoadList(String title) {
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
    }
    if (title == "Part Load Available") {
      orgFullLoadList.addAll(orgPLAList);
    }
    if (title == "Part Load Required") {
      orgFullLoadList.addAll(orgPLRList);
    }
    notifyListeners();
  }

  /// Search loads by source/destination
  Future<void> getSearchByNameList(int id, String name, String source, String dest) async {
    try {
      isLoading = true;
      notifyListeners();

      orgFullLoadList.clear();

      final url =
          "${AppConstants.get_Search_ByNameList}$source&destination=$dest&companyId=$id";
      print("Get Data By Source and Destination : $url");

      final response = await http.get(Uri.parse(url));
      print("Get Data By Source and Destination Response - ${response.body}");
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        debugPrint(parsed.toString());

        final fullLoadModel = FullLoadModel.fromJson(parsed);

        if (fullLoadModel.success == true) {
          orgFullLoadList = fullLoadModel.data ?? [];

          orgAllFullLoadList
            ..clear()
            ..addAll(orgFullLoadList);
        } else {
          debugPrint("getSearchByNameList: ${fullLoadModel.message}");
          orgFullLoadList.clear();
          orgAllFullLoadList.clear();
        }
      } else {
        debugPrint("getSearchByNameList error: ${response.statusCode}");
        orgFullLoadList.clear();
        orgAllFullLoadList.clear();
      }
    } catch (e) {
      debugPrint("getSearchByNameList error: $e");
      orgFullLoadList.clear();
      orgAllFullLoadList.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  /// Delete full load
  Future<void> deleteFullLoad(OrgFullLoadModel truckLoad) async {
    try {
      String myUrl = AppConstants.delete_FullLoad + '${truckLoad.id}';
      print(myUrl);
      final req = await http.delete(Uri.parse(myUrl));
      final deleteResponse = json.decode(req.body);
      debugPrint(deleteResponse.toString());
      orgFullLoadList.remove(truckLoad);
    } catch (e) {
      debugPrint("deleteFullLoad error: $e");
    } finally {
      notifyListeners();
    }
  }

  /// Delete buy/sell post
  Future<void> deleteBuySell(OrgBuySellModel truckLoad) async {
    try {
      String myUrl = AppConstants.POST_BUY_SELL + '?id=${truckLoad.id}';
      final req = await http.delete(Uri.parse(myUrl));
      final deleteResponse = json.decode(req.body);
      debugPrint(deleteResponse.toString());
      orgBuySellList.removeWhere((e) => e.id == truckLoad.id);
    } catch (e) {
      debugPrint("deleteBuySell error: $e");
    } finally {
      notifyListeners();
    }
  }




  String? image;
  String? uploadedDocs;
  List<OrgPoolPurchaseModel> orgPoolPurchaseList = [];

  Future<void> setImage(img) async {
    this.image = img;
    notifyListeners();
  }

  /// Upload company documents (multipart)
  Future<String?> uploadCompanyDocuments({
    String? imageFilePath,
    Uint8List? imageBytes,
    PlatformFile? objectFile,
  }) async {
    try {
      String myUrl = AppConstants.IMG_UPLOAD;
      var postUri = Uri.parse(myUrl);
      var request = http.MultipartRequest("POST", postUri);
      Map<String, String> headers = {"Content-Type": "multipart/form-data"};

      if (objectFile == null) {
        debugPrint("uploadCompanyDocuments: objectFile is null");
        return null;
      }

      final stream = objectFile.readStream;
      if (stream == null) {
        debugPrint("uploadCompanyDocuments: readStream is null");
        return null;
      }

      request.files.add(http.MultipartFile("profilePicture", stream, objectFile.size,
          filename: objectFile.name));

      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      debugPrint(streamedResponse.statusCode.toString());
      final bodyString = await streamedResponse.stream.transform(utf8.decoder).join();
      debugPrint(bodyString);
      uploadedDocs = bodyString;
      return uploadedDocs;
    } catch (e) {
      debugPrint("uploadCompanyDocuments error: $e");
      return null;
    }
  }

  sendOtp(String mobileNumber,BuildContext context)async{
      ApiHelper apiHelper=ApiHelper();
      var response= await apiHelper.apiGet(AppConstants.USER_FIND_BY_MOBILE(mobileNumber));

      if(response.status==200){
        DeleteUser deleteUser=DeleteUser.fromJson(response.response);
        callSwitch(deleteUser,context,mobileNumber);
      }else{
        ToastMessage.show(context, " Please try again ");
      }
    }

  void callSwitch(DeleteUser user,BuildContext context,String mobileNumber) {
    switch (user.errorCode){
      case '200':
        callOtp(context,mobileNumber);
        break;
      case '201':
        ToastMessage.show(context, "User is deleted please register again");
        break;
      case '500':
        ToastMessage.show(context, "Mobile number is not register please register");
        break;
    }
  }

  void callOtp(BuildContext context, String mobileNumber) async {
    var req = await ApiHelper().apiPost(AppConstants.SEND_OTP(mobileNumber));

    if (req.status == 200) {
      ToastMessage.show(context, "OTP sent successfully");

    } else {
      ToastMessage.show(context, "Please try again");
    }

    notifyListeners();
  }

  verifyOtp(BuildContext context,String mobileNumber,String otp) async{
    String myUrl = AppConstants.OTP_VERIFICATION(mobileNumber,otp);
    var req = await ApiHelper().apiPost(myUrl);
    if(req.status== 200){
      User user=User.fromJson(req.response);
      if(user.content!.isNotEmpty){
        ToastMessage.show(context,"${user.content!.first.firstName} ${user.content!.first.lastName} added successfully to our organization");
      }else{
        ToastMessage.show(context,"Please try again");
      }
      notifyListeners();

    }else{
      ToastMessage.show(context,"Please try again");
    }

  }
}



