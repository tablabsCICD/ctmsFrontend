import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/organization/org_quote_model.dart';
import '../../util/app_constants.dart';

class CompanyBidProvider extends ChangeNotifier {

  List<QuoteWithPostDetailList> orgBigingList = [];
  List<QuoteWithPostDetailList> placedBigingList = [];
  List<QuoteWithPostDetailList> receivedBigingList = [];
  bool isLoading = false;
  int bidCont = 0;
  String selectedQuoteTab = "Placed Quotes";


  getReceivedQuoteList(int id) async {
    isLoading = true;
    String myUrl = AppConstants.get_Received_QuoteList+ "${id}&latestPost=yes";
    print("Get Received Quote Data by OrgId - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    receivedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);

      receivedBigingList.addAll(orgQuoteModel.content!);
      receivedBigingList.forEach((element) {
        if(element.bidingList!.length == 0 || element.bidingList==[]){

        }else{
          orgBigingList.addAll(receivedBigingList);
          bidCont = receivedBigingList.length;
        }
      });
      notifyListeners();
    }
  }

  getPlacedQuoteList(int id) async {
    isLoading = true;

    String myUrl = AppConstants.get_Placed_QuoteList+ "${id}&latestPost=yes";
    print("Get Placed Quote Data by OrgId - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    placedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);
      placedBigingList.addAll(orgQuoteModel.content!);
      orgBigingList.addAll(placedBigingList);
      print('Low to high in biding amount: $orgBigingList');
      bidCont = orgBigingList.length;
      orgBigingList.forEach((element) {
        debugPrint("total bids : ${element.bidingList!.length}");
      });
      notifyListeners();
    }
  }

  getPlacedQuoteListByDate(String fromDate,String toDate,int id) async {
    isLoading = true;

    String myUrl = AppConstants.get_Placed_QuoteList_ByDate+ "getBidderPostAndBidByCompanyIdWithDateFilter?companyId=${id}&latestPost=yes&startDate=${fromDate}&endDate=${toDate}";
    print("Get Placed Quote Data by Date - " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    orgBigingList.clear();
    placedBigingList.clear();
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      OrgQuoteModel orgQuoteModel = OrgQuoteModel.fromJson(response);
      placedBigingList.addAll(orgQuoteModel.content!);
      orgBigingList.addAll(placedBigingList);
      print('Low to high in biding amount: $orgBigingList');
      bidCont = orgBigingList.length;
      orgBigingList.forEach((element) {
        debugPrint("total bids : ${element.bidingList!.length}");
      });
      notifyListeners();
    }
  }

  getFinalQuoteList(String title, int? orgId) {
    selectedQuoteTab = title;
    orgBigingList.clear();
    if(selectedQuoteTab=="Placed Quotes"){
      getPlacedQuoteList(orgId!);
      orgBigingList.addAll(placedBigingList);
    }else if(selectedQuoteTab=="Received Quotes"){
      getReceivedQuoteList(orgId!);
      orgBigingList.addAll(receivedBigingList);
    }
    notifyListeners();
  }

  deleteBid(BidList bid) async {
    String myUrl = AppConstants.BID_TO_POST + '?id=${bid.bidings!.id}';
    print(myUrl);
    var req = await http.delete(Uri.parse(myUrl));
    var response = json.decode(req.body);
    print(response);
    orgBigingList.remove(bid);
    notifyListeners();
  }
}