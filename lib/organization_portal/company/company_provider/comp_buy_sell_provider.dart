import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../model/organization/org_buy_sell_model.dart';
import '../../util/app_constants.dart';
import 'package:http/http.dart' as http;


class CompBuySellProvider extends ChangeNotifier {
  List<OrgBuySellModel1> orgBuySellList = [];
  List<OrgBuySellModel1> orgBuyList = [];
  List<OrgBuySellModel1> orgSellList = [];
  List<OrgBuySellModel1> finalBuySellList = [];

  String selectedBuySellTab = "Buy Vehicle";
  int  buySellPostCount = 0;

  /// Get buy/sell posts by organization id
  Future<void> getBuyVehicles(int id) async {
    try {
      String myUrl = AppConstants.get_Buy_Sell_Vehicles + "${id}";
      selectedBuySellTab = "Buy Vehicle";
      print("Get BuySell Data By OrgId - $myUrl");
      final req = await http.get(Uri.parse(myUrl));
      final parsed = json.decode(req.body);
      debugPrint(parsed.toString());
      if (req.statusCode == 200) {
        orgBuySellList.clear();
        final buySellModel = BuySellModel.fromJson(parsed);
        orgBuySellList.addAll(buySellModel.data ?? []);
        orgBuyList.clear();
        orgSellList.clear();
        finalBuySellList.clear();
        buySellPostCount = orgBuySellList.length;
        for (var element in orgBuySellList) {
          final typeField = element.type ?? element.type ?? '';
          if (typeField.toLowerCase().contains("buy")) {
            orgBuyList.add(element);
          } else {
            orgSellList.add(element);
          }
        }
        // If selectedBuySellTab contains 'Buy' show buy list else show sell
        if (selectedBuySellTab.toLowerCase().contains("buy")) {
          finalBuySellList.addAll(orgBuyList);
        } else {
          finalBuySellList.addAll(orgSellList);
        }
      }
    } catch (e) {
      debugPrint("getBuyVehicles error: $e");
    } finally {
      notifyListeners();
    }
  }

  void getFinalBuySellList(String title) {
    selectedBuySellTab = title;
    finalBuySellList.clear();
    if (selectedBuySellTab == "Buy Vehicle") {
      finalBuySellList.addAll(orgBuyList);
    } else {
      finalBuySellList.addAll(orgSellList);
    }
    debugPrint("$selectedBuySellTab List ${finalBuySellList.length}");
    notifyListeners();
  }

  /// Delete buy/sell post
  Future<void> deleteBuySell(OrgBuySellModel truckLoad) async {
    try {
      String myUrl = AppConstants.POST_BUY_SELL + '?id=${truckLoad.id}';
      final req = await http.delete(Uri.parse(myUrl));
      final deleteResponse = json.decode(req.body);
      debugPrint(deleteResponse.toString());
      orgBuySellList.removeWhere((e) => e.id == truckLoad.id);
    } catch (e) {
      debugPrint("deleteBuySell error: $e");
    } finally {
      notifyListeners();
    }
  }

}