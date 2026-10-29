import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:http/http.dart' as http;

import '../../../locator.dart';
import '../../../model/acceptBidResponse.dart';
import '../../../model/my_bids.dart';
import '../../../model/response/comman_response.dart';
import '../../../network/api_helper.dart';
import '../../../pages/widget/toast.dart';
import '../../model/discussion_model.dart';
import '../../model/feedback_model.dart';
import '../../model/gallary_model.dart';
import '../../model/my_job_list.dart';
import '../../model/pool_purchase_model.dart';
import '../../model/truck_load_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/buy_sell_provider.dart';
import '../../util/app_constants.dart';

class MoreProvider extends ChangeNotifier {
  // Post lists
  List<TruckLoad> allPostList = [];
  List<TruckLoad> myFullLoadTypeList = [];
  List<TruckLoad> myPartLoadTypeList = [];
  List<TruckLoad> myOwnPostList = [];
  List<TruckLoad> myBuyVehicleList = [];
  List<MyJobData> myJobList = [];
  List<PoolPurchase> myPoolPurchaseList = [];
  List<Gallery> myGalleryList = [];
  List<FeedBack> feedbackList = [];
  List<FeedBack> fullLoadFeedbackList = [];
  List<FeedBack> partLoadFeedbackList = [];
  List<FeedBack> galleryFeedbackList = [];
  List<FeedBack> BuySellFeedbackList = [];
  List<DiscussionContent> discussionList = [];

  // API responses
  var response,
      fullLoadResponse,
      partLoadResponse,
      jobResponse,
      candidateResponse,
      buyResponse,
      sellResponse,
      poolPurchaseResponse,
      galleryResponse;

  // Flags
  bool jobFlag = false,
      fullLoadFlag = false,
      buySellFlag = false,
      poolPurchaseFlag = false,
      partLoadFlag = false,
      galleryFlag = false;

  // Providers
  final BuySellProvider buySellProvider = locator<BuySellProvider>();
  final AuthProvider authProvider = locator<AuthProvider>();

  // Loading states
  bool isFeedbackLoading = false, isFirstFeedbackLoading = false;
  bool isMoreLoading = false, isMoreFirstLoading = false;

  // Bidding lists
  List<BidingDetails> receivedBidingList = [];
  List<PostBidData> ownBidPostList = [];

  /// Fetch user's own posts with proper pagination + filtering
  Future<void> getOwnPostList(int userId, {int currentPage = 0}) async {
    try {
      if (isMoreLoading) return; // 🚀 Prevent duplicate API calls

      isMoreLoading = true;
      notifyListeners();

      if (currentPage == 0) {
        isMoreFirstLoading = true;
        allPostList.clear();
        myFullLoadTypeList.clear();
        myPartLoadTypeList.clear();
        myBuyVehicleList.clear();
      }

      final myUrl =
          '${AppConstants.GET_OWNPOST}?userId=$userId&page=$currentPage&size=10';

      print("OwnPost:: $myUrl");

      final req = await http.get(Uri.parse(myUrl));
      print("OwnPost Response::::: ${req.body}");

      if (req.statusCode == 200 && req.body.isNotEmpty) {
        response = json.decode(req.body);
        final TruckLoadType type = TruckLoadType.fromJson(response);

        final List<TruckLoad> newData = type.content ?? [];

        if (newData.isEmpty) return;

        /// 🔁 Append instead of replacing (Pagination Fix)
        allPostList.addAll(newData);

        /// ⚡ Efficient filtered list append
        for (final e in newData) {
          if (e.type == 'Full Load') {
            myFullLoadTypeList.add(e);
          } else if (e.type == 'Part Load') {
            myFullLoadTypeList.add(e);
          } else if (e.type == 'Jobs') {
            myOwnPostList.add(e);
          }else{
            myBuyVehicleList.add(e);
          }
        }
      } else {
        print("OwnPost Error: ${req.statusCode} ${req.reasonPhrase}");
      }
    } catch (e, stack) {
      print("OwnPost Exception: $e");
      print(stack);
    } finally {
      isMoreLoading = false;
      isMoreFirstLoading = false;
      notifyListeners();
    }
  }


