import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/organization_portal/util/date_converter.dart';

class BuySellProvider extends ChangeNotifier{
  List<TruckLoad> buyVehicleList = [];
  var response;
  List<TruckLoad> sellVehicleList = [];
  var response1;
  int sellTotalPages = 0;
  int totalPages = 0;
  bool isLoadingForBuyVehicles = false;
  bool isLoadingForSellVehicles = false;

  Future<TruckLoadType> getBuyVehicles({int currentPage = 0}) async {
    isLoadingForBuyVehicles = true;
    notifyListeners();
    if(currentPage == 0){
      buyVehicleList.clear();
    }
    String myUrl = AppConstants.BUY_SELL_ALL_CARD +'?type=Buy&&page=${currentPage}';
    var req = await http.get(Uri.parse(myUrl));
    isLoadingForBuyVehicles = false;
    response = json.decode(req.body);
    var type = TruckLoadType.fromJson(response);
    buyVehicleList.addAll(type.content);
    notifyListeners();
    return type;
  }

  Future<TruckLoadType> getSellVehicles({int currentPage = 0}) async {
    isLoadingForSellVehicles = true;
    notifyListeners();
    if(currentPage==0){
    sellVehicleList.clear();}
    String myUrl = AppConstants.BUY_SELL_ALL_CARD +'?type=Sell&page=${currentPage}';
    var req = await http.get(Uri.parse(myUrl));
    isLoadingForSellVehicles = false;
    response1 = json.decode(req.body);
    var type1 = TruckLoadType.fromJson(response1);
    sellVehicleList.addAll(type1.content);
    notifyListeners();
    return type1;
  }

  createBuySell({String? description,String? agentName,String? bodyType,String? buySellType,String? city,String? conditionOfTyre,
    String? ConOfVehicle,int? mobile,String? date,String? price,int? id,String? image,String? insurancePaidDate,String? mainTag,String? maker,String? mfgYear,
    String? model,String? lUserName,String? owner,String? postingTime,String? type,String? registrationNumber,String? yearOfBuying
  }) async {
    String myUrl = AppConstants.POST_BUY_SELL;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "additionalInformation": description,
      "agentName": agentName,
      "bodyType": bodyType,
      "buySelltype": buySellType,
      "city": city,
      "conditionOfTyres": conditionOfTyre,
      "conditionOfVehicle": ConOfVehicle,
      "contactNumber": mobile,
      "date": "2022-01-22T11:29:53.473Z",
      "estimatedPrice": price,
      "id": id,
      "image1": image,
      "image2": " ",
      "image3": " ",
      "image4": " ",
      "insaurancePaidUpto": insurancePaidDate,
      "loggedTime": "2022-01-22T11:29:53.473Z",
      "loggedUserName": lUserName,
      "mainTag": mainTag,
      "maker": maker,
      "mfgYear": yearOfBuying,
      "model": model,
      "negotiable": 0,
      "os": " ",
      "ownerName": owner,
      "postingTime": "2022-01-22T11:29:53.473Z",
      "privatePost": 0,
      "tableName": "string",
      "topicName": "string",
      "type": type,
      "vehicleRegistrationNumber": registrationNumber,
      "yearOfBuying": yearOfBuying
    };
    var body = json.encode(data);
    print(body);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var jsonData = jsonDecode(createResponse.body);
    if(type=='Buy Vehicle'){
      TruckLoad dataObj = TruckLoad.fromJson(jsonData);
      buyVehicleList.add(dataObj);
    }
    else{
      TruckLoad dataObj = TruckLoad.fromJson(jsonData);
      sellVehicleList.add(dataObj);
    }
    notifyListeners();

  }

  deleteBuySell(TruckLoad truckLoad, String? type) async {
    String myUrl = AppConstants.POST_BUY_SELL +'?id=${truckLoad.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    if(type=='Buy Vehicle'){
      buyVehicleList.remove(truckLoad);
    }
    else{
      sellVehicleList.remove(truckLoad);
    }
    notifyListeners();
    }
}