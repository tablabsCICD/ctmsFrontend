import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization_portal/model/job_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';

class JobProvider extends ChangeNotifier{
  List<String> cityList = [];
  List<Job> jobList = [];
  List<Job> candidateList = [];
  var response;
int jobPages = 0;
  int totalpages = 0;
  bool isLoadingJob = false;
  bool isLoadingCandidate = false;

  getCard({int currentPage = 0}) async {
    isLoadingJob = true;
    notifyListeners();
    if(currentPage == 0){
      jobList.clear();
    }
    String myUrl = AppConstants.JOBS_ALL_CARD +'?type=Job&page=${currentPage}';
    var req = await http.get(Uri.parse(myUrl));
    isLoadingJob = false;
    response = json.decode(req.body);
    var res = JobModel.fromJson(response);
    jobList.addAll(res.content);
    jobPages = res.totalPages;
    notifyListeners();
   // return type;
  }

  getCandidates({int currentPage = 0}) async {
    isLoadingCandidate = true;
    notifyListeners();
    if(currentPage==0){
    candidateList.clear();
    }
    String myUrl = AppConstants.JOBS_ALL_CARD +'?type=Candidates&page=${currentPage}';
    var req = await http.get(Uri.parse(myUrl));
    isLoadingCandidate = false;
    response = json.decode(req.body);
    var res = JobModel.fromJson(response);
    candidateList.addAll(res.content);
    totalpages = res.totalPages;
    notifyListeners();
   // return type;
  }

  deleteJob(Job job) async {
    String myUrl = AppConstants.POST_JOB +'?id=${job.id}';
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    if(job.type=='Buy Vehicle'){
      jobList.remove(job);
    }
    else{
      candidateList.remove(job);
    }
    notifyListeners();
  }

  Future<List<String>> getCityList() async {
    String myUrl =
        AppConstants.GET_ALL_CITY;
    var req = await http.get(Uri.parse(myUrl));
    var response = jsonDecode(req.body);
     cityList = response;
    return cityList;
  }

  saveJabs({String? selectedPostType,String? ctc,String? salaryType,String? jobType,String? city,String? description,String? experience,String? msg,String? name,String? email,int? mobile,AuthProvider? model}) async {
    String myUrl = AppConstants.POST_JOB;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "companyName": model!.userDetailList[0].companyName,
      "contactNumber": mobile,
      "emailId": email,
      "experience": experience,
      "id": model.userDetailList[0].id,
      "isSalaryNegotiable": salaryType=='Yes' ? 1 : 0,
      "isSelected": 0,
      "jobDepartment": jobType,
      "jobDescription": description,
      "jobLocation": city,
      "jobType": jobType,
      "loggedTime":'',// DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()), //+" "+DateTime.now().hour.toString() +":" +DateTime.now().minute.toString() ,
      "loggedUserName": name,
      "mainTag": jobType,
      "message": msg,
      "os": "window",
      "postingTime": '',//DateTime.now(),// DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()), // +" "+DateTime.now().hour.toString() +":" +DateTime.now().minute.toString() ,
      "loggedUserName": name,
      "privatePost": 0,
      "removedDate": '' ,
      "salary": ctc,
      "tableName": " ",
      "topicName": " ",
      "type": selectedPostType
    };
    var body = json.encode(data);
    print(data);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);
    if(selectedPostType == 'Job Seeker'){
      Job dataObj = Job.fromJson(jsonData);
      jobList.add(dataObj);
    }
    else{
      Job dataObj = Job.fromJson(jsonData);
      candidateList.add(dataObj);
    }
    notifyListeners();
  }

}