  Future<List<BidingDetails>> getOwnLoadPostWithBidingList(int userId,
      {required int currentPage}) async {
    if (isMoreLoading) return receivedBidingList;

    isMoreLoading = true;
    notifyListeners();

    try {
      final myUrl =
          '${AppConstants.BASE_URL}getOwnPostAndBid?userId=$userId&page=$currentPage&size=10';
      print(myUrl);
      final req = await http.get(Uri.parse(myUrl));
      response = json.decode(req.body);

      final type = MyPostBids.fromJson(response);

      if (currentPage == 1) {
        ownBidPostList = type.content ?? [];
      } else {
        ownBidPostList.addAll(type.content ?? []);
      }

      receivedBidingList = ownBidPostList.isNotEmpty
          ? (ownBidPostList[0].bidings ?? [])
          : [];

      return receivedBidingList;
    } catch (e, stack) {
      print("getOwnLoadPostWithBidingList Exception: $e");
      print(stack);
      return [];
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }


  /// Fetch own jobs
  Future<void> getOwnJobList(String userName, {int currentPage = 0}) async {
    try {
      isMoreLoading = true;
      if (currentPage == 0) myJobList.clear();
      notifyListeners();

      final url =
          '${AppConstants.BASE_URL}getPostJobsByUserId/${authProvider.userDetailList[0].id}';
      print("URL: $url");

      final apiResponse = await ApiHelper().apiGet(url);
      if (apiResponse.status == 200) {
        final jobList = MyJobList.fromJson(jsonDecode(apiResponse.response));
        myJobList.addAll(jobList.data ?? []);
        print('Job list length: ${myJobList.length}');
      }
    } catch (e, stack) {
      print("getOwnJobList Exception: $e");
      print(stack);
    } finally {
      isMoreLoading = false;
      notifyListeners();
    }
  }

  /// Repost a post
  Future<bool?> reSendPost(BuildContext context, TruckLoad postBidData) async {
    try {
      final myUrl =
          '${AppConstants.BASE_URL}repost?id=${postBidData.id!}&interchange=false';
      print(myUrl);

      final apiResponse = await http.post(Uri.parse(myUrl));

      if (apiResponse.statusCode == 200) {
        final jsonData = jsonDecode(apiResponse.body);
        final commonResponse = CommonResponse.fromJson(jsonData);

        if (commonResponse.isSuccess == true) {
          await getOwnPostList(authProvider.userDetailList[0].id!,
              currentPage: 0);
          showSimpleNotification(
            Text("Re-post submitted successfully!",
                style: TextStyle(color: Colors.white)),
            background: Colors.black,
          );
        } else {
          showSimpleNotification(
            Text(commonResponse.message.toString(),
                style: TextStyle(color: Colors.white)),
            background: Colors.orange,
          );
        }
        return commonResponse.isSuccess;
      } else if (apiResponse.statusCode == 402) {
        showSimpleNotification(
          Text("Please update your package",
              style: TextStyle(color: Colors.white)),
          background: Colors.orange,
        );
        return false;
      } else {
        showSimpleNotification(
          Text("Please Try Again!", style: TextStyle(color: Colors.white)),
          background: Colors.red,
        );
        return false;
      }
    } catch (e, stack) {
      print("reSendPost Exception: $e");
      print(stack);
      return false;
    }
  }

  /// Accept bid form
  Future<void> acceptBidSaveForm(
      BuildContext context,
      PostBidData data,
      BidingDetails bidings,
      String driverNumber,
      String vehicleNumber,
      int userId) async {
    try {
      final mapData = {
        "amount": bidings.bidings!.amount,
        "bidId": bidings.bidings!.id,
        "bidderUserId": 0,
        "bidderUserName": bidings.bidings!.bidderUserName,
        "destinationLocation": data.genericCardsDto!.destination,
        "driverContact": driverNumber,
        "id": 0,
        "isUpdatedDriverDetails": 0,
        "loggedTime": "",
        "postId": data.genericCardsDto!.id,
        "sourceLocation": data.genericCardsDto!.source,
        "userId": authProvider.userDetailList[0].id,
        "vehicleNumber": vehicleNumber
      };

      final apiResponse = await ApiHelper()
          .ApiAddPostDataMapRequest(AppConstants.ACCEPTBID, mapData);

      if (apiResponse.statusCode == 200) {
        final acceptBidResponse = AcceptBidResponse.fromJson(apiResponse.body);
        ToastMessage.show(context, acceptBidResponse.message.toString());
        await getOwnLoadPostWithBidingList(userId, currentPage: 0);
        Navigator.of(context).pop();
      } else {
        ToastMessage.show(context, "Please Try Again");
      }
    } catch (e, stack) {
      print("acceptBidSaveForm Exception: $e");
      print(stack);
      ToastMessage.show(context, "Error Occurred");
    } finally {
      notifyListeners();
    }
  }

  deleteBuySell(int id, int index) async {
    String myUrl = AppConstants.POST_BUY_SELL + '?id=${id}';
    var req = await http.delete(Uri.parse(myUrl));
    json.decode(req.body);
    notifyListeners();
    myBuyVehicleList.removeAt(index);
    buySellProvider.notifyListeners();
  }

  deleteMultipleBuySell() async {
    String myUrl = AppConstants.POST_BUY_SELL + '/deleteMultiple';
    var req = await http.delete(Uri.parse(myUrl));
    json.decode(req.body);
    notifyListeners();
  }

  deleteGallery(Gallery gallery) async {
    String myUrl = AppConstants.GALLERY + '?id=${gallery.id}';
    var req = await http.delete(Uri.parse(myUrl));
    json.decode(req.body);
    myGalleryList.remove(gallery);
    notifyListeners();
  }

  getDiscussionList(String userName) async {
    discussionList.clear();
    ApiHelper apiHelper = ApiHelper();
    var result = await apiHelper.apiGet(
        AppConstants.GET_DISCUSSION + '/getByUserName?userName=${userName}');
    DiscussionData discussion = await DiscussionData.fromJson(result.response);
    discussionList.addAll(discussion.content!);
  }

  deleteJob(MyJobData job) async {
    String myUrl = AppConstants.POST_JOB + '?id=${job.postJob!.id}';
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    myJobList.remove(job);
    notifyListeners();
  }

  deleteFullLoad(int id, int index) async {
    TruckLoad truckLoad = await getRequirementDetails(id);
    String myUrl = AppConstants.BASE_URL + 'fullTruckLoad?id=${id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    truckLoad.type == 'Full Load'
        ? myFullLoadTypeList.removeAt(index)
        : myPartLoadTypeList.removeAt(index);
    await getOwnPostList(authProvider.userDetailList[0].id!);
    print("delete response: " + deleteResponse);
    notifyListeners();
  }

  TruckLoad? truckLoad;

  getRequirementDetails(int id) async {
    String myUrl = AppConstants.BASE_URL + 'fullTruckLoad/${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var list = TruckLoadType.fromJson(response);
    truckLoad = list.content![0];
    notifyListeners();
    return truckLoad;
  }

  interChnageSendPost(BuildContext context, TruckLoad postBidData) async {
    var apiResponse = await http.post(Uri.parse(AppConstants.BASE_URL +
        "repost?id=${postBidData.id!}&interchange=${true}"));
    if (apiResponse.statusCode == 200) {
      getOwnPostList(authProvider.userDetailList[0].id!, currentPage: 0);
      showSimpleNotification(
          Text(
            "Intercity post submitted successfully!",
            style: TextStyle(color: Colors.white),
          ),
          background: Colors.black);
    } else {
      showSimpleNotification(
          Text(
            "Please try again",
            style: TextStyle(color: Colors.white),
          ),
          background: Colors.black);
    }
    notifyListeners();
  }

  saveFeedback(
      {int? id,
      String? feedbackDetails,
      int? postId,
      int? userId,
      String? type,
      int? rating}) async {
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
    print("response : ${response.statusCode}" +
        " --- " +
        response.body.toString());
    var jsonData = jsonDecode(response.body);
    FeedBack dataObj = FeedBack.fromJson(jsonData);
    print(dataObj);
    feedbackList.add(dataObj);
    notifyListeners();
  }
}
