import 'dart:convert';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/model/api_response.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/utils/constant.dart';

class JobListProvider extends ChangeNotifier{

  int selectedPage=0;

  ScrollController scrollController=ScrollController();
  List<JobData>listJobs=[];
  JobListProvider():super(){
    getAllJobs();
    pagenation();
  }

  getAllJobs()async{
    //ApiResponse apiResponse=await ApiHelper().apiWithoutDecodeGet(ApiConstant.BASE_URL+'postJob?page=$selectedPage');
    String myUrl = /*AppConstants.JOBS_ALL_CARD +*/'http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/tkdConnect1/api/postJob';
    print("Get All Jobs : "+myUrl);
    var req = await http.get(Uri.parse(myUrl));
    var  response = json.decode(req.body);
    print(response);
    if(response != null){
      JobList jobList=JobList.fromJson(response);
      listJobs.addAll(jobList.content as Iterable<JobData>);
      print(listJobs.length);
      selectedPage++;
      notifyListeners();

    }else{

    }
  }

  pagenation(){
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getAllJobs();

      }
    });
  }

}