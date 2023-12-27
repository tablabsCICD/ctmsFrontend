import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/lead_update_model.dart';
import 'package:flutter_hr_management/model/response/lead_assign.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:pie_chart/pie_chart.dart';

enum LegendShape { circle, rectangle }

class CustomerGrpah extends StatefulWidget {
  int id ;

  CustomerGrpah({Key? key, required this.id}) : super(key: key);

  @override
  State<CustomerGrpah> createState() => _CustomerGrpahState();
}

class _CustomerGrpahState extends State<CustomerGrpah> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetApi();
    initializeValue();
  }
  List<LeadAssign>listLeadActivityData=[];
  List<LeadAssign> totalLead = [];
  List<LeadAssign> convertedLead = [];
  List<LeadAssign> rejectedLead = [];
  List<LeadAssign> pendingLead = [];

  void callGetApi()async {
    try{
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      Dio dio=Dio();
      EasyLoading.show(status: "Loading");
      var response=await dio.get(ApiConstant.ASSIGN_PROJECT(widget.id),options: Options(headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      }));
      print('the lead is ${response.data}');
      if(response.statusCode==200){
        LeadAssignModel leadActivity =LeadAssignModel.fromJson(jsonDecode(response.data));
        listLeadActivityData.addAll(leadActivity.data!);
        totalLead.clear();
        pendingLead.clear();
        rejectedLead.clear();
        convertedLead.clear();

        listLeadActivityData.forEach((element) {
          if (element.status == null) element.status = "pending";
          totalLead.add(element);
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
        print('this is ${totalLead.length}');
        setState(() {

        });

      }else{
        // ToastMessage.show(context, "Refresh page");
      }

      EasyLoading.dismiss();
    }catch(e){
      EasyLoading.dismiss();
      print(e);
    }

  }




  final legendLabels = <String, String>{
    "Converted Leads": "Converted Leads",
    "Pending Leads": "Pending Leads",
    "Rejected Leads": "Rejected Leads",
    "Total Leads": "Total Leads",
    "No Leads": "No Leads"
  };

  final colorList = <Color>[
    const Color(0xff1ee30f),
    const Color(0xfffc9e10),
    const Color(0xfff5120b),
    const Color(0xff5581e1),
    Colors.grey,
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(17, 169, 7, 1.0),
      const Color.fromRGBO(40, 234, 12, 1.0),
    ],
    [
      const Color.fromRGBO(246, 152, 10, 1.0),
      const Color.fromRGBO(245, 171, 97, 1.0),
    ],
    [
      const Color.fromRGBO(246, 12, 10, 1.0),
      const Color.fromRGBO(161, 29, 5, 1.0),
    ],
    [
      const Color.fromRGBO(21, 107, 236, 1.0),
      const Color.fromRGBO(45, 166, 241, 1.0),
    ],

  ];

  ChartType? _chartType = ChartType.disc;

  bool _showCenterText = true;

  bool _showCenterWidget = true;

  double? _ringStrokeWidth = 32;

  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;

  bool _showLegends = true;

  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;

  bool _showChartValues = true;

  bool _showChartValuesInPercentage = false;

  bool _showChartValuesOutside = false;

  bool _showGradientColors = true;

  LegendShape? _legendShape = LegendShape.circle;

  LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Converted Leads": double.parse("${convertedLead.length}"),
      "Pending Leads": double.parse("${pendingLead.length}"),
      "Rejected Leads": double.parse("${rejectedLead.length}"),
      "Total Leads": double.parse("${totalLead.length}"),
    };
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "LEADS" : null,
     /* centerWidget: _showCenterWidget
          ? Container(color: Colors.red, child: const Text("Center"))
          : null,*/
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.rectangle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    final settings = SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              value: _showGradientColors,
              title: const Text("Show Gradient Colors"),
              onChanged: (val) {
                setState(() {
                  _showGradientColors = val;
                });
              },
            ),
            ListTile(
              title: Text(
                'Pie Chart Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListTile(
              title: const Text("chartType"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<ChartType>(
                  value: _chartType,
                  items: const [
                    DropdownMenuItem(
                      value: ChartType.disc,
                      child: Text("disc"),
                    ),
                    DropdownMenuItem(
                      value: ChartType.ring,
                      child: Text("ring"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartType = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text("ringStrokeWidth"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _ringStrokeWidth,
                  disabledHint: const Text("select chartType.ring"),
                  items: const [
                    DropdownMenuItem(
                      value: 16,
                      child: Text("16"),
                    ),
                    DropdownMenuItem(
                      value: 32,
                      child: Text("32"),
                    ),
                    DropdownMenuItem(
                      value: 48,
                      child: Text("48"),
                    ),
                  ],
                  onChanged: (_chartType == ChartType.ring)
                      ? (val) {
                          setState(() {
                            _ringStrokeWidth = val;
                          });
                        }
                      : null,
                ),
              ),
            ),
            SwitchListTile(
              value: _showCenterText,
              title: const Text("showCenterText (Deprecated)"),
              onChanged: (val) {
                setState(() {
                  _showCenterText = val;
                });
              },
            ),
            SwitchListTile(
              value: _showCenterWidget,
              title: const Text("showCenterWidget"),
              onChanged: (val) {
                setState(() {
                  _showCenterWidget = val;
                });
              },
            ),
            ListTile(
              title: const Text("chartLegendSpacing"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<double>(
                  value: _chartLegendSpacing,
                  disabledHint: const Text("select chartType.ring"),
                  items: const [
                    DropdownMenuItem(
                      value: 16,
                      child: Text("16"),
                    ),
                    DropdownMenuItem(
                      value: 32,
                      child: Text("32"),
                    ),
                    DropdownMenuItem(
                      value: 48,
                      child: Text("48"),
                    ),
                    DropdownMenuItem(
                      value: 64,
                      child: Text("64"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _chartLegendSpacing = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Legend Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showLegends,
              title: const Text("showLegends"),
              onChanged: (val) {
                setState(() {
                  _showLegends = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegendsInRow,
              title: const Text("showLegendsInRow"),
              onChanged: (val) {
                setState(() {
                  _showLegendsInRow = val;
                });
              },
            ),
            SwitchListTile(
              value: _showLegendLabel,
              title: const Text("showLegendLabels"),
              onChanged: (val) {
                setState(() {
                  _showLegendLabel = val;
                });
              },
            ),
            ListTile(
              title: const Text("legendShape"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendShape>(
                  value: _legendShape,
                  items: const [
                    DropdownMenuItem(
                      value: LegendShape.circle,
                      child: Text("BoxShape.circle"),
                    ),
                    DropdownMenuItem(
                      value: LegendShape.rectangle,
                      child: Text("BoxShape.rectangle"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendShape = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text("legendPosition"),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<LegendPosition>(
                  value: _legendPosition,
                  items: const [
                    DropdownMenuItem(
                      value: LegendPosition.left,
                      child: Text("left"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.right,
                      child: Text("right"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.top,
                      child: Text("top"),
                    ),
                    DropdownMenuItem(
                      value: LegendPosition.bottom,
                      child: Text("bottom"),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _legendPosition = val;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Chart values Options'.toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SwitchListTile(
              value: _showChartValueBackground,
              title: const Text("showChartValueBackground"),
              onChanged: (val) {
                setState(() {
                  _showChartValueBackground = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValues,
              title: const Text("showChartValues"),
              onChanged: (val) {
                setState(() {
                  _showChartValues = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesInPercentage,
              title: const Text("showChartValuesInPercentage"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesInPercentage = val;
                });
              },
            ),
            SwitchListTile(
              value: _showChartValuesOutside,
              title: const Text("showChartValuesOutside"),
              onChanged: (val) {
                setState(() {
                  _showChartValuesOutside = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    return Container(
      child: Column(children: [
        Text(
          "Lead Handling Performance Of Employee",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.sp,fontFamily: GoogleFonts.poppins().fontFamily,),
        ),
        SizedBox(
          height: 30,
        ),
        chart
      ]),
    );
  }

  late Map<String,double> dataMap1;
  void initializeValue() {
    dataMap1 = <String, double>{
      "Converted Leads": double.parse("${convertedLead.length}"),
      "Pending Leads": double.parse("${pendingLead.length}"),
      "Rejected Leads": double.parse("${rejectedLead.length}"),
      "Total Leads": double.parse("${totalLead.length}"),
    };
    setState(() {

    });
  }
}
