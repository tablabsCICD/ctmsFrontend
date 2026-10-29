import 'dart:convert';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/ctms_org_list.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/model/tkd_user_mobile_response.dart';
import 'package:flutter_hr_management/organization_portal/model/userdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';

class CreateOrgProvider extends ChangeNotifier{

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
  TextEditingController ctmsUnloadingLogoController=TextEditingController();
  TextEditingController ctmsInvoiceLogoController=TextEditingController();
  TextEditingController ctmsTypeOfRegController=TextEditingController();
  TextEditingController ctmsWebsiteController=TextEditingController();

  bool buttonActive=false;
  bool expUpdate=false;
  ConnectUser? connectUser;
  int? connectOrganizationId;
  int? connectUserId;
  Organization? newConnectOrg;
  CtmsOrganization? ctmsOrganization;

  List<CtmsOrganization> ctmsOrgList = [];
  bool isLoading = false;

  //get ctms organization list
  getOrganizationList({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      ctmsOrgList.clear();
    }
    /*  String myUrl = AppConstants.COMPANY + '?page=0&size=100';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));*/
    Dio dio = Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.BASE_URL + 'api/Organisation/getAll?page=$currentPage&size=10&sortBy=id&sortDir=asc';
    print(myUrl);
    /* var response = await dio.get(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');*/
    var createResponse = await http.get(Uri.parse(myUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        });
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    isLoading = false;
    if(createResponse.statusCode==200){

      var response = await json.decode(createResponse.body);
      if(response["data"]==""){

      }else{
        var type = CtmsOrgListResponse.fromJson(response);
        ctmsOrgList.addAll(type.data!.content!);}
    }
    notifyListeners();
  }

