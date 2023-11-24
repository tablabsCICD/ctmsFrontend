import 'dart:convert';
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
    String myUrl = AppConstants.JOBS_ALL_CARD +'?type=Job&page=${selectedPage}';
    var req = await http.get(Uri.parse(myUrl));
    var  response = json.decode(req.body);

    if(response.status==200){
      JobList jobList=JobList.fromJson(response.response);
      if(selectedPage==0){
        listJobs.clear();
      }
      listJobs.addAll(jobList.content!);
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