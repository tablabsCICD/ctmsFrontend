import 'dart:convert';
import 'package:flutter_hr_management/organization/model/general_post_model.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
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

  getAllPost(int id)async{
    //ApiResponse apiResponse=await ApiHelper().apiWithoutDecodeGet(ApiConstant.BASE_URL+'postJob?page=$selectedPage');
    String myUrl = /*AppConstants.JOBS_ALL_CARD +*/'http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/tkdConnect1/api/GeneralPost/getAll';
    print("Get All General Post : "+myUrl);
    var req = await http.get(Uri.parse(myUrl));
    var  response = json.decode(req.body);
    print(response);
    if(response != null){
      GeneralPostModel _generalPostList=GeneralPostModel.fromJson(response);
      generalPostList.clear();
      generalPostList.addAll(_generalPostList.data!);
      print(generalPostList.length);
      selectedPage++;
      notifyListeners();
    }else{

    }
  }

  pagenation(){
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getAllPost(1);

      }
    });
  }

}