  submitCtmsOrgDetails(BuildContext context)async{
    Map<String, dynamic> data = {
      "active": true,
      "city": ctmsOrgAddressController.text,
      "connectOrgId": connectOrganizationId,
      "connectUserId": connectUser==null?0:connectUser!.id,
      "description": ctmsDescriptionController.text,
      "emailId": ctmsOrgEmailIdController.text,
      "gstNumber": ctmsGst1Controller.text,
      "gstNumber2": ctmsGst2Controller.text,
      "holidayTemplate": null,
      "id": 0,
      "instruction": [
        "string"
      ],
      "invoiceLogo": ctmsInvoiceLogoController.text,
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
      "unloadingLogo": ctmsUnloadingLogoController.text,
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
    if(response.statusCode==200){
      CtmsOrganizationResponse ctmsOrganizationResponse = CtmsOrganizationResponse.fromJson(jsonDecode(response.data));
      ctmsOrganization = ctmsOrganizationResponse.data;
      ctmsOrgList.add(ctmsOrganization!);
      getOrganizationList(currentPage: 0);
    }
    notifyListeners();
    EasyLoading.dismiss();
    return response;
  }

  createCtmsUser(BuildContext context,var res1)async{
    Map<String, dynamic> data = {
      "aadharNo": "string",
      "active": "string",
      "address": ctmsOrgAddressController.text,
      "birthdate": "string",
      "boardingDeatails": {
        "aadharCard": "string",
        "active": "string",
        "boardingId": 0,
        "degreeCertificate": "string",
        "experienceCertificate": "string",
        "otherDocuments": [
          "string"
        ],
        "panCard": "string",
        "tenthDCertificate": "string",
        "twelthCertificate": "string"
      },
      "branchId": 1,
      "connectOrgId": newConnectOrg!.id,
      "contact": ctmsMobileController.text,
      "createdDate": "string",
      "departmentId": 1,
      "designation": "Admin",
      "deviceId": "string",
      "emailId": ctmsOrgEmailIdController.text,
      "employeeLocation": "ONSITE",
      "esiNO": "string",
      "firstName": ctmsOrgNameController.text,
      "id": 0,
      "image": "string",
      "isActive": 0,
      "is_admin": true,
      "lastName": " ",
      "mobileNumber": ctmsMobileController.text,
      "organisationId": ctmsOrganization!.id,
      "os": "string",
      "otp": "string",
      "panNo": ctmsPanController.text,
      "password": "string",
      "roleId": 0,
      "securityAnswer": "string",
      "securityQuestion": "string",
      "status": "Active"
    };

    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    var para = jsonEncode(data);
    String myUrl = ApiConstant.BASE_URL + 'api/saveUser';
    print(myUrl);
    final dio = Dio();
    var response = await dio.post(myUrl,
        data: para,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    print("\n\nCtms User Response:"+response.data);
    EasyLoading.dismiss();
    return response;
  }

  editCtmsOrganization(BuildContext context,CtmsOrganization ctmsOrganization) async {
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    Map<String, dynamic> parameter = {
      "active": true,
      "city": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:ctmsOrganization.city,
      "description": ctmsDescriptionController.text.isNotEmpty?ctmsDescriptionController.text:ctmsOrganization.description,
      "emailId": ctmsOrgEmailIdController.text.isNotEmpty?ctmsOrgEmailIdController.text:ctmsOrganization.emailId,
      "gstNumber": ctmsGst1Controller.text.isNotEmpty?ctmsGst1Controller.text:ctmsOrganization.gstNumber,
      "gstNumber2": ctmsGst2Controller.text.isNotEmpty?ctmsGst2Controller.text:ctmsOrganization.gstNumber2,
      "id": ctmsOrganization.id,
      "connectOrgId" : ctmsOrganization.connectOrgId,
      "connectUserId" : ctmsOrganization.connectUserId,
      "instruction": ctmsOrganization.instruction,
      "invoiceLogo": ctmsInvoiceLogoController.text.isNotEmpty?ctmsInvoiceLogoController.text:ctmsOrganization.invoiceLogo,
      "isVerified": ctmsOrganization.isVerified,
      "landLineNumber": ctmsMobileController.text.isNotEmpty?ctmsMobileController.text:ctmsOrganization.landLineNumber,
      "logo": ctmsLogoController.text.isNotEmpty?ctmsLogoController.text:ctmsOrganization.logo,
      "officialEmailId": ctmsOrgEmailIdController.text.isNotEmpty?ctmsOrgEmailIdController.text:ctmsOrganization.emailId,
      "orgAddress": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:ctmsOrganization.orgAddress,
      "orgMobileNumber": ctmsMobileController.text.isNotEmpty?ctmsMobileController.text:ctmsOrganization.orgMobileNumber,
      "orgName": ctmsOrgNameController.text.isNotEmpty?ctmsOrgNameController.text:ctmsOrganization.orgName,
      "panCardNumber": ctmsPanController.text.isNotEmpty?ctmsPanController.text:ctmsOrganization.panCardNumber,
      "rulesForTaxinvoice": ctmsOrganization.rulesForTaxinvoice,
      "state": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:ctmsOrganization.state,
      "tanCardNumber": ctmsTanController.text.isNotEmpty?ctmsTanController.text:ctmsOrganization.tanCardNumber,
      "typeOfRegistration": ctmsTypeOfRegController.text.isNotEmpty?ctmsTypeOfRegController.text:ctmsOrganization.typeOfRegistration,
      "unloadingLogo": ctmsUnloadingLogoController.text.isNotEmpty?ctmsUnloadingLogoController.text:ctmsOrganization.unloadingLogo,
      "website": ctmsWebsiteController.text.isNotEmpty?ctmsWebsiteController.text:ctmsOrganization.website,
    };
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    var para = jsonEncode(parameter);
    String myUrl = ApiConstant.BASE_URL + 'api/Organisation/update?Id=${ctmsOrganization.id}';
    print(myUrl);

    var response = await dio.put(myUrl,
        data: para,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      showCustomToast(context, "Company Edit Successfully.", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    notifyListeners();
    return response;
  }

  deleteCtms(BuildContext context,CtmsOrganization ctmsOrganization) async {
    String myUrl = ApiConstant.BASE_URL + 'api/Organisation/delete?Id=${ctmsOrganization.id}';
    print(myUrl);
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    Dio dio = Dio();
    var response = await dio.delete(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      ctmsOrgList.remove(ctmsOrganization);
      showCustomToast(context, "Organization Deleted Successfully", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    Navigator.of(context).pop();
    notifyListeners();
  }


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
      connectOrganizationId = dataObj.id;
      newConnectOrg = dataObj;
      print(connectOrganizationId);
    }
    notifyListeners();
    return createResponse;
  }

  saveTkdUser(BuildContext context) async {
    String myUrl = AppConstants.BASE_URL + "companyRegistration";
    Uri uri = Uri.parse(myUrl);

    Map<String, dynamic> data = {
      "aadharCard": '',
      "alternativeNumber": ctmsMobileController.text,
      "city": ctmsOrgAddressController.text,
      "companyAddress": ctmsOrgAddressController.text,
      "companyId": newConnectOrg!.id,
      "companyLogo": newConnectOrg!.companyLogo,
      "companyName": newConnectOrg!.companyName,
      "country": ctmsOrgAddressController.text,
      "deviceId": '',
      "emailId": ctmsOrgEmailIdController.text,
      "firstName": ctmsOrgNameController.text,
      "id": 0,
      "idOfMainBranch": 0,
      "isPaid":  0,
      "isUserVerifiedByCompany": 0,
      "landlineNumber": 0,
      "lastName": '',
      "loggedTime": " ",
      "loggedUserName": '',
      "mainBranch":  0,
      "mobileNumber": ctmsMobileController.text,
      "numberOfTimesRating": 0,
      "os": '',
      "otp": '',
      "paidStartDate":'',
      "password": '',
      "preferredRouresEntered": 0,
      "profilePicture": ctmsLogoController.text,
      "ratings": 0,
      "state": ctmsOrgAddressController.text,
      "transporterOrAgent": 0,
      "userName": '',
      "validTill": '',
      "verified": 0,
      "website": ctmsWebsiteController.text
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    print("\n\nTkd User Response:"+createResponse.body.toString());
    notifyListeners();
  }

  getTkdUserByMobile(BuildContext context) async {
    String myUrl = AppConstants.BASE_URL +'/getByMobileNumber?mobileNumber=${newConnectOrg!.companyMobileNumber}';
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

  getConnectOrganization(int id) async {
    String myUrl = AppConstants.BASE_URL + 'CompanyDetails/getByID?id=${id}';
    print("GetTkdOrg Details:" + myUrl);
    var req = await http.get(Uri.parse(myUrl));
   if(req.statusCode==200){
     var response = await json.decode(req.body);
     print("Org Response : "+req.body);
     Organization organizationModel = Organization.fromJson(response);
     newConnectOrg = organizationModel;
     notifyListeners();
     return newConnectOrg;
   }else{
     return null;
   }

  }

  editTkdOrganization(BuildContext context,Organization organizationData) async {
    EasyLoading.show(status: "Loading");
    Map<String, dynamic> parameter = {
      "active": true,
      "city": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:organizationData.city,
      "companyAddress": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:organizationData.companyAddress,
      "companyMobileNumber": ctmsMobileController.text.isNotEmpty?ctmsMobileController.text:organizationData.companyMobileNumber,
      "companyName": ctmsOrgNameController.text.isNotEmpty?ctmsOrgNameController.text:organizationData.companyName,
      "gstNumber": ctmsGst1Controller.text.isNotEmpty?ctmsGst1Controller.text:organizationData.gstNumber,
      "gstNumber2": ctmsGst2Controller.text.isNotEmpty?ctmsGst2Controller.text:organizationData.gstNumber2,
      "id": organizationData.id,
      "isVerified": organizationData.isVerified,
      "landLineNumber": ctmsMobileController.text.isNotEmpty?ctmsMobileController.text:organizationData.landlineNumber,
      "logo": ctmsLogoController.text.isNotEmpty?ctmsLogoController.text:organizationData.companyLogo,
      "officialEmailId": ctmsOrgEmailIdController.text.isNotEmpty?ctmsOrgEmailIdController.text:organizationData.officialEmailId,
      "panCardNumber": ctmsPanController.text.isNotEmpty?ctmsPanController.text:organizationData.panCardNumber,
      "pointOfContact": organizationData.pointOfContact,
      "rating": organizationData.rating,
      "otp": '',
      "state": ctmsOrgAddressController.text.isNotEmpty?ctmsOrgAddressController.text:organizationData.state,
      "tanCardNumber": ctmsTanController.text.isNotEmpty?ctmsTanController.text:organizationData.tanCardNumber,
      "typeOfRegistration": ctmsTypeOfRegController.text.isNotEmpty?ctmsTypeOfRegController.text:organizationData.typeOfRegistration,
      "website": ctmsWebsiteController.text.isNotEmpty?ctmsWebsiteController.text:organizationData.website,
    };
    String myUrl = AppConstants.BASE_URL + "/CompanyDetails";
    Uri uri = Uri.parse(myUrl);
    var body = json.encode(parameter);
    print(body);
    var createResponse = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    EasyLoading.dismiss();
    if (createResponse.statusCode == 200) {
      var jsonData = jsonDecode(createResponse.body);
      Organization dataObj = Organization.fromJson(jsonData);
      connectOrganizationId = dataObj.id;
      newConnectOrg = dataObj;
      print(connectOrganizationId);
      showCustomToast(context, "Company Edited Successfully.", Icons.check, Colors.green);

    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    notifyListeners();
    return createResponse;
  }

  deleteTkdOrganization(BuildContext context,Organization organization) async {
    String myUrl = ApiConstant.BASE_URL + 'CompanyDetails?id=${organization.id}';
    print(myUrl);
    var createResponse = await http.delete(Uri.parse(myUrl),
        headers: {"Content-Type": "application/json"});
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    EasyLoading.dismiss();
    if (createResponse.statusCode == 200) {
      showCustomToast(context, "Organization Deleted Successfully", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    Navigator.of(context).pop();
    notifyListeners();
  }

  buttonEnble(){
    if(ctmsOrgNameController.text.isNotEmpty && ctmsMobileController.text.isNotEmpty && ctmsOrgEmailIdController.text.isNotEmpty && ctmsPanController.text.isNotEmpty && ctmsTanController.text.isNotEmpty){
      buttonActive=true;
    }else{
      buttonActive=false;
    }
    notifyListeners();
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

  setData(CtmsOrganization ctmsOrganization){
    ctmsOrgNameController.text=ctmsOrganization.orgName.toString();
    ctmsWebsiteController.text=ctmsOrganization.website.toString();
    ctmsTanController.text=ctmsOrganization.tanCardNumber.toString();
    ctmsOrgAddressController.text=ctmsOrganization.orgAddress.toString();
    ctmsPanController.text=ctmsOrganization.panCardNumber.toString();
    ctmsTypeOfRegController.text=ctmsOrganization.typeOfRegistration.toString();
    ctmsOrgEmailIdController.text=ctmsOrganization.emailId.toString();
    ctmsMobileController.text=ctmsOrganization.orgMobileNumber.toString();
    ctmsGst2Controller.text=ctmsOrganization.gstNumber2.toString();
    ctmsLogoController.text=ctmsOrganization.logo.toString();
    ctmsDescriptionController.text=ctmsOrganization.description.toString();
    ctmsGst1Controller.text=ctmsOrganization.gstNumber.toString();
    notifyListeners();
  }

  String imgPath = '';
  String invoiceLogo = '';
  String unLoadingLogo = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(BuildContext context,StateSetter stateSetter, bool isImg, bool isInvoice,
      bool isUnloading) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      stateSetter(() {
        objFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imageBytes = result.files.first.bytes;
        print(fileName);
        print(await result.files.first
            .toString()
            .length);
        //  uploadedDocument = isImg ? null : fileName;
        if (await result.files.first
            .toString()
            .length >= 500) {
          showCustomToast(
              context, "Image Size should be less than 500 KB", Icons.close, Colors.red);
        } else {
          print('the url is ${ApiConstant.UPLOAD_LEAD_IMG}');
          var postUri = Uri.parse(ApiConstant.UPLOAD_LEAD_IMG);
          var request = new http.MultipartRequest("POST", postUri);

          Map<String, String> headers = {
            "Content-Type": "multipart/form-data",
            'Authorization': 'Bearer ${token}'
          };
          request.files.add(new http.MultipartFile(
              "image1", objFile!.readStream!, objFile!.size,
              filename: objFile!.name));
          /* request.files.add(new http.MultipartFile(
        "imageFile",filename: objectFile.name));*/
          request.headers.addAll(headers);
          var response = await request.send();
          print(response.statusCode);
          response.stream.transform(utf8.decoder).listen((value) {
            print(value);
            var jsonData = jsonDecode(value);
            ImgUploadResponse imgUploadResponse =
            ImgUploadResponse.fromJson(jsonData);
            if (isImg) {
              imgPath = imgUploadResponse.data!;
            }

            if (isUnloading) {
              unLoadingLogo = imgUploadResponse.data!;
            }
            if (isInvoice) {
              invoiceLogo = imgUploadResponse.data!;
            }
            print("Uploaded Img Path From s3 bucket::" +
                imgPath +
                "\ninvoiceLogo:" +
                invoiceLogo +
                "\nunLoadingLogo:" +
                unLoadingLogo);
            stateSetter(() {});
          });
          print('the response is ${response}');

          EasyLoading.dismiss();
          if (response.statusCode == 200) {
            // ToastMessage.show(context, "Image uploaded");
            showCustomToast(context, "Image Uploaded", Icons.check, Colors.green);
          }
        }
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }
}