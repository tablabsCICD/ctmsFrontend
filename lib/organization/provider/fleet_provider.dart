
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/organization/model/feet_model.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';

class FleetProvider extends ChangeNotifier{
  List<Fleet> fleetList = [];
  var response;
  int totalPages = 0;
  bool isLoading = false;

  getfleetList({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      fleetList.clear();
    }
    String myUrl = AppConstants.BASE_URL + 'Fleet?page=${currentPage}';
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    var type = FeetModel.fromJson(response);
    fleetList.addAll(type.content);
   // totalPages = type.totalPages;
    notifyListeners();
  }

  createFleet({String? userName,int? orgId,String? typeOfVehicle,
    int? userId,String? vehicleNumber,String? weight}) async {
    String myUrl = AppConstants.BASE_URL + 'Fleet';
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
        "id": 0,
        "loggedTime": "",
        "loggedUserName": userName,
        "organisationId": orgId,
        "typeOfVehicle": typeOfVehicle,
        "userId": userId,
        "vehicleNumber": vehicleNumber,
        "weightInTonnes": weight
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var jsonData = jsonDecode(createResponse.body);
    Fleet feetObj = Fleet.fromJson(jsonData);
    fleetList.add(feetObj);
    notifyListeners();
  }

  deleteFleet(Fleet obj) async {
    String myUrl = AppConstants.BASE_URL + 'Fleet?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    fleetList.remove(obj);
    notifyListeners();
  }
}