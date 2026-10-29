import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/branch_model.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/branch_response_model.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/organization_portal/model/tkd_user_mobile_response.dart';
import 'package:flutter_hr_management/organization_portal/model/userdata.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_buy_sell_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_full_load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_static_data_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/widget/toast.dart';
import '../delete_user.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

class OrgProvider extends ChangeNotifier {
  List<Organization> orgVerifiedList = [];
  List<Organization> orgList = [];
  List<Organization> orgnization = [];

  List<OrgFullLoadModel> orgFullLoadList = [];
  List<OrgFullLoadModel> orgAllFullLoadList = [];
  List<OrgFullLoadModel> orgFLAList = [];
  List<OrgFullLoadModel> orgFLRList = [];
  List<OrgFullLoadModel> orgPLAList = [];
  List<OrgFullLoadModel> orgPLRList = [];


  List<OrgPoolPurchaseModel> orgVehicleList = [];
  List<OrgPoolPurchaseModel> orgTyreList = [];
  List<OrgPoolPurchaseModel> orgBodyBuildingList = [];
  List<OrgPoolPurchaseModel> orgFinanceList = [];
  List<OrgPoolPurchaseModel> orgInsuranceList = [];
  List<OrgPoolPurchaseModel> orgOtherList = [];

  Organization? _org;
  Organization? get org => _org;


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

  Future<void> getCtmsOrganization() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    print("token::::"+token);
    LoginDeatils currentUser =    await LocalSharePreferences().getLoginData();
    print(currentUser.data!.firstName);
    print("${ApiConstant.GET_CTMS_ORG}?Id=${currentUser.data!.organisationId}");
    final response = await Dio().get(
      "${ApiConstant.GET_CTMS_ORG}?Id=${currentUser.data!.organisationId}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
    );

