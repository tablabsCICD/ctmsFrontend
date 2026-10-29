import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/allNewsResponse.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../../../constant/SharedPreferencesConstant.dart';
import '../../../model/api_response.dart';
import '../../../network/api_helper.dart';
import '../../../pages/widget/toast.dart';
import '../../../utils/sharepreferences.dart';
import '../../model/auth_api.dart';

class NewsProvider extends ChangeNotifier {

  int allSelectedPage = 0;
  int selectedPage = 0;

  List<Content> allNewsTemp = [];
  List<Content> allNews = [];

  bool isLoadDone = false;
  bool _myNews = false;

  bool get myNews => _myNews;


  ScrollController scrollControllerVertical = ScrollController();
  ScrollController scrollControllerHorizantal = ScrollController();
  TextEditingController searchController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  List<String> images = [];


  getAllData(int orgId) async {
    String myUrl = AppConstants.GET_NEWS_LIST(orgId,'');

    print("Url $myUrl");
    ApiResponse apiResponse = await ApiHelper().apiGet(myUrl);

    if (apiResponse.status == 200) {
      TrackingResponse newsResponse =
      TrackingResponse.fromJson(apiResponse.response);

      if (allSelectedPage == 0) {
        allNews.clear();
        allNewsTemp.clear();
      }
      allNews.addAll(newsResponse.data!);
      allNewsTemp.addAll(newsResponse.data!);
     // allSelectedPage++;
    }
    isLoadDone = true;
    notifyListeners();
  }


  getBySearchData(Organization organization) async {
    String query = searchController.text.trim();

    if (query.length > 2) {
      String myUrl = AppConstants.GET_NEWS_LIST(organization.id, query);
      print("Search URL: $myUrl");

      ApiResponse apiResponse = await ApiHelper().apiGet(myUrl);

      if (apiResponse.status == 200) {
        TrackingResponse newsResponse =
        TrackingResponse.fromJson(apiResponse.response);

        allNews.clear(); // Clear current list before adding search results
        allNews.addAll(newsResponse.data ?? []);
      }
    } else {
      // When search box is empty or short, show all news again
      allNews.clear();
      allNews.addAll(allNewsTemp);
    }

    notifyListeners();
  }


  getMyNewsData(ConnectUser user) async {
      String myUrl = AppConstants.MY_NEWS(user.id,selectedPage);
      print(myUrl);
      ApiResponse apiResponse = await ApiHelper().apiGet(myUrl);
      if (apiResponse.status == 200) {
        TrackingResponse newsResponse =
        TrackingResponse.fromJson(apiResponse.response);
        if (selectedPage == 0) {
          allNews.clear();
        }
        allNews.addAll(newsResponse.data!);
        //selectedPage++;
      }
    notifyListeners();
  }



  bool enbleButton = false;

  enble() {
    if (topicController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      enbleButton = true;
    } else {
      enbleButton = false;
    }
    notifyListeners();
  }

  deletePost(Content content,BuildContext context, Organization organization)async{
    String myUrl = '${AppConstants.DELETE_NEWS(content.id)}';
    print(myUrl);
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var request = await http.delete(Uri.parse(myUrl),headers: { "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',});

    if(request.statusCode==200){
      ToastMessage.show(context, "Post deleted successfully");
      getAllData(organization.id!);
    }else{
      ToastMessage.show(context, "Please try again");
    }
  }


}
