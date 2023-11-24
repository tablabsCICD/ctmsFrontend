

import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_list.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:provider/provider.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import 'dashboard/dashboard.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // ApiGetData("http://ec2-43-205-143-58.ap-south-1.compute.amazonaws.com:8080/crm/Employee/getAll");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),

      backgroundColor: ThemeColor.baground,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: LeadDashboard(),
            ),
          ],
        ),
      ),
    );
  }


  Future<int> ApiGetData(String URL) async{
    final dio = Dio();
    final response = await dio.get(ApiConstant.GET_ALL_EMPLOYEE);
     print(response.data);
    return response.statusCode!;
  }


}
