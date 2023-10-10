import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/model/api_response.dart';
class APIHelper {
  ApiGetData(String URL) async{
    var req = await http.get(Uri.parse(URL));

    var response = json.decode(req.body);
    print('$URL response ${response}');
    return response;
  }

  ApiPOSTData(String URL) async{
    var req = await http.post(Uri.parse(URL));
    var response = json.decode(req.body);
    return response;
  }
  ApiPostData(String URL) async{
    var req = await http.post(Uri.parse(URL));
    var response = json.decode(req.body);
    return response;
  }
  ApiPutData(String URL) async{
    var req = await http.put(Uri.parse(URL));
    var response = json.decode(req.body);
    return response;
  }

  ApiDeleteData(String URL) async{
    var req = await http.delete(Uri.parse(URL));
    var response = json.decode(req.body);
    return req.statusCode;
  }


  Future<int> ApiAddPostDataMapRequest(String url,Map<String,dynamic>data) async{
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("response : ${response.statusCode}" + " --- " + response.body.toString());
    return response.statusCode;
  }


  Future<ApiResponseHelper> ApiAddPostDataMapRequestCall(String url,Map<String,dynamic>data) async{
    var body = json.encode(data);
    final request = await http.post(Uri.parse(url),headers: {"Content-Type": "application/json"}, body: body);
    var response = json.decode(request.body);
    print('the status code is ${request.statusCode}');
    ApiResponseHelper apiResponseHelper = ApiResponseHelper(request.statusCode, response);
    return apiResponseHelper;
  }




}