import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/organization/org_quote_model.dart';
import '../../util/app_constants.dart';

class CompanyBidProvider extends ChangeNotifier {
  List<QuoteWithPostDetailList> orgBigingList = [];
  List<QuoteWithPostDetailList> placedBigingList = [];
  List<QuoteWithPostDetailList> receivedBigingList = [];

  Map<int, List<QuoteWithPostDetailList>> _placedCache = {};
  Map<int, List<QuoteWithPostDetailList>> _receivedCache = {};

  bool isLoading = false;
  bool isPaginating = false;

  int placedQuoteCount = 0;
  int receivedQuoteCount = 0;

  String selectedQuoteTab = "Received Quotes";

  /// =======================
  /// Get Placed Quote List
  /// =======================
  Future<void> getPlacedQuoteList(int id, {required int currentPage}) async {
    // Check cache first
    if (_placedCache.containsKey(currentPage)) {
      if (currentPage == 0) {
        placedBigingList = _placedCache[currentPage]!;
        orgBigingList = List.from(placedBigingList);
      } else {
        placedBigingList.addAll(_placedCache[currentPage]!);
        orgBigingList = List.from(placedBigingList);
      }
      notifyListeners();
      return;
    }

    // Loading state
    if (currentPage == 0) {
      orgBigingList.clear();
      placedBigingList.clear();
      placedQuoteCount = 0;
      isLoading = true;
      notifyListeners();
    } else {
      if (isPaginating) return; // prevent double call
      isPaginating = true;
      notifyListeners();
    }

    final url = "${AppConstants.get_Placed_QuoteList}$id&page=$currentPage&size=10&latestPost=yes";
    debugPrint("Get Placed Quote Data by OrgId - $url");

    final req = await http.get(Uri.parse(url));
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      final orgQuoteModel = OrgQuoteModel.fromJson(response);
      final newData = orgQuoteModel.content ?? [];

      // Cache page
      _placedCache[currentPage] = newData;

      if (currentPage == 0) {
        placedBigingList = newData;
        placedQuoteCount = orgQuoteModel.totalElements ?? newData.length;
      } else {
        placedBigingList.addAll(newData);
        placedQuoteCount = orgQuoteModel.totalElements ?? placedQuoteCount + newData.length;
      }

      orgBigingList = List.from(placedBigingList);
    }

    isLoading = false;
    isPaginating = false;
    notifyListeners();
  }

  /// =======================
  /// Get Received Quote List
  /// =======================
  Future<void> getReceivedQuoteList(int id, {required int currentPage}) async {
    // Check cache first
    if (_receivedCache.containsKey(currentPage)) {
      if (currentPage == 0) {
        receivedBigingList = _receivedCache[currentPage]!;
        orgBigingList = List.from(receivedBigingList);
      } else {
        receivedBigingList.addAll(_receivedCache[currentPage]!);
        orgBigingList = List.from(receivedBigingList);
      }
      notifyListeners();
      return;
    }

    if (currentPage == 0) {
      orgBigingList.clear();
      receivedBigingList.clear();
      receivedQuoteCount = 0;
      isLoading = true;
      notifyListeners();
    } else {
      if (isPaginating) return;
      isPaginating = true;
      notifyListeners();
    }

    final url = "${AppConstants.get_Received_QuoteList}$id&page=$currentPage&size=10&latestPost=yes";
    debugPrint("Get Received Quote Data by OrgId - $url");

    final req = await http.get(Uri.parse(url));
    if (req.statusCode == 200) {
      final response = json.decode(req.body);
      final orgQuoteModel = OrgQuoteModel.fromJson(response);
      final newData = orgQuoteModel.content ?? [];

      _receivedCache[currentPage] = newData;

      if (currentPage == 0) {
        receivedBigingList = newData;
        receivedQuoteCount = orgQuoteModel.totalElements ?? newData.length;
      } else {
        receivedBigingList.addAll(newData);
        receivedQuoteCount = orgQuoteModel.totalElements ?? receivedQuoteCount + newData.length;
      }

      orgBigingList = List.from(receivedBigingList);
    }

    isLoading = false;
    isPaginating = false;
    notifyListeners();
  }

  /// =======================
  /// Clear cache when filter changes
  /// =======================
  void clearCache() {
    _placedCache.clear();
    _receivedCache.clear();
  }

  /// =======================
  /// Sorting
  /// =======================
  void sortBids(int type) {
    List<QuoteWithPostDetailList> targetList = selectedQuoteTab == "Placed Quotes"
        ? placedBigingList
        : receivedBigingList;

    if (type == 0) {
      targetList.sort((a, b) => a.genericCardsDto!.companyName!.compareTo(b.genericCardsDto!.companyName!));
    } else if (type == 1) {
      targetList.sort((b, a) => a.genericCardsDto!.companyName!.compareTo(b.genericCardsDto!.companyName!));
    }

    orgBigingList = List.from(targetList);
    notifyListeners();
  }

  /// =======================
  /// Get Quote List by Date (only for placed)
  /// =======================
  Future<void> getPlacedQuoteListByDate(
      String fromDate, String toDate, int id) async {
    if (isLoading) return; // Prevent duplicate calls
    isLoading = true;
    notifyListeners();

    try {
      final url =
          "${AppConstants.get_Placed_QuoteList_ByDate}$id&latestPost=yes&startDate=$fromDate&endDate=$toDate";
      debugPrint("Get Placed Quote Data by Date - $url");

      final req = await http.get(Uri.parse(url));

      if (req.statusCode == 200) {
        final response = json.decode(req.body);
        final orgQuoteModel = OrgQuoteModel.fromJson(response);

        placedBigingList = orgQuoteModel.content ?? [];
        placedQuoteCount =
            orgQuoteModel.totalElements ?? placedBigingList.length;

        // Only update orgBigingList after fetching
        orgBigingList = List.from(placedBigingList);
      } else {
        debugPrint("Error fetching placed quotes by date: ${req.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception in getPlacedQuoteListByDate: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// =======================
  /// Get Quote List by Date (only for received)
  /// =======================
  Future<void> getRecievedQuoteListByDate(
      String fromDate, String toDate, int id) async {
    if (isLoading) return; // Prevent duplicate calls
    isLoading = true;
    notifyListeners();

    try {
      final url =
          "${AppConstants.get_Received_QuoteList_ByDate}$id&latestPost=yes&startDate=$fromDate&endDate=$toDate";
      debugPrint("Get Received Quote by Date - $url");

      final req = await http.get(Uri.parse(url));

      if (req.statusCode == 200) {
        final response = json.decode(req.body);
        final orgQuoteModel = OrgQuoteModel.fromJson(response);

        receivedBigingList = orgQuoteModel.content ?? [];
        receivedQuoteCount =
            orgQuoteModel.totalElements ?? receivedBigingList.length;

        orgBigingList = List.from(receivedBigingList);
      } else {
        debugPrint("Error fetching received quotes by date: ${req.statusCode}");
      }
    } catch (e) {
      debugPrint("Exception in getRecievedQuoteListByDate: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
