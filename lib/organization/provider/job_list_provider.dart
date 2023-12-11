import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/model/organization/job_applicant_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_management/model/api_response.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/utils/constant.dart';

class JobListProvider extends ChangeNotifier {
  int selectedPage = 0;

  ScrollController scrollController = ScrollController();
  List<JobData> listJobs = [];

  JobListProvider() : super() {
    getAllJobs(1);
    pagenation();
  }

  getAllJobs(int id) async {
    //ApiResponse apiResponse=await ApiHelper().apiWithoutDecodeGet(ApiConstant.BASE_URL+'postJob?page=$selectedPage');
   // String myUrl = 'http://ec2-13-234-76-107.ap-south-1.compute.amazonaws.com:8080/tkdConnect1/api/postJob';
   String myUrl = AppConstants.BASE_URL +'GetPostJobBycompanyId?company_id=${id}';
    print("Get All Jobs : " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    var response = json.decode(req.body);
    print(response);
    if (response != null) {
      JobList jobList = JobList.fromJson(response);
      listJobs.addAll(jobList.content as Iterable<JobData>);
      print(listJobs.length);
      selectedPage++;
      notifyListeners();
    } else {}
  }

  List<ApplicantList> jobApplicantList = [];
  getAllJobApplicantsByJobId(int jobId) async {
    EasyLoading.show(status: "Loading");
    String myUrl = AppConstants.BASE_URL +'getApplicantsByJobId?jobId=${jobId}&page=0&size=10&latest=yes';
    print("Get All Job Applicants : " + myUrl);
    var req = await http.get(Uri.parse(myUrl));
    var response = json.decode(req.body);
    print(response);
    jobApplicantList.clear();
    EasyLoading.dismiss();

      if(response['success']==false){
        jobApplicantList = [];
      }else{
        JobApplicantsModel jobApplicantsModel = JobApplicantsModel.fromJson(response);
        debugPrint(jobApplicantsModel.data!.noOfApplicants.toString());
        jobApplicantList.addAll(jobApplicantsModel.data!.applicantList! as Iterable<ApplicantList>);
        print(jobApplicantList.length);
        selectedPage++;
      }
      notifyListeners();

  }

  deleteJob(JobData jobData) async {
    String myUrl = AppConstants.BASE_URL + '/postJob?id=${jobData.postJob!.id}';
    print(myUrl);
    var req = await http.delete(Uri.parse(myUrl));
    var response = json.decode(req.body);
    print(response);
    listJobs.remove(jobData);
    notifyListeners();
  }

  pagenation() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getAllJobs(1);
      }
    });
  }

  createJob(
      String? companyName,
      String? contactNumber,
      String? emailId,
      String? jobLocation,
      int? privatePost,
      String? salary,
      String? removedDate,
      String? username,
      String? message,
      String? mainTag,
      String? jobType,
      String? jobDescription,
      String? jobDepartment,
      int? isSelected,
      int? isSalaryNegotiable,
      String? experience) async {
    String myUrl = AppConstants.BASE_URL + "/postJob";
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "companyName": companyName,
      "contactNumber": contactNumber,
      "emailId": emailId,
      "experience": experience,
      "isSalaryNegotiable": isSalaryNegotiable,
      "isSelected": isSelected,
      "jobDepartment": jobDepartment,
      "jobDescription": jobDescription,
      "jobLocation": jobLocation,
      "jobType": jobType,
      "loggedTime": "2023-11-30T06:16:03.888Z",
      "loggedUserName": username,
      "mainTag": mainTag,
      "message": message,
      "os": '',
      "postingTime": "10",
      "privatePost": privatePost,
      "removedDate": removedDate,
      "salary": salary,
      "tableName": "Jobs",
      "topicName": "Jobs",
      "type": "Jobs"
    };
    var body = json.encode(data);
    print(body);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    if (createResponse.statusCode == 200) {
      var jsonData = jsonDecode(createResponse.body);
      JobData dataObj = JobData.fromJson(jsonData);
      listJobs.add(dataObj);
    }
    notifyListeners();
    return createResponse.statusCode;
  }
}
