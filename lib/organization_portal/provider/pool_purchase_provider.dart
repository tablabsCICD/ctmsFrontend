
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/organization_portal/model/pool_purchase_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

class PoolPurchaseProvider extends ChangeNotifier{
  List<PoolPurchase> poolPurchaseList = [];
  var response;
  bool vehicles=false,tyres=false,body_building=false,finance=false,insurance=false,other=false;
  int totalPages = 0;
  bool isLoading = false;

  getCard({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
    poolPurchaseList.clear();}
    String myUrl = AppConstants.BULK_DATA +'?page=${currentPage}&size=20';
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    var type = PoolPurchaseModel.fromJson(response);
    poolPurchaseList.addAll(type.content);
    totalPages = type.totalPages;
    notifyListeners();
  }

  getFilteredData({int currentPage = 0}) async {
    if(currentPage == 0){
      poolPurchaseList.clear();
    }
    String myUrl = AppConstants.BULK_DATA +'?page=${currentPage}&size=20';
    if(vehicles){
      myUrl = myUrl + '&myParam[]=Vehicles';
    }
    if(tyres){
      myUrl = myUrl + '&myParam[]=Tyres';
    }
    if(body_building){
      myUrl = myUrl + '&myParam[]=Body Building';
    }
    if(finance){
      myUrl = myUrl + '&myParam[]=Finance';
    }
    if(insurance){
      myUrl = myUrl + '&myParam[]=Insurance';
    }
    if(other){
      myUrl = myUrl + '&myParam[]=Other';
    }
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = json.decode(req.body);
    var type = PoolPurchaseModel.fromJson(response);
    poolPurchaseList.addAll(type.content);
    totalPages = type.totalPages;
    notifyListeners();
  }

  createPoolPurchase({String? agentName,String? city,int? mobile,String? description,String? email,String? firstName,
    int? id,String? lastname,String? lUserName,String? image,String? purchaseItem,String? purchaseDate,String? type}) async {
    String myUrl = AppConstants.BULK_DATA;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "agentName": agentName,
      "city": city,
      "contactNumber": mobile,
      "description": description,
      "emailId": email,
      "firstName": firstName,
      "id": id,
      "lastName": lastname,
      "loggedTime": 0,
      "loggedUserName": lUserName,
      "mobileNumber": mobile,
      "ownerName": lUserName,
      "privatePost": 0,
      "profilePicture": " ",
      "purchaseItem": purchaseItem,
      "purchasePlannedDate": purchaseDate,
      "type": 'Pool Purchase'
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " + createResponse.body.toString());
    var jsonData = jsonDecode(createResponse.body);
    PoolPurchase routeData = PoolPurchase.fromJson(jsonData);
    poolPurchaseList.add(routeData);
    notifyListeners();
  }

  deletePoolPurchase(PoolPurchase obj) async {
    String myUrl = AppConstants.BULK_DATA +'?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    poolPurchaseList.remove(obj);
    notifyListeners();
  }
}