import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../model/api_response.dart';

class ApiHelper{

  Dio dio=Dio();

  Future<ApiResponse> apiGet(String URL) async{
    EasyLoading.show(status: "Loading");
    var request = await dio.get(URL);
    ApiResponse apiResponseHelper = returnResponse(request);
    EasyLoading.dismiss(animation: true);
    return apiResponseHelper;
  }

  Future<ApiResponse>  apiPost(String URL) async{
    var request = await dio.post(URL);
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }
  Future<ApiResponse>  apiPut(String URL,Map<String,dynamic>data) async{
    var body = json.encode(data);
    var request = await dio.put(URL,data: body);
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse> ApiDeleteData(String URL) async{
    var request = await dio.delete(URL);
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }


  Future<ApiResponse> postParameter(String url,Map<String,dynamic>data) async{
    EasyLoading.show(status: "Loading");
    var body = json.encode(data);
    final request = await dio.post(url,data: body);
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


  Future<String> uploadImage(XFile file) async {
    EasyLoading.show(status: "Uploading");
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "profilePicture":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    var response = await dio.post("http://ec2-13-126-179-190.ap-south-1.compute.amazonaws.com:8080/tkdmain/api/UploadImage1", data: formData);
    EasyLoading.dismiss();
    return response.data;
  }



}