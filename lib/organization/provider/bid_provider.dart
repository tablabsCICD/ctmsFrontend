import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/organization/model/bid_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/model/biding_user_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';

class BidProvider extends ChangeNotifier{
  List<BidingUser> allBidingList = [];
  List<Bid> receivedBidingList = [];
  var response;
  int totalPages = 0;
  bool isLoading = false;
  List<BidingUser> truckLoadTypeList = [];

  getAllBidingList(String userName,int isPublic) async {
    isLoading = true;
    notifyListeners();
   // https://api.tkdost.com/tkd2/api/GetPostsAndBidsForUser?userName=user327796&privatePost=0
    String myUrl = AppConstants.BID_OWN_POST +'?userName=${userName}&privatePost=${isPublic}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    print(response);
    var type = BidingUserModel.fromJson(response);
    allBidingList.clear();
    allBidingList=type.content;
    allBidingList.sort((a, b) => int.parse(a.amount!).compareTo(int.parse(b.amount!)));
    print('Low to hight in biding amount: $allBidingList');
    allBidingList.forEach((element) {print("amount : "+element.amount.toString());});
    notifyListeners();
  }

  List<TruckLoad> allPostList = [];
  List<TruckLoad> myOwnPostList = [];

  getList(String userName) async {
    allPostList.clear();
    myOwnPostList.clear();
    String myUrl = AppConstants.GET_OWNPOST + '?userName=${userName}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = json.decode(req.body);
    var type = TruckLoadType.fromJson(response);
    allPostList = type.content;
    for (int i = 0; i < allPostList.length; i++) {
      if (allPostList[i].tableName == 'FullTruckLoad')
      {
        myOwnPostList.add(allPostList[i]);
      }
    }
    notifyListeners();
  }


  getReceivedBidingList(String type1,int postId) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL +'/GetBidsForPost?type=${type1.toString()}&postId=${postId}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    response = json.decode(req.body);
    print(response);
    var type = BidModel.fromJson(response);
    receivedBidingList.clear();
    receivedBidingList=type.content;
    receivedBidingList.sort((a, b) => int.parse(a.amount!).compareTo(int.parse(b.amount!)));
    print('Low to hight in biding amount: $receivedBidingList');
    receivedBidingList.forEach((element) {print("amount : "+element.amount.toString());});
    notifyListeners();
    return receivedBidingList;
  }

  getBidingUser(int id) async {
    String myUrl = AppConstants.BASE_URL + '/fullTruckLoad/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = BidingUserModel.fromJson(response);
    truckLoadTypeList.addAll(list.content);
    print(truckLoadTypeList);
    notifyListeners();
    return truckLoadTypeList;
  }


  generateBid({int? mobile,String? description,int? id,String? email,String? amount,int? idOfPost,String? bidderUserName,
    String? userName,String? type,String? loggedUserName}) async {
    String myUrl = AppConstants.BID_TO_POST;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "amount": amount,
      "bidderUserName": bidderUserName,
      "description": description,
      "emailId": email,
      "id": id,
      "idOfPost": idOfPost,
      "loggedTime": "",
      "loggedUserName": loggedUserName,
      "mobileNumber": mobile,
      "type":type,
      "userName": userName
    };
    var body = json.encode(data);
    print(data);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);
    BidingUser dataObj = BidingUser.fromJson(jsonData);
    //allBidingList.add(dataObj);
    notifyListeners();
  }

  deleteBid(BidingUser bid) async {
    String myUrl = AppConstants.BID_TO_POST + '?id=${bid.bidingId}';
    print(myUrl);
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    print(response);
    allBidingList.remove(bid);
    notifyListeners();
  }
}