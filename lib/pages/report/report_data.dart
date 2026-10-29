import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/report_list.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../dashboard/widget/header_widget.dart';
import 'dart:math';

class ReportDataScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  ReportDataScreen(this.scaffoldKey);

  @override
  State<StatefulWidget> createState() {
    return _ReportDataScreen();
  }
}

class _ReportDataScreen extends State<ReportDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginDetail();
    GetReportData();
  }

  LoginDeatils? loginDeatils;
  Future<void> getLoginDetail() async {
    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
  }
  String selectedYear = '2024';
  var items = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              scaffoldKey: widget.scaffoldKey,
              isSearchVisible: false,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lead Management Report",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.sp),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Text(
                          "Select Year : ",
                          style: TextStyle(
                            color: Color(0xff1B1B1B),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                     SizedBox(
                        height: 52.h,
                        width: 150.w,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButton(
                            value: selectedYear,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            borderRadius: BorderRadius.circular(5.0),
                            underline: SizedBox.shrink(),
                            hint: Text(
                              "Year",
                              style: TextStyle(
                                color: Color(0xff1B1B1B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                    color: Color(0xff1B1B1B),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue!;
                              });
                              GetReportData();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            leadChart(),
            SizedBox(
              height: 20,
            ),
            AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Employee Report",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            empBarChart(),
                          ],
                        ),
                      ),
                      /*Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Customer Report",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            pieChart(),
                          ],
                        ),
                      )*/
                    ],
                  )
                : Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Employee Report",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          empBarChart(),
                        ],
                      ),
                      /*Column(
                        children: [
                          Text(
                            "Customer Report",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          pieChart(),
                        ],
                      )*/
                    ],
                  ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  empBarChart() {
    return Container(
      height: 200.h,
      width: 500.w,
      child: BarChart(BarChartData(
          borderData: FlBorderData(
              border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          )),
          groupsSpace: 10,
          barGroups: empBarChartList)),
    );
  }

  List<PieChartSectionData> pieChartSectionData = [
    PieChartSectionData(
      value: 20,
      title: '20%',
      color: Color(0xffee2e2e),
    ),
    PieChartSectionData(
      value: 35,
      title: '35%',
      color: Color(0xff007fff),
    ),
    PieChartSectionData(
      value: 15,
      title: '15%',
      color: Color(0xff1f1f1f),
    ),
    PieChartSectionData(
      value: 30,
      title: '30%',
      color: Color(0xffa2663e),
    ),
  ];

  pieChart() {
    return Container(
      height: 200.h,
      width: 500.w,
      child: PieChart(PieChartData(sections: pieChartSectionData)),
    );
  }


  leadChart() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: BarChart(BarChartData(
          borderData: FlBorderData(
              border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              )),
          groupsSpace: 10,
          barGroups: leadBarChartList)),
    );
  }

  ReportData? reportData;
  List<CustomerReport> customerList = [];
  List<EmployeeReport> EmployeeList = [];
  List<Lead> LeadList = [];
  List<BarChartGroupData> empBarChartList = [];
  List<BarChartGroupData> customerBarChartList = [];
  List<BarChartGroupData> leadBarChartList = [];

  Future<void> GetReportData() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    print("Get All Reports :" + ApiConstant.GET_ALL_REPORT + "?Year=${selectedYear}&organisationId=${loginDeatils!.data!.organisationId}");
    final dio = Dio();
    final response = await dio.get(ApiConstant.GET_ALL_REPORT + "?Year=${selectedYear}&organisationId=${loginDeatils!.data!.organisationId}",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      ReportModel reportModel = ReportModel.fromJson(jsonDecode(response.data));
      reportData = reportModel.data;
      customerList.clear();
      LeadList.clear();
      EmployeeList.clear();
      empBarChartList.clear();
      leadBarChartList.clear();
      customerList.addAll(reportData!.customer!);
      EmployeeList.addAll(reportData!.employee!);
      LeadList.addAll(reportData!.lead!);
      EmployeeList.forEach((element) {
        empBarChartList.add(
          BarChartGroupData(x: element.month!, barRods: [
            BarChartRodData(
                toY: double.parse('${element.count!}'),
                width: 15,
                color: Colors.amber),
          ]),
        );
      });

      LeadList.forEach((element) {
        leadBarChartList.add(
          BarChartGroupData(x: element.month!, barRods: [
            BarChartRodData(
                toY: double.parse('${element.count!}'),
                width: 15,
                color: Colors.amber),
          ]),
        );
      });
      print('this is the report data list${reportData!.customer!.length}');
      setState(() {});
    }
  }
}
