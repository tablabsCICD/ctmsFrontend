import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/advertise_portal/model/advertise_model.dart';
import 'package:flutter_hr_management/advertise_portal/model/save_advertise.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:http/http.dart' as http;

class AdvProvider extends ChangeNotifier {

  List<AdvertiseData> advertiseList = [];
  List<AdvertiseData> advertiseListByUserId = [];
  List<AdvertiseData> advertiseListByOrgId = [];
  var response;
  bool? isLoading;

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
    await LocalSharePreferences().setString(SharedPreferencesConstant.connectOrganizationId, ctmsOrganization!.connectOrgId!.toString());
    await LocalSharePreferences().setString(SharedPreferencesConstant.connectUserId, ctmsOrganization!.connectUserId!.toString());
    print(ctmsOrganization!.connectOrgId!.toString());
    print(ctmsOrganization!.connectUserId!.toString());
  }

  getAdvertiseListByOrg(int connectOrgId1,{int currentPage = 0}) async {
    /*String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String connectOrgId = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.connectOrganizationId);*/
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      advertiseListByOrgId.clear();
    }
    String myUrl = AppConstants.BASE_URL +"my-ads/getAll";
  //  String myUrl = AppConstants.BASE_URL + 'my-ads/organisation/${int.parse(ctmsOrganization!.connectOrgId.toString())}';
    print("My Advertise List :"+myUrl);
    Dio dio = Dio();
    final response = await dio.get(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
        //  'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    isLoading = false;
    var type = Advertise_Model.fromJson(jsonDecode(response.data));
    advertiseListByOrgId.clear();
    advertiseListByOrgId.addAll(type.data as Iterable<AdvertiseData>);
    advertiseListByOrgId.forEach((element) {
      if(element.active==true){
        advertiseList.add(element);
      }
      print("advertiseList length:   " + advertiseList.length.toString());
    });
    notifyListeners();
  }

  getAdvertiseListByUser(int connectUserId1,{int currentPage = 0}) async {
   /* String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
   String connectUserId = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.connectUserId);*/
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      advertiseListByUserId.clear();
    }
    String myUrl = AppConstants.BASE_URL +"my-ads/getAll";
   // String myUrl = AppConstants.BASE_URL + 'my-ads/${int.parse(ctmsOrganization!.connectUserId.toString())}';
    print("Advertise List :"+myUrl);
    Dio dio = Dio();
    final response = await dio.get(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
         // 'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    isLoading = false;
    var type = Advertise_Model.fromJson(jsonDecode(response.data));
    advertiseListByUserId.clear();
    advertiseListByUserId.addAll(type.data as Iterable<AdvertiseData>);
    advertiseListByUserId.forEach((element) {
      if(element.active==true){
        advertiseList.add(element);
      }
      print("advertiseList length:   " + advertiseList.length.toString());
    });
    notifyListeners();
  }

  createAdvertise(
      {String? transactionId,
        String? startDate,
        String? numberOfDays,
        String? endDate,
        String? companyName,
        String? bannerName,
        String? bannerHyperlink,
        String? adImage,
       }) async {
    isLoading = true;
    notifyListeners();
    LoginDeatils loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();

   /* String connectUserId = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.connectUserId);
    String connectOrgId = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.connectOrganizationId);*/


    String myUrl = AppConstants.BASE_URL+"my-ads/save";
    print("Save advertise Api : "+myUrl);
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": true,
      "adImage": adImage,
      "bannerHyperlink": bannerHyperlink,
      "bannerName": bannerName,
      "companyName": companyName,
      "endDate": endDate,
      "numberOfDays": numberOfDays,
      "organisationId": 0,//ctmsOrganization!.connectOrgId,
      "startDate": startDate,
      "transactionId": transactionId,
      "userId": 0,//ctmsOrganization!.connectUserId
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
         // 'Authorization': 'Bearer ${token}',
        }, body: body);
    isLoading = false;
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    if(createResponse.statusCode == 200){
    var jsonData = jsonDecode(createResponse.body);
    SaveAdvertise advertiseData = SaveAdvertise.fromJson(jsonData);
    advertiseList.add(advertiseData.data!);
    }
    notifyListeners();
    return createResponse.statusCode;
  }

  deleteAdv(AdvertiseData advertiseData) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.BASE_URL + 'api/my-ads/deleteAdvertisement/${advertiseData.id}';
    print(myUrl);
    Dio dio = Dio();
    final response = await dio.delete(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    advertiseListByUserId.remove(advertiseData);

    notifyListeners();
    return response.statusCode;
  }

}
