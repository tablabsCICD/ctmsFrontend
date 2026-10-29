import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:flutter_hr_management/constant/constant.dart';
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
import 'package:universal_html/js_util.dart';

import '../../../pages/widget/toast.dart';
import '../../../utils/date.dart';
import '../../delete_user.dart';

class OrgUserProvider extends ChangeNotifier {

  List<ConnectUser> userList = [];
  List<ConnectUser> allUserList = [];
  List<ConnectUser> rejectedUserList = [];
  List<ConnectUser> approvedUserList = [];
  List<ConnectUser> pendingUserList = [];

  var response;
  bool isLoading = false;
  bool isLoad = false;
  Branch? branch;
  List<Branch> branchList = [];
  List<String> branchNameList = ['Shreeji'];
  int? connectUserId;
  List<String> userNameList = [];
  ConnectUser? connectUser;
  String selectedTab = "All Users";
  LoginDeatils? loginDeatils;

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

  }

   /// Get users by company id
  Future<void> getUsersByCompanyId(int id) async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
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
    } catch (e) {
      debugPrint("getUsersByCompanyId error: $e");
    } finally {
      notifyListeners();
    }
  }

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

  Future<bool> sendOtp(String mobileNumber, BuildContext context) async {
    ApiHelper apiHelper = ApiHelper();
    var response = await apiHelper.apiGet(AppConstants.USER_FIND_BY_MOBILE(mobileNumber));

    if (response.status == 200) {
      DeleteUser deleteUser = DeleteUser.fromJson(response.response);

      // Call your internal function if needed
      callSwitch(deleteUser, context, mobileNumber);

      // Return true indicating OTP can be sent
      return true;
    } else {
      ToastMessage.show(context, "Please try again");
      return false;
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

  verifyOtp(BuildContext context,String mobileNumber,String otp, ConnectUser element, Organization organization) async{
    String myUrl = AppConstants.OTP_VERIFICATION(mobileNumber,otp);
    var req = await ApiHelper().apiPost(myUrl);
    if(req.status== 200){
      User user=User.fromJson(req.response);
      if(user.content!.isNotEmpty){
        ToastMessage.show(context,"${user.content!.first.firstName} ${user.content!.first.lastName} verify otp successfully");
        addToCTMS(context, element, organization);
      }else{
        ToastMessage.show(context,"Please try again");
      }
      notifyListeners();

    }else{
      ToastMessage.show(context,"Please try again");
    }
  }

  bool _isFilterEnabled = false; // example state variable

  bool get isFilterEnabled => _isFilterEnabled;

  void toggleFilter() {
    _isFilterEnabled = !_isFilterEnabled;
    notifyListeners();
  }

  Future<bool> updateUserStatus(BuildContext context,int userId, int status) async {
    ApiHelper apiHelper = ApiHelper();
    print(AppConstants.USER_STATUS(userId,status));
    var response = await apiHelper.apiPutWithoutBody(AppConstants.USER_STATUS(userId,status));
    print(response.response);
    if (response.status == 200) {
     // final parsed = json.decode(response.response);
      if (response.response["success"] == true) {
       ToastMessage.show(context, response.response['message']);
     }
      return true;
    } else {
      ToastMessage.show(context, "Please try again");
      return false;
    }
  }


  Future<void> addToCTMS(BuildContext context,ConnectUser selectedEmp, Organization organization) async {
    try {
      final token = await LocalSharePreferences().getString(SharedPreferencesConstant.AuthToken);
      LoginDeatils currentUser =
      await LocalSharePreferences.localSharePreferences.getLoginData();
      final requestParameter = {
        "aadharNo": selectedEmp.aadharCard,
        "active": selectedEmp.isSelected,
        "address": selectedEmp.companyAddress,
        "birthdate": '',
        "boardingDeatails": {
          "aadharCard": selectedEmp.aadharCard,
          "active": "true",
          "boardingId": 0,
          "degreeCertificate": "string",
          "experienceCertificate": "string",
          "otherDocuments": ["string"],
          "panCard": "string",
          "tenthDCertificate": "string",
          "twelthCertificate": "string"
        },
        "branchId": loginDeatils!.data!.branch!.id,
        "connectOrgId": organization.id,
        "contact": selectedEmp.mobileNumber,
        "createdDate": '',
        "departmentId": loginDeatils!.data!.departmentId,
        "designation": selectedEmp.transporterOrAgent,
        "deviceId": selectedEmp.deviceId,
        "emailId": selectedEmp.emailId,
        "employeeLocation": "ONSITE",
        "esiNO": '',
        "firstName": selectedEmp.firstName,
        "image": selectedEmp.profilePicture,
        "isActive": 0,
        "is_admin": false,
        "lastName": selectedEmp.lastName,
        "mobileNumber": selectedEmp.mobileNumber,
        "organisationId": loginDeatils!.data!.organisationId,
        "os": selectedEmp.os,
        "otp": selectedEmp.otp ?? "",
        "panNo": selectedEmp.panCardForVerification,
        "password": selectedEmp.password ?? "",
        "roleId": 0,
        "securityAnswer": loginDeatils!.data!.securityAnswer,
        "securityQuestion": loginDeatils!.data!.securityQuestion,
        "status": loginDeatils!.data!.status
      };

      EasyLoading.show(status: "Adding to CTMS...");
      final response = await http.post(
        Uri.parse(ApiConstant.SAVE_EMP),
        body: jsonEncode(requestParameter),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      EasyLoading.dismiss();

      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (resData['errorCode'].toString() == "500") {
          showCustomToast(context, resData['errorMessage'].toString(), Icons.clear, Colors.red);
          return;
        } else {
          // success -> call TKD backend next
          await addToTKDConnect(context,selectedEmp, organization);
        }
      } else {
        showCustomToast(context, "Something went wrong while saving to CTMS", Icons.clear, Colors.red);
      }
    } catch (e) {
      EasyLoading.dismiss();
      showCustomToast(context, "Unexpected error: $e", Icons.clear, Colors.red);
    }
  }

// ---------- 7) Add to TKD Connect improved implementation ----------
  Future<void> addToTKDConnect(BuildContext context,ConnectUser selectedEmp, Organization organization) async {
    try {
      final requestParameter = {
        "id": selectedEmp.id,
        "aadharCard": selectedEmp.aadharCard,
        "aadharCardForVerification": selectedEmp.aadharCard,
        "alternativeNumber": selectedEmp.mobileNumber,
        "branchName": selectedEmp.branchName,
        "city": selectedEmp.city,
        "companyAddress": organization.companyAddress,
        "companyId": organization.id,
        "companyLogo": organization.companyLogo,
        "companyName": organization.companyName,
        "country": "India",
        "deviceId": "NA",
        "emailId": selectedEmp.emailId,
        "firstName": selectedEmp.firstName,
        "idOfMainBranch": 0,
        "isPaid": 0,
        "isUserVerifiedByCompany": 1,
        "landlineNumber": selectedEmp.mobileNumber,
        "lastName": selectedEmp.lastName,
        "loggedTime": GetDateFormat.getCurrentDate(),
        "loggedUserName": "NA",
        "mainBranch": 0,
        "mobileNumber": selectedEmp.mobileNumber,
        "numberOfTimesRating": 0,
        "os": "string",
        "otp": "string",
        "paidStartDate": "string",
        "panCardForVerification": selectedEmp.panCardForVerification,
        "password": selectedEmp.password,
        "preferredRouresEntered": 0,
        "profilePicture": selectedEmp.profilePicture,
        "ratings": 0,
        "state": "Maharastra",
        "transporterOrAgent": 0,
        "userName": "NA",
        "validTill": "string",
        "verified": 0,
        "website": organization.website,
      };

      EasyLoading.show(status: "Adding to TKD Connect...");
      final response = await http.put(
        Uri.parse(AppConstants.REGISTRATION),
        body: jsonEncode(requestParameter),
        headers: {"Content-Type": "application/json"},
      );
      EasyLoading.dismiss();

      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (resData['errorCode'].toString() == "500") {
          showCustomToast(context, resData['errorMessage'].toString(), Icons.clear, Colors.red);
        } else {
          // refresh provider user list
          await getUsersByCompanyId(organization.id!);
          showCustomToast(context, "Employee added successfully", Icons.check, Colors.green);
          Navigator.of(context).pop();
        }
      } else {
        showCustomToast(context, "Something went wrong while adding to TKD", Icons.clear, Colors.red);
      }
    } catch (e) {
      EasyLoading.dismiss();
      showCustomToast(context, "Unexpected error: $e", Icons.clear, Colors.red);
    }
  }

}



