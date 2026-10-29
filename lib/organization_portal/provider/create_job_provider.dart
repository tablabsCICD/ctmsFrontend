import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/generated/l10n.dart';
import 'package:flutter_hr_management/model/api_response.dart';
import 'package:flutter_hr_management/network/api_helper.dart';

import 'package:flutter_hr_management/organization_portal/model/userdata.dart';

import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';

class CreateJobProvider extends ChangeNotifier{
 // CreateJobProvider(super.appState);

  TextEditingController positionController=TextEditingController();
  TextEditingController JobTitileController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController salController=TextEditingController();
  bool buttonActive=false;
  String expFrom=S().from;
  String expTo=S().to;
  bool expUpdate=false;








  buttonEnble(){
    if(positionController.text.isNotEmpty && descriptionController.text.isNotEmpty && JobTitileController.text.isNotEmpty && salController.text.isNotEmpty){
      if(expFrom==S().from && expTo==S().to){
        buttonActive=false;
      }else{
        buttonActive=true;
      }

    }else{
      buttonActive=false;
    }
    notifyListeners();
  }

  onSubitJobPost(BuildContext context)async{
    LocalSharePreferences localSharePreferences=LocalSharePreferences();
    User user=(await localSharePreferences.getLoginData()) as User;
    Map<String, dynamic> data = {
      "companyName": user.content!.first.companyName,
      "contactNumber":user.content!.first.mobileNumber,
      "emailId": user.content!.first.emailId,
      "experience": expTo+"-"+expFrom,
      "id": user.content!.first.id,
      "isSalaryNegotiable":  1 ,
      "isSelected": 0,
      "jobDepartment": JobTitileController.text,
      "jobDescription": descriptionController.text,
      "jobLocation": "city",
      "jobType": positionController.text,
      "loggedTime":'',// DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()), //+" "+DateTime.now().hour.toString() +":" +DateTime.now().minute.toString() ,
      "loggedUserName": user.content!.first.userName,
      "mainTag": "Job Seeker",
      "message": descriptionController.text,
      "os": "App",
      "postingTime": '',//DateTime.now(),// DateFormat("dd/MM/yyyy hh:mm").format(DateTime.now()), // +" "+DateTime.now().hour.toString() +":" +DateTime.now().minute.toString() ,
      "loggedUserName": user.content!.first.userName,
      "privatePost": 0,
      "removedDate": '' ,
      "salary": salController.text,
      "tableName": " ",
      "topicName": " ",
      "type": "Job Seeker"
    };

    ApiResponse apiResponse=await ApiHelper().postParameter(AppConstants.POST_JOB, data);
    if(apiResponse.status==200){
      ToastMessage.show(context, "Post job successfull");
      Navigator.pop(context,1);

    }else{
      ToastMessage.show(context, "Please try again");
    }


  }











}