import 'dart:convert';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/general_post_model.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/model/api_response.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/utils/constant.dart';

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
        generalPost.typeName = listData[i]['typeName'];

        generalPost.description = listData[i]['description'];
        generalPost.likes = listData[i]['likes'];

        generalPost.comment = listData[i]['comment'];
        generalPost.typeName = listData[i]['typeName'];

        generalPost.userId = listData[i]['userId'];
        generalPost.id = listData[i]['id'];
        generalPostList.add(generalPost);
      }
      print(listData.length);
      selectedPage++;
      notifyListeners();
    } else {
    }
  }

  final orgProvider = locator<OrgProvider>();
  int orgId = 0;
  getOrgId()async{
    orgId = (await orgProvider.getCompanyOrgId())!;
  }

  pagenation(){
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getAllPost(orgId);

      }
    });
  }

}