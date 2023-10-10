import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/util/app_constants.dart';

class PlanProvider extends ChangeNotifier{
  List<TruckLoad> truckLoadTypeList = [];
  var response;
  // int currentPage = 1;
  int totalPages = 0;
  bool fla = false,pla = false,flr = false,plr = false;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  getFullLoadTruckList({int currentPage = 0}) async {
    if(currentPage == 0){
      truckLoadTypeList.clear();
    }

    String myUrl = AppConstants.FULL_LOAD_ALL_CARD +'?page=${currentPage}&size=10&fullLoadAvailable=${fla}&fullLoadRequired=${flr}&partLoadAvailable=${pla}&partLoadRequired=${plr}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    if(req.statusCode == 200) {
      response = json.decode(req.body);
      var type = TruckLoadType.fromJson(response);
      totalPages = type.totalPages;
      truckLoadTypeList.addAll(type.content);
      notifyListeners();
    }
  }

  savePost({int? mobile,String? destination,int? dnd,String? email,String? fullLoadChoice,int? id,String? instruction,
    String? loadWeight,String? name,String? mainTag,String? os,String? otherDetails,String? source,int? partLoad,
    int? privatePost,double? rating,String? customerName, String? type,String? typeOfCargo,String? vehicleSize, String? typeOfPayment,int? userId}) async {
    String myUrl = AppConstants.POST_FULL_LOAD;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "contactNumber": mobile?? 0,
      //"date": '',
      "destination": destination,
      "dnd": dnd?? 0,
      "emailId": email,
      "fullLoadChoice": fullLoadChoice,
      "id": 0,
      "instructions": instruction,
      "loadWeight": loadWeight,
      "loggedTime": "2022-02-09T05:32:12.456Z",
      "loggedUserName": name,
      "mainTag": mainTag,
      "os": os,
      "otherDetails": otherDetails,
      "partLoad": partLoad?? 0,
      "postingTime": "string",
      "privatePost": privatePost?? 0,
      "rating": rating?? 5,
      "source": source,
      "tableName": "Full Load",
      "topicName": "Full Load Truck",
      "transporterOrCustomerName": customerName,
      "type": type,
      "typeOfCargo": typeOfCargo,
      "typeOfPayment": typeOfPayment,
      "vehicleSize": vehicleSize,
      "userId": userId
    };
    var body = json.encode(data);
    print(data);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);
    TruckLoad dataObj = TruckLoad.fromJson(jsonData);
    truckLoadTypeList.add(dataObj);
    notifyListeners();
  }

  getSearchByNameList(String name,String source,String dest) async {
    truckLoadTypeList.clear();
    String myUrl = AppConstants.FULL_LOAD_ALL_CARD +'?nameOfPerson=${name}&source=${source}&destination=${dest}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = json.decode(req.body);
    var type = TruckLoadType.fromJson(response);
    truckLoadTypeList = type.content;
    notifyListeners();
  }
}