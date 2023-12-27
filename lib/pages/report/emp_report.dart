

import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/pages/dashboard/dashboard.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

class EmployeeReport extends StatefulWidget {
  @override
  _EmployeeReportState createState() => _EmployeeReportState();
}

class _EmployeeReportState extends State<EmployeeReport> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ApiGetData("http://ec2-43-205-143-58.ap-south-1.compute.amazonaws.com:8080/crm/Employee/getAll");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: ThemeColor.baground,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppResponsive.isDesktop(context))
            Expanded(
                child: SideBar(),
            ),
            Expanded(
              flex: 4,
              child: Dashboard(_scaffoldKey),
            ),
          ],
        ),
      ),
    );
  }


}
