import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization/model/comments_model.dart';
import 'package:flutter_hr_management/organization/model/feedback_model.dart';
import 'package:flutter_hr_management/organization/model/gallary_model.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/network/api_call.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';

import '../model/discussion_model.dart';

class MoreProvider extends ChangeNotifier {
  List<TruckLoad> allPostList = [];
  List<TruckLoad> myFullLoadTypeList = [];
  List<TruckLoad> myPartLoadTypeList = [];
  List<TruckLoad> myJobList = [];
  List<TruckLoad> myOwnPostList = [];
  List<Job> myJobsList = [];
  List<TruckLoad> myBuyVehicleList = [];
  List<PoolPurchase> myPoolPurchaseList = [];
  List<Gallery> myGalleryList = [];
  List<FeedBack> feedbackList = [];
  List<FeedBack> fullLoadFeedbackList = [];
  List<FeedBack> partLoadFeedbackList = [];
  List<FeedBack> galleryFeedbackList = [];
  List<FeedBack> BuySellFeedbackList = [];
  List<DiscussionContent>discussionList=[];
  var response,
      fullLoadResponse,
      partLoadResponse,
      jobResponse,
      candidateResponse,
      buyResponse,
      sellResponse,
      poolPurchaseResponse,
      galleryResponse;
  bool jobFlag = false,
      fullLoadFlag = false,
      buySellFlag = false,
      poolPurchaseFlag = false,
      partLoadFlag = false,
      galleryFlag = false;

  getOwnPostList(String userName,{int currentPage = 0}) async {
    isMoreLoading = true;
    notifyListeners();
    if(currentPage == 0){
      isMoreFirstLoading = true;
      allPostList.clear();
      myFullLoadTypeList.clear();
      myPartLoadTypeList.clear();
      myJobList.clear();
      myBuyVehicleList.clear();
    }

    String myUrl = AppConstants.GET_OWNPOST + '?userName=${userName}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isMoreFirstLoading= false;
    isMoreLoading = false;
    response = json.decode(req.body);
    var type = TruckLoadType.fromJson(response);
    allPostList = type.content;
    for (int i = 0; i < allPostList.length; i++) {
      if (allPostList[i].type == 'Full Load')
        myFullLoadTypeList.add(allPostList[i]);
      else if (allPostList[i].type == 'Part Load')
        myPartLoadTypeList.add(allPostList[i]);
      else if (allPostList[i].type == 'Jobs')
        myJobList.add(myJobList[i]);
      else
        myBuyVehicleList.add(allPostList[i]);
    }
    notifyListeners();
  }

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

  getDiscussionList(String userName)async{
    discussionList.clear();
    APIHelper apiHelper=APIHelper();
    var result=await apiHelper.ApiGetData(AppConstants.GET_DISCUSSION+'/getByUserName?userName=${userName}');
    DiscussionData discussion = await DiscussionData.fromJson(result);
    discussionList.addAll(discussion.content!);
  }

  deleteJob(TruckLoad job) async {
    String myUrl = AppConstants.POST_JOB + '?id=${job.id}';
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    myJobList.remove(job);
    notifyListeners();
  }

  deleteFullLoad(TruckLoad truckLoad) async {
    String myUrl = AppConstants.BASE_URL + 'fullTruckLoad?id=${truckLoad.id}';
    print(myUrl);

    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    print(deleteResponse);
    truckLoad.type == 'Full Load'
        ? myFullLoadTypeList.remove(truckLoad)
        : myPartLoadTypeList.remove(truckLoad);
    notifyListeners();
  }

  deleteBuySell(TruckLoad truckLoad) async {
    String myUrl = AppConstants.POST_BUY_SELL + '?id=${truckLoad.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    myBuyVehicleList.remove(truckLoad);
    notifyListeners();
  }

  deleteMultipleBuySell() async {
    String myUrl = AppConstants.POST_BUY_SELL + '/deleteMultiple';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    // myBuyVehicleList.remove();
    notifyListeners();
  }

  deleteGallery(Gallery gallery) async {
    String myUrl = AppConstants.GALLERY + '?id=${gallery.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    myGalleryList.remove(gallery);
    notifyListeners();
  }

  deletePoolPurchase(PoolPurchase obj) async {
    String myUrl = AppConstants.BULK_DATA + '?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    myPoolPurchaseList.remove(obj);
    notifyListeners();
  }

  deleteFeedback(FeedBack obj) async {
    String myUrl = AppConstants.BASE_URL + 'Feedback?id=${obj.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    feedbackList.remove(obj);
    notifyListeners();
  }

  getPoolPurchaseList(String userName) async {
    myPoolPurchaseList.clear();
    String myUrl = AppConstants.BULK_DATA + '/byUserName?userName=${userName}';
    var req = await http.get(Uri.parse(myUrl));
    poolPurchaseResponse = json.decode(req.body);
    var type = PoolPurchaseModel.fromJson(poolPurchaseResponse);
    myPoolPurchaseList = type.content;
    notifyListeners();
  }

