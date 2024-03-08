 import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/shared_post_model.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
 import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

class DashboardProvider extends ChangeNotifier{
  String? selectedSampleData = '';
  List<User> allUserList = [];
  List<int> selectedUserList = List<int>.empty(growable: true);
  List<String> allUserNameList = [];
  List<String> searchingList = [];
  List<TruckLoad> truckLoadTypeList = [];
  bool isLoading = false;
  var response;
  bool isFirstLoading = false;
  int totalPages = 0;
  bool fla = false,pla = false,flr = false,plr = false;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

  getFullLoadTruckList({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      isFirstLoading = true;
      truckLoadTypeList.clear();
    }

    String myUrl = AppConstants.FULL_LOAD_ALL_CARD +'?page=${currentPage}&size=10&fullLoadAvailable=${fla}&fullLoadRequired=${flr}&partLoadAvailable=${pla}&partLoadRequired=${plr}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isFirstLoading= false;
    isLoading = false;
    if(req.statusCode == 200) {
      response = json.decode(req.body);
      var type = TruckLoadType.fromJson(response);
      totalPages = type.totalPages;
      truckLoadTypeList.addAll(type.content);
      notifyListeners();
    }
  }

  List<String> allVerifiedUserList = [];
  getAllUserList({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      isFirstLoading = true;
      truckLoadTypeList.clear();
    }

    String myUrl = AppConstants.BASE_URL +'companyRegistration?page=${currentPage}&size=6000';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isFirstLoading= false;
    isLoading = false;
    if(req.statusCode == 200) {
      response = json.decode(req.body);
      var type = AuthApi.fromJson(response);
      allUserList.addAll(type.content!);
      allUserList.forEach((element) {
        allUserNameList.add('${element.firstName} ${element.lastName}');
        if(element.isPaid != 0) {
          allVerifiedUserList.add('${element.firstName} ${element.lastName}');
        }
      });
      print(allUserNameList.length.toString() + "length sacsczcscscscscscscscscscscscscscscscs");
      notifyListeners();
    }
  }


  getSelectedUserId(List<String> selectedItems){
    selectedUserList.clear();
    for(int i=0;i<selectedItems.length;i++){
      final selectedItem=selectedItems.elementAt(i);
      for(var i = 0; i < allUserList.length; i++){
        if(selectedItem == "${allUserList[i].firstName} ${allUserList[i].lastName}"){
          selectedUserList.add(allUserList[i].id!);
        }
      }
    }
    print("Final"+selectedUserList.length.toString());
    notifyListeners();
  }


  savePost({int? mobile,String? destination,int? dnd,String? email,String? fullLoadChoice,int? id,String? instruction,User? userList,
    String? loadWeight,String? name,String? mainTag,String? os,String? otherDetails,String? source,int? partLoad,
    int? privatePost,double? rating,String? customerName, String? type,String? typeOfCargo,String? vehicleSize, String? typeOfPayment,int? userId}) async {

    String myUrl = selectedSampleData == "Show to All" ? AppConstants.BASE_URL + "fullTruckLoad" : AppConstants.POST_FULL_LOAD;
    print(myUrl);
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
    "contactNumber": mobile?? 0,
    //"date": "2022-07-04T08:55:23.783Z",
    "destination": destination,
    "dnd": dnd?? 0,
    "emailId": email,
    "fullLoadChoice": fullLoadChoice,
    "instructions": instruction,
    "listOfUserIds": selectedUserList,
    "loadWeight": loadWeight,
    //"loggedTime": "2022-07-04T08:55:23.783Z",
    "loggedUserName": name,
    "mainTag": mainTag,
    "os": "Web",
    "otherDetails": otherDetails,
    "partLoad": partLoad?? 0,
    "privatePost": selectedSampleData == "Show to All" ? 0 : privatePost,
    "rating": rating?? 5,
    "source": source,
    "tableName": "Full Load",
    "topicName": "Full Load Truck",
    "transporterOrCustomerName": customerName,
    "type": type,
    "typeOfCargo": typeOfCargo,
    "typeOfPayment": typeOfPayment,
    "vehicleSize": vehicleSize,
   // "userId": userId
    };
    var body = json.encode(data);
    print("request : ${data}");
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("response : ${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);
    TruckLoad dataObj = TruckLoad.fromJson(jsonData);
    print(dataObj);
    truckLoadTypeList.add(dataObj);
    notifyListeners();
  }

  SharedPostModel? truckLoad;
  getRequirementDetails(int id) async {
    String myUrl = AppConstants.BASE_URL +'fullTruckLoad/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = SharedPost.fromJson(response);
    truckLoad = list.content[0];
    notifyListeners();
    return truckLoad;
  }

  getSearchByNameList(String name,String source,String dest) async {
    isLoading = true;
    notifyListeners();
    truckLoadTypeList.clear();
    String myUrl = AppConstants.FULL_LOAD_ALL_CARD +'?nameOfPerson=${name}&source=${source}&destination=${dest}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading == false;
    response = json.decode(req.body);
    var type = TruckLoadType.fromJson(response);
    truckLoadTypeList = type.content;
    notifyListeners();
  }
}