import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/model/response/report_list.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../dashboard/widget/header_widget.dart';
import 'dart:math';

class ReportDataScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ReportDataScreen();
  }

}
class _ReportDataScreen extends State<ReportDataScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetReportData();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),

            AppResponsive.isDesktop(context)||AppResponsive.isTablet(context)?Row(
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
                      Text("Employee Report",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                      SizedBox(height: 30,),
                      barChart(),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text("Customer Report",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                      SizedBox(height: 30,),
                      pieChart(),
                    ],
                  ),
                )

              ],
            ):Column(
              children: [
                Column(
                  children: [
                    Text("Employee Report",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
                    SizedBox(height: 30,),
                    barChart(),
                  ],
                ),

                Column(
                  children: [
                    Text("Customer Report",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20.sp),),
                    SizedBox(height: 30.h,),
                    pieChart(),
                  ],
                )

              ],
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w),
              child: Text("Lead Management Report",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.sp),),
            ),
            SizedBox(height: 20,),
            linerChart()

          ],
        ),
      ),
    );
  }

  barChart(){

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

          // add bars
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: double.parse("30.0"), width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: double.parse("22"), width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: double.parse("12"), width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: double.parse("5"), width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(toY: double.parse('45'), width: 15, color: Colors.amber),
            ]),

          ])),
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

  pieChart(){
     return Container(
       height: 200.h,
       width: 500.w,
       child: PieChart(PieChartData(
          sections: pieChartSectionData
    )),
     );
  }


  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });


  linerChart(){
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineChartBarData(
              spots: dummyData1,
              isCurved: true,
              barWidth: 3,
              color: Colors.indigo,
            ),
            // The orange line
            LineChartBarData(
      
              spots: dummyData2,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
            ),
            // The blue line
            LineChartBarData(
              spots: dummyData3,
              isCurved: false,
              barWidth: 3,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );

  }

  ReportData? reportData;
  Future<void> GetReportData() async {
    final dio = Dio();
    final response = await dio.get(ApiConstant.GET_ALL_REPORT);
    print(response.data);
    if (response.statusCode == 200) {
      ReportModel reportModel = ReportModel.fromJson(jsonDecode(response.data));
      reportData = reportModel.data;
      print('this is the report data list${reportData!.customer!.length}');
      setState(() {});
    }
  }

}