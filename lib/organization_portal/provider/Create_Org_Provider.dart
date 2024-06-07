import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/model/userdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';

class CreateOrgProvider extends ChangeNotifier{
  // CreateJobProvider(super.appState);

  TextEditingController ctmsOrgNameController=TextEditingController();
  TextEditingController ctmsOrgEmailIdController=TextEditingController();
  TextEditingController ctmsMobileController=TextEditingController();
  TextEditingController ctmsDescriptionController=TextEditingController();
  TextEditingController ctmsOrgAddressController=TextEditingController();
  TextEditingController ctmsPanController=TextEditingController();
  TextEditingController ctmsTanController=TextEditingController();
  TextEditingController ctmsGst1Controller=TextEditingController();
  TextEditingController ctmsGst2Controller=TextEditingController();
  TextEditingController ctmsLogoController=TextEditingController();
  TextEditingController ctmsTypeOfRegController=TextEditingController();
  TextEditingController ctmsWebsiteController=TextEditingController();

  bool buttonActive=false;

  bool expUpdate=false;

  buttonEnble(){
    if(ctmsOrgNameController.text.isNotEmpty && ctmsMobileController.text.isNotEmpty && ctmsOrgEmailIdController.text.isNotEmpty && ctmsPanController.text.isNotEmpty && ctmsTanController.text.isNotEmpty){
        buttonActive=true;
    }else{
      buttonActive=false;
    }
    notifyListeners();
  }

  submitCtmsOrgDetails(BuildContext context)async{
    Map<String, dynamic> data = {
      "active": true,
      "city": ctmsOrgAddressController.text,
      "connectOrgId": connectId,
      "connectUserId": 0,
      "description": ctmsDescriptionController.text,
      "emailId": ctmsOrgEmailIdController.text,
      "gstNumber": ctmsGst1Controller.text,
      "gstNumber2": ctmsGst2Controller.text,
      "holidayTemplate": null,
      "id": 0,
      "instruction": [
        "string"
      ],
      "invoiceLogo": ctmsLogoController.text,
      "isVerified": 0,
      "landLineNumber": "string",
      "logo": ctmsLogoController.text,
      "officialEmailId": ctmsOrgEmailIdController.text,
      "orgAddress": ctmsOrgAddressController.text,
      "orgMobileNumber": ctmsMobileController.text,
      "orgName": ctmsOrgNameController.text,
      "panCardNumber": ctmsPanController.text,
      "rulesForTaxinvoice": [
        "string"
      ],
      "state": ctmsOrgAddressController.text,
      "tanCardNumber": ctmsTanController.text,
      "typeOfRegistration": ctmsTypeOfRegController.text,
      "unloadingLogo": ctmsLogoController.text,
      "website": ctmsWebsiteController.text
    };

    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    var para = jsonEncode(data);
    String myUrl = ApiConstant.BASE_URL + 'api/organisation/save';
    print(myUrl);
    final dio = Dio();
    var response = await dio.post(myUrl,
        data: para,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    EasyLoading.dismiss();
    return response;
  }


  int? connectId;
  createOrg(BuildContext context) async {
    String myUrl = AppConstants.BASE_URL + "CompanyDetailsForMonitoring";
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "city": ctmsOrgAddressController.text,
      "companyAddress": ctmsOrgAddressController.text,
      "companyMobileNumber": ctmsMobileController.text,
      "companyName": ctmsOrgNameController.text,
      "gstNumber": ctmsGst1Controller.text,
      "gstNumber2": ctmsGst2Controller.text,
      "id": 0,
      "isVerified": 0,
      "landlineNumber": ctmsMobileController.text,
      "numberOfRatings": 5,
      "officialEmailId": ctmsOrgEmailIdController.text,
      "panCardNumber": ctmsPanController.text,
      "pointOfContact": ctmsOrgNameController.text,
      "rating": 5,
      "state": ctmsOrgAddressController.text,
      "tanCardNumber": ctmsTanController.text,
      "typeOfRegistration": ctmsTypeOfRegController.text,
      "website": ctmsWebsiteController.text
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    if(createResponse.statusCode  == 200){
      var jsonData = jsonDecode(createResponse.body);
      Organization dataObj = Organization.fromJson(jsonData);
      connectId = dataObj.id;
      print(connectId);
    }
    notifyListeners();
    return createResponse;
  }


  resetData(){
    ctmsOrgNameController.clear();
    ctmsWebsiteController.clear();
    ctmsTanController.clear();
    ctmsOrgAddressController.clear();
    ctmsPanController.clear();
    ctmsTypeOfRegController.clear();
    ctmsOrgEmailIdController.clear();
    ctmsMobileController.clear();
    ctmsGst2Controller.clear();
    ctmsLogoController.clear();
    ctmsDescriptionController.clear();
    ctmsGst1Controller.clear();
    notifyListeners();
  }







}