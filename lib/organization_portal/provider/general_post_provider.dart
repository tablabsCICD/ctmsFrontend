import 'dart:convert';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/company/more/own_genral_post.dart';
import 'package:flutter_hr_management/organization_portal/model/general_post_model.dart';
import 'package:flutter_hr_management/organization_portal/model/job_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/model/api_response.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/utils/constant.dart';

import '../../utils/sharepreferences.dart';

class GeneralPostProvider extends ChangeNotifier{

  int selectedPage=0;

  ScrollController scrollController=ScrollController();
  List<GeneralPost>generalPostList=[];

  GeneralPostProvider() : super() {
    getOrgId();
    //getAllPost(orgId);
    pagenation();
  }

  getAllPost(int id)async {
    String myUrl = AppConstants.BASE_URL +
        '/GetGeneralPostBycompanyId?company_id=${id}';
    print("Get All General Post : " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    var response = json.decode(req.body);
    print(response);
    if (response != null) {
      List<dynamic>listData = List.from(response);
      generalPostList.clear();
      for (int i = 0; i < listData.length; i++) {
        GeneralPost generalPost = GeneralPost();
        generalPost.title = listData[i]['title'];
        generalPost.images = [];
        generalPost.description = listData[i]['description'];
        generalPost.likes = listData[i]['likes'];

        generalPost.comment = listData[i]['comment'];
        generalPost.typeName = listData[i]['typeName'];

        generalPost.userId = listData[i]['userId'];
        generalPost.id = listData[i]['id'];
        generalPostList.add(generalPost);
      }
      print(listData.length);
      notifyListeners();
    } else {
    }
  }

  final orgProvider = locator<OrgProvider>();
  int orgId = 0;
  getOrgId()async{
    orgId = int.parse(await  LocalSharePreferences().getString(SharedPreferencesConstant.connectOrganizationId));
  }

  pagenation(){
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getAllPost(orgId);

      }
    });
  }

  List<GernralPostOwnData> listOwnPost = [];
  bool isLoading = false;

  callGeneralPostApi({int currentPage = 0,int? userId}) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      listOwnPost.clear();
    }

    String url =
        "${ApiConstant.BASE_URL}getBuySellByUserId?userId=${userId}";
    print("the url ${url}");
    var apiResponse = await http.get(Uri.parse(url));
    print("the url ${apiResponse.body}");
    isLoading = false;
    if (apiResponse.statusCode == 200) {
      OwnGenralPostList ownGenralPostList =
      OwnGenralPostList.fromJson(jsonDecode(apiResponse.body));
      listOwnPost.addAll(ownGenralPostList.data!);
      print('the lenghth is ${listOwnPost.length}');
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  deleteGeneralPost(int id, int index, BuildContext context) async {
    String myUrl = ApiConstant.BASE_URL +
        'GeneralPost/deleteById?id=${listOwnPost[index].id!}';
    var apiResponse = await http.delete(Uri.parse(myUrl));
    if (apiResponse.statusCode == 200) {
      listOwnPost.removeAt(index);
    } else {}
    notifyListeners();
  }
}