    debugPrint(response.data.toString());
    if(response.statusCode==200 && response.data != null ) {

      final ctmsOrganizationResponse = CtmsOrganizationResponse.fromJson(
        jsonDecode(response.data),
      );

      ctmsOrganization = ctmsOrganizationResponse.data;

      if (ctmsOrganization != null) {
        await LocalSharePreferences().setString(
          SharedPreferencesConstant.ctmsOrganizationId,
          ctmsOrganization!.id?.toString() ?? "",
        );
        await LocalSharePreferences().setString(
          SharedPreferencesConstant.connectUserId,
          ctmsOrganization!.connectUserId?.toString() ?? "",
        );
        await LocalSharePreferences().setString(
          SharedPreferencesConstant.connectOrganizationId,
          ctmsOrganization!.connectOrgId?.toString() ?? "",
        );
        await LocalSharePreferences().setString(
          SharedPreferencesConstant.ctmsOrganization,
          ctmsOrganization!.toString() ?? "",
        );
        debugPrint("Tkd OrgId::: ${ctmsOrganization!.connectOrgId}");
        debugPrint(ctmsOrganization!.connectUserId.toString());
        getConnectOrgDetails(ctmsOrganization!.connectOrgId!);
      }
    }
  }

  bool isOrgLoading = false;

  /// Get company details by id
  Future<Organization?> getConnectOrgDetails(int id) async {
    isOrgLoading = true;
    notifyListeners();
    try {
      String myUrl = AppConstants.COMPANY_BY_ID + '${id}';
      print("GetOrg TKD Details: $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      if (req.statusCode == 200) {
        final parsed = json.decode(req.body);
        print("Org Response : ${req.body}");
        Organization organization = Organization.fromJson(parsed);
        orgnization.add(organization);
        _org = organization;
        await LocalSharePreferences().setString(
          SharedPreferencesConstant.connectOrganization,
          organization.toString() ?? "",
        );

        await LocalSharePreferences().setString(
          SharedPreferencesConstant.connectOrganization,
          jsonEncode(organization.toJson()),
        );

        debugPrint("✅ Organization data saved locally");
        return organization;
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
          if (element.branchName != null)
            branchNameList.add(element.branchName!);
        }
        debugPrint("Branch Name List:: $branchNameList");
      }
    } catch (e) {
      debugPrint("getAllBranch error: $e");
    } finally {
      notifyListeners();
    }
  }


  int? connectUserId;
  List<String> userNameList = [];

  LoginDeatils? loginDeatils;
  CtmsOrganization? ctmsOrganization;

 /* /// Get CTMS organization details and save connect ids to preferences
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
      final parsed =
          response.data is String ? jsonDecode(response.data) : response.data;
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
            (await LocalSharePreferences()
                .getString(SharedPreferencesConstant.connectOrganizationId)));
        debugPrint(ctmsOrganization!.connectUserId?.toString() ?? '');
      }
    } catch (e) {
      debugPrint("getCtmsOrganization error: $e");
    }
  }*/

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

 /* /// Get organization details using saved connectOrganizationId
  Future<Organization?> getOrgDetails() async {
    try {
      final connectIdStr = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.connectOrganizationId);
      final orgId = int.tryParse(connectIdStr);
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
*/

  String selectedBuySellTab = "Buy Vehicle";

  /// Get static organization statistics
  Future<void> getStaticData(int id) async {
    isLoading = true;
    userCount =0 ;
    fullLoadPostCount =0 ;
    bidCont =0 ;
    buySellPostCount =0 ;
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

  List<ConnectUser> userList = [];

  Future<void> getUsersByCompanyId(int id) async {
    loginDeatils =
        await LocalSharePreferences.localSharePreferences.getLoginData();
    try {
      String myUrl = AppConstants.USER_BY_COMP_ID + '${id}';
      print("All users by company:: $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      print("All User response: ${req.body}");
      final parsed = json.decode(req.body);
      final list = AuthApi.fromJson(parsed);
      userList.clear();
      userList = list.content ?? [];

      userNameList.clear();

      // Try to get local login details once
      LoginDeatils? localLogin;
      try {
        localLogin =
            await LocalSharePreferences.localSharePreferences.getLoginData();
      } catch (_) {
        localLogin = null;
      }

      for (var element in userList) {
        if (element.isUserVerifiedByCompany == 1) {
          userNameList
              .add('${element.firstName ?? ''} ${element.lastName ?? ''}');
          if (localLogin?.data?.contact != null &&
              element.mobileNumber == localLogin!.data!.contact) {
            connectUserId = element.id;
          }
        }
      }
    } catch (e) {
      debugPrint("getUsersByCompanyId error: $e");
    } finally {
      notifyListeners();
    }
  }

  void filterSearchResults(String query, String type) {
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

  bool isPaginationLoading = false;


    Future<void> getOrgFullLoadList(int id, {required int currentPage}) async {
      if (currentPage == 0) {
        orgAllFullLoadList.clear();
        orgFullLoadList.clear();
        isLoading = true;
      } else {
        isPaginationLoading = true;
      }
      notifyListeners();

      try {
        final myUrl =
            "${AppConstants.get_Org_FullLoadList}?companyId=$id&page=$currentPage&size=10&latestPost=yes";

        logger.i("🌍 Fetching Load Data: $myUrl");
        print("🌍 Fetching Load Data: $myUrl");
        final req = await http.get(Uri.parse(myUrl));
        logger.i("Status: ${req.statusCode}");
        logger.i("Body: ${req.body}");
        print("Body: ${req.body}");
        if (req.statusCode == 200 && req.body.isNotEmpty) {
          try {
            final parsed = json.decode(req.body);

            final fullLoadModel = FullLoadModel.fromJson(parsed);
            print("🌍 JSON parsed successfully"+fullLoadModel.content!.length.toString());
            print("🌍 JSON parsed successfully");
            if (currentPage == 0) {
              orgFullLoadList.clear();
                orgFullLoadList.addAll(fullLoadModel.content ?? []);
            } else {
              orgFullLoadList.addAll(fullLoadModel.content ?? []);
            }

            orgAllFullLoadList.clear();
            orgAllFullLoadList.addAll(orgFullLoadList);

            allPostCount = orgAllFullLoadList.length;
            print('allPostCount : $allPostCount');
            // 🔹 Rebuild category lists
            orgFLAList
              ..clear()
              ..addAll(orgAllFullLoadList.where(
                      (e) => (e.mainTag ?? '').toLowerCase() == "full load available"));

            orgFLRList
              ..clear()
              ..addAll(orgAllFullLoadList.where(
                      (e) => (e.mainTag ?? '').toLowerCase() == "full load required"));

            orgPLAList
              ..clear()
              ..addAll(orgAllFullLoadList.where(
                      (e) => (e.mainTag ?? '').toLowerCase() == "part load available"));

            orgPLRList
              ..clear()
              ..addAll(orgAllFullLoadList.where(
                      (e) => (e.mainTag ?? '').toLowerCase() == "part load required"));

            print("✅ Total items in to full load: $allPostCount");
          } catch (e, st) {
            print("❌ JSON parse error to full load: $e\n$st");
          }
        } else {
          print("❌ API Failed to full load: ${req.statusCode} ${req.reasonPhrase}");
        }
      } catch (e, st) {
        print("❌ Network error to full load: $e\n$st");
      } finally {
        print('finally block to full load');
        isLoading = false;
        isPaginationLoading = false;
        notifyListeners();
      }
      notifyListeners();
      notifyListeners();
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
        //debugPrint(parsed.toString());

        final fullLoadModel = FullLoadModel.fromJson(parsed);

        if (fullLoadModel.content != null) {
          debugPrint(fullLoadModel.content!.length.toString());
          orgFullLoadList.addAll(fullLoadModel.content ?? []);
        } else {
          debugPrint("getOrgFullLoadListByBranch: ${fullLoadModel.numberOfElements}");
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
      //  debugPrint(parsed.toString());

        final fullLoadModel = FullLoadModel.fromJson(parsed);
        debugPrint(fullLoadModel.content!.length.toString());
        if (fullLoadModel.content != null) {
          orgFullLoadList.addAll(fullLoadModel.content ?? []);
        } else {
          debugPrint("getOrgFullLoadListByEmployee: ${fullLoadModel.numberOfElements}");
          orgFullLoadList.clear();
        }
      } else {
        debugPrint(
            "getOrgFullLoadListByEmployee error: ${response.statusCode}");
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
  Future<void> getSearchByNameList(
      int id, String name, String source, String dest) async {
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

        if (fullLoadModel.content != null) {
          orgFullLoadList = fullLoadModel.content ?? [];

         /* orgAllFullLoadList
            ..clear()
            ..addAll(orgFullLoadList);*/
        } else {
          debugPrint("getSearchByNameList: ${fullLoadModel.numberOfElements}");
          orgFullLoadList.clear();
         // orgAllFullLoadList.clear();
        }
      } else {
        debugPrint("getSearchByNameList error: ${response.statusCode}");
        orgFullLoadList.clear();
      //  orgAllFullLoadList.clear();
      }
    } catch (e) {
      debugPrint("getSearchByNameList error: $e");
      orgFullLoadList.clear();
     // orgAllFullLoadList.clear();
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

      request.files.add(http.MultipartFile(
          "profilePicture", stream, objectFile.size,
          filename: objectFile.name));

      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      debugPrint(streamedResponse.statusCode.toString());
      final bodyString =
          await streamedResponse.stream.transform(utf8.decoder).join();
      debugPrint(bodyString);
      uploadedDocs = bodyString;
      return uploadedDocs;
    } catch (e) {
      debugPrint("uploadCompanyDocuments error: $e");
      return null;
    }
  }


 void setOrg(Organization organization) {
    _org = organization;
    notifyListeners();
  }

  /// ✅ Load organization data from SharedPreferences
  Future<void> loadOrgFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString(SharedPreferencesConstant.connectOrganization);
      if (data != null && data != "null" && data.isNotEmpty) {
        _org = Organization.fromJson(jsonDecode(data));
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ Error loading org from local: $e");
    }
  }

  /// ✅ Clear org data when user logs out
  Future<void> clearOrg() async {
    _org = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConstant.connectOrganization);
    notifyListeners();
  }
}