  getGalleryList(String id) async {
    myGalleryList.clear();
    String myUrl = AppConstants.GALLERY + '/byUserId?userId=${id}';
    var req = await http.get(Uri.parse(myUrl));
    galleryResponse = json.decode(req.body);
    var type = GalleryModel.fromJson(galleryResponse);
    myGalleryList = type.content;
    notifyListeners();
  }

  Future setFullLoadFlag(bool value) async {
    this.fullLoadFlag = value;
    this.notifyListeners();
  }

  Future setPartLoadFlag(bool value) async {
    this.partLoadFlag = value;
    this.notifyListeners();
  }

  Future setjobFlag(bool value) async {
    this.jobFlag = value;
    this.notifyListeners();
  }

  Future setBuySellFlag(bool value) async {
    this.buySellFlag = value;
    this.notifyListeners();
  }

  Future setGalleryFlag(bool value) async {
    this.galleryFlag = value;
    this.notifyListeners();
  }

  Future setPoolPurchaseFlag(bool value) async {
    this.poolPurchaseFlag = value;
    this.notifyListeners();
  }

  final now = new DateTime.now();

  saveFeedback({int? id,String? feedbackDetails,int? postId,int? userId,String? type,int? rating}) async {
    String date = DateFormat.yMMMMd('en_US').format(now);
    String myUrl = AppConstants.BASE_URL + 'Feedback';
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "date": "2022-06-29T09:35:24.342Z",
      "feedbackDetails": feedbackDetails,
      "id": id,
      "postId": postId,
      "ratings": rating,
      "type": type,
      "userId": userId
    };
    var body = json.encode(data);
    print("request : ${data}");
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("response : ${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);
    FeedBack dataObj = FeedBack.fromJson(jsonData);
    print(dataObj);
    feedbackList.add(dataObj);
    notifyListeners();
  }
  bool isFeedbackLoading = false, isFirstFeedbackLoading=false;
  bool isMoreLoading = false, isMoreFirstLoading=false;

  getAllFeedBackList({int currentPage = 0,int? userId}) async {
    isFeedbackLoading = true;
    notifyListeners();
    if(currentPage == 0){
      isFirstFeedbackLoading = true;
      feedbackList.clear();
      fullLoadFeedbackList.clear();
      partLoadFeedbackList.clear();
      galleryFeedbackList.clear();
      BuySellFeedbackList.clear();
    }
    String myUrl = AppConstants.BASE_URL +'Feedback?page=${currentPage}&size=10';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isFirstFeedbackLoading= false;
    isFeedbackLoading = false;
    if(req.statusCode == 200) {
      response = json.decode(req.body);
      var type = FeedbackModel.fromJson(response);
      feedbackList.addAll(type.content);
      for (int i = 0; i < feedbackList.length; i++) {
        if (feedbackList[i].type == 'Full Load')
          fullLoadFeedbackList.add(feedbackList[i]);
        else if (feedbackList[i].type == 'Part Load')
          partLoadFeedbackList.add(feedbackList[i]);
        else if (feedbackList[i].type == 'Gallery')
          galleryFeedbackList.add(feedbackList[i]);
        else
          BuySellFeedbackList.add(feedbackList[i]);
      }
      notifyListeners();
    }
  }



  String resFromDateCnt = "ReservationFrom";
  String TimeCnt = "Time";
  String resToDateCnt = "ReservationTo";
  String? _hour, _minute, _time;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime _date = DateTime.now();

  selectTime(BuildContext context, String timeString) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) selectedTime = picked;
    _hour = selectedTime.hour.toString();
    _minute = selectedTime.minute.toString();

    _hour = _hour!.length == 1 ? "0$_hour" : _hour;
    _minute = _minute!.length == 1 ? "0$_minute" : _minute;
    _time = _hour! + ' : ' + _minute!;

    if (picked?.periodOffset.toString() == '0') {
      TimeCnt = (_time).toString();
    } else if (picked?.periodOffset.toString() == '12') {
      TimeCnt = (_time).toString();
    }
    notifyListeners();
  }

  selectDate(BuildContext context, String controllerString) async {
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _date,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );

    if (_datePicker != null && _datePicker != _date) {
      DateTime? date;

      if (controllerString == 'From Date') {
        if (_datePicker.isBefore(DateTime.now())) {
          date = _datePicker;
          resFromDateCnt = DateFormat('dd/MM/yyyy').format(DateTime.now());
          resToDateCnt = DateFormat('dd/MM/yyyy')
              .format(DateTime.now().add(Duration(days: 1)));
        } else {
          date = _datePicker;
          resFromDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
          resToDateCnt = DateFormat('dd/MM/yyyy')
              .format(_datePicker.add(Duration(days: 1))); //resFromDateCnt;
        }
      } else if (controllerString == 'To Date') {
        if (_datePicker.isBefore(date!)) {
          resToDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
        } else {
          resToDateCnt = DateFormat('dd/MM/yyyy').format(_datePicker);
        }
      }
      notifyListeners();
    }
    return _datePicker;
  }
}
