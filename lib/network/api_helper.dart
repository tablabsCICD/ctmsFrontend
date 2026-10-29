import 'dart:convert';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';

import '';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../model/api_response.dart';

import 'package:http/http.dart' as http;

class ApiHelper{

  Dio dio=Dio();

  Future<ApiResponse> apiGet(String URL) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show(status: "Loading");
    var request = await dio.get(URL,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    EasyLoading.dismiss(animation: true);
    return apiResponseHelper;
  }

  Future<ApiResponse>  apiPost(String URL) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var request = await dio.post(URL,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }
  Future<ApiResponse>  apiPut(String URL,Map<String,dynamic>data) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var body = json.encode(data);
    var request = await dio.put(URL,data: body,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse>  apiPutWithoutBody(String URL) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var request = await dio.put(URL,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse> ApiDeleteData(String URL) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var request = await dio.delete(URL,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }


  Future<ApiResponse> postParameter(String url,Map<String,dynamic>data) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show(status: "Loading");
    var body = json.encode(data);
    final request = await dio.post(url,data: body,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    ApiResponse apiResponseHelper = returnResponse(request);
    EasyLoading.dismiss();
    return apiResponseHelper;
  }


  ApiResponse returnResponse<T>(Response request){
    if(request.statusCode==200){
     var response = json.decode(request.data);
     ApiResponse apiResponseHelper = ApiResponse(request.statusCode!, response);
     return apiResponseHelper;
    }else{
      ApiResponse apiResponseHelper = ApiResponse(request.statusCode!, null);
      return apiResponseHelper;
    }
  }

  Future<dynamic> ApiAddPostDataMapRequest(
      String url, Map<String, dynamic> data) async {
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("response : ${response.statusCode}" +
        " --- " +
        response.body.toString());
    return response;
  }

  Future<String> uploadImage(XFile file) async {
    EasyLoading.show(status: "Uploading");
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image1":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio.post("http://ec2-13-126-179-190.ap-south-1.compute.amazonaws.com:8080/tkdmain/api/UploadImage1", data: formData,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    EasyLoading.dismiss();
    return response.data;
  }



}