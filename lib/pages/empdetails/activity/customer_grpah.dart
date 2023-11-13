import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerGrpah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: [
        Text("Performance",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
        SizedBox(height: 30,),
        pieChart(),

        ]
    ),
    );
  }


  List<PieChartSectionData> pieChartSectionData = [
    PieChartSectionData(
      value: 86,
      title: '86',
      color: Color(0xff46e8fd),
    ),
    PieChartSectionData(
      value: 44,
      title: '44',
      color: Color(0xff2dee20),
    ),
    PieChartSectionData(
      value: 12,
      title: '12',
      color: Color(0xffee2e2e),
    ),
    PieChartSectionData(
      value: 30,
      title: '30',
      color: Color(0xfffdb01f),
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
  barChart(){

    return Container(
      height: 200,
      width: 500,
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
              BarChartRodData(toY: 10, width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 9, width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 4, width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: 2, width: 15, color: Colors.amber),
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(toY: 13, width: 15, color: Colors.amber),
            ]),

          ])),
    );

  }

}