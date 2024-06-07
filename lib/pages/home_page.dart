

import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_list.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../model/lead_model.dart';
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
    getLoginDetails();
    ApiGetAllLead('',0);
    ApiGetAllEmployee("", 0);
  }

  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      key: _key,
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
              child: Column(
                children: [
                  HeaderWidget(
                    isSearchVisible: true,
                    scaffoldKey: _key,
                  ),
                  Container(
                    margin: EdgeInsets.all(33),
                    child: Row(
                      children: [
                        Text(
                          'Lead Data',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 33.w, vertical: 20.h),
                    child: Row(
                      children: [
                        leadCountCard('Total Leads', '${leadData.length}', '', true,
                            Colors.green.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        leadCountCard('Converted', '${convertedLead.length}', '', false,
                            Colors.red.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        leadCountCard('Rejected', '${rejectedLead.length}', '', false,
                            Colors.orange.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        leadCountCard('Pending', '${pendingLead.length}', '', false,
                            Colors.blue.shade50),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(33),
                    child: Row(
                      children: [
                        Text(
                          'Employee Data',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 38.w,
                        ),
                        empCounts("${empData.length}", "Total Employees", Images.emp_tot,
                            Color(0xFFEAF8F4), true),
                        SizedBox(
                          width: 38.w,
                        ),
                        empCounts("${activeEmpData.length}", "Active Employees",
                            Images.emp_tot, Color(0xFFFFEDF9), false),
                        SizedBox(
                          width: 38.w,
                        ),
                        empCounts("${inActiveEmpData.length}", "Inactive Employees",
                            Images.emp_tot, Color(0xFFFEF0E5), false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  String selectedLeadType = "total";

  leadCountCard(
      String title,
      String count,
      String img,
      bool isSelected,
      Color bgColor,
      ) {
    return InkWell(
      onTap: () {
        if (title == "Pending") {
          finalLeadData.clear();
          finalLeadData.addAll(pendingLead);
          selectedLeadType = "pending";
        } else if (title == "Converted") {
          finalLeadData.clear();
          finalLeadData.addAll(convertedLead);
          selectedLeadType = "converted";
        } else if (title == "Rejected") {
          finalLeadData.clear();
          finalLeadData.addAll(rejectedLead);
          selectedLeadType = "rejected";
        } else {
          finalLeadData.clear();
          finalLeadData.addAll(leadData);
          selectedLeadType = "total";
        }
        setState(() {
          isSelected = true;
        });
      },
      child: Container(
        width: 243.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: isSelected ? Color(0xFFC3262C) : Color(0xFFC3262C)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 89.w,
              height: 89.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: CircleBorder(),
              ),
              child: SvgPicture.asset(
                Images.emp_tot,
                height: 50.h,
                width: 50.w,
              ),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                    title: count,
                    fontSize: 35.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600),
                TextView(
                    title: title,
                    fontSize: 16.sp,
                    color: Color(0xff6C6C6C),
                    fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }

  List<LeadData> leadData = [];
  List<LeadData> finalLeadData = [];
  List<LeadData> convertedLead = [];
  List<LeadData> rejectedLead = [];
  List<LeadData> pendingLead = [];


  Future<void> ApiGetAllLead(String URL, int pageNo) async {
    EasyLoading.show();
    setState(() {});
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl =  ApiConstant.GET_ALL_LEAD +
        "?organisationId=${loginDeatils!.data!.organisationId}&page=${pageNo}&size=10&sortBy=id&sortDir=asc";
    print("Get All Leads :" + myUrl );
    final dio = Dio();
    final response = await dio.get(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      LeadListResponse leadList =
      LeadListResponse.fromJson(jsonDecode(response.data));
      leadData.clear();
      finalLeadData.clear();
      convertedLead.clear();
      pendingLead.clear();
      rejectedLead.clear();
      leadData.addAll(leadList.data!.detailsWithPage! as Iterable<LeadData>);

      leadData.forEach((element) {
        if (element.status == null) element.status = "pending";
        finalLeadData.add(element);
        if (element.status!.toLowerCase() == "converted") {
          convertedLead.add(element);
        } else {
          if (element.status!.toLowerCase() == "pending") {
            pendingLead.add(element);
          } else if (element.status!.toLowerCase() == "rejected") {
            rejectedLead.add(element);
          }
        }
        setState(() {});
      });
      print('this is ${leadData.length}');

    }
  }


  List<EmployeeData> finalEmData = [];
  List<EmployeeData> empData = [];
  List<EmployeeData> activeEmpData = [];
  List<EmployeeData> inActiveEmpData = [];
  EmployeeListResponse? employeeListResponse;

  Future<void> ApiGetAllEmployee(String URL, int pNo) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
   EasyLoading.show();
    setState(() {});
    Dio dio = Dio();

    final response = await dio.get(
        ApiConstant.GET_ALL_EMPLOYEE + "?organisationId=${loginDeatils!.data!.organisationId}&page=${pNo}&size=10000",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      employeeListResponse =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      finalEmData.clear();
      activeEmpData.clear();
      inActiveEmpData.clear();

      finalEmData.addAll(employeeListResponse!.data!.content!);
      //print('this is ${emData.length}');
      empData.clear();
      empData.addAll(employeeListResponse!.data!.content!);
      empData.forEach((element) {
        if (element.isActive == 1) {
          activeEmpData.add(element);
        } else {
          inActiveEmpData.add(element);
        }
      });
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeListResponse!.data!.content!);
      EasyLoading.dismiss();
      setState(() {});
    }
  }

  String selectedEmpList = "Total";

  empCounts(String totCount, String name, String image, Color color,
      bool isSelected) {
    return InkWell(
      onTap: () {
        if (name == "Active Employee") {
          finalEmData.clear();
          finalEmData.addAll(activeEmpData);
          selectedEmpList = "Active";
        } else if (name == "Inactive Employee") {
          finalEmData.clear();
          finalEmData.addAll(inActiveEmpData);
          selectedEmpList = "InActive";
        } else {
          finalEmData.clear();
          finalEmData.addAll(empData);
          selectedEmpList = "Total";
        }
        setState(() {});
      },
      child: Container(
        width: 329.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFFC3262C)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 108.w,
                height: 110.h,
                decoration: ShapeDecoration(
                  color: color, //Color(0xFFEAF8F4)
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    image,
                    height: 10.h,
                    width: 10.w,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  totCount,
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff6C6C6C),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }


}
