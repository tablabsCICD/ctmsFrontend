import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/model/lead_model.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';

import '../../model/response/lead_list.dart';
import '../../utils/constant.dart';
import '../base_provider.dart';

class LeadProvider extends BaseProvider{

  List<LeadData>emData=[];
  LeadProvider(String appState) : super(appState);

  Future<void> ApiGetData(BuildContext context,String URL) async{
    appState=Constants.stateBusy;
    notifyListeners();
    final dio = Dio();
    final response = await dio.get(ApiConstant.GET_ALL_LEAD+"?organisationId=${1}");
    print(response.data);
    if(response.statusCode==200){
      LeadListResponse employeeList =LeadListResponse.fromJson(jsonDecode(response.data));
      emData.addAll(employeeList.data! as Iterable<LeadData>);
    }else{
     // ToastMessage.show(context,"Please Try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    appState=Constants.stateIdeal;
  }


 /* Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }*/




}