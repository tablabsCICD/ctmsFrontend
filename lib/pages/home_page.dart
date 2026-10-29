import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../constant/constant.dart';
import '../model/lead_model.dart';
import 'empdetails/employee_list_dashboard.dart';
import 'leaddeatils/lead_dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  LoginDeatils? loginDeatils;

  String selectedLeadType = "total";
  String selectedEmpList = "Total";

  List<LeadData> leadData = [];
  List<LeadData> finalLeadData = [];
  List<LeadData> convertedLead = [];
  List<LeadData> rejectedLead = [];
  List<LeadData> pendingLead = [];

  List<EmployeeData> empData = [];
  List<EmployeeData> finalEmData = [];
  List<EmployeeData> activeEmpData = [];
  List<EmployeeData> inActiveEmpData = [];
  EmployeeListResponse? employeeListResponse;

  @override
  void initState() {
    super.initState();
    getLoginDetails();
    ApiGetAllLead('', 0);
    ApiGetAllEmployee("", 0);
  }

  Future<void> getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
  }

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
            if (AppResponsive.isDesktop(context))
              Expanded(child: SideBar()),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  HeaderWidget(
                    isSearchVisible: false,
                    scaffoldKey: _key,
                  ),
                  /// Lead Section
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
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 33.w, vertical: 20.h),
                    child: Row(
                      children: [
                        leadCountCard(
                          'Total Leads',
                          '${leadData.length}',
                          'total',
                          Colors.green.shade50,
                        ),
                        SizedBox(width: 32.w),
                        leadCountCard(
                          'Converted',
                          '${convertedLead.length}',
                          'converted',
                          Colors.red.shade50,
                        ),
                        SizedBox(width: 32.w),
                        leadCountCard(
                          'Rejected',
                          '${rejectedLead.length}',
                          'rejected',
                          Colors.orange.shade50,
                        ),
                        SizedBox(width: 32.w),
                        leadCountCard(
                          'Pending',
                          '${pendingLead.length}',
                          'pending',
                          Colors.blue.shade50,
                        ),
                      ],
                    ),
                  ),

                  /// Employee Section
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
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 38.w),
                      empCounts(
                        "${empData.length}",
                        "Total Employees",
                        Images.emp_tot,
                        Color(0xFFEAF8F4),
                        "Total",
                      ),
                      SizedBox(width: 38.w),
                      empCounts(
                        "${activeEmpData.length}",
                        "Active Employees",
                        Images.emp_tot,
                        Color(0xFFFFEDF9),
                        "Active",
                      ),
                      SizedBox(width: 38.w),
                      empCounts(
                        "${inActiveEmpData.length}",
                        "Inactive Employees",
                        Images.emp_tot,
                        Color(0xFFFEF0E5),
                        "InActive",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =======================
  /// Lead Count Card
  /// =======================
  Widget leadCountCard(
      String title,
      String count,
      String typeKey,
      Color bgColor,
      ) {
    bool isSelected = selectedLeadType == typeKey;

    return InkWell(
      onTap: () {
        setState(() {
          selectedLeadType = typeKey;
          finalLeadData.clear();
          if (typeKey == "pending") {
            finalLeadData.addAll(pendingLead);
          } else if (typeKey == "converted") {
            finalLeadData.addAll(convertedLead);
          } else if (typeKey == "rejected") {
            finalLeadData.addAll(rejectedLead);
          } else {
            finalLeadData.addAll(leadData);
          }
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LeadDashboardScreen()),
        );
      },
      child: Container(
        width: 243.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              color: isSelected ? Color(0xFFC3262C) : Colors.grey.shade300,
            ),
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
            SizedBox(width: 17.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  title: count,
                  fontSize: 35.sp,
                  color: AppColor.black,
                  fontWeight: FontWeight.w600,
                ),
                TextView(
                  title: title,
                  fontSize: 16.sp,
                  color: Color(0xff6C6C6C),
                  fontWeight: FontWeight.w300,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// =======================
  /// Employee Count Card
  /// =======================
  Widget empCounts(
      String totCount,
      String name,
      String image,
      Color color,
      String typeKey,
      ) {
    bool isSelected = selectedEmpList == typeKey;

    return InkWell(
      onTap: () {
        setState(() {
          selectedEmpList = typeKey;
          finalEmData.clear();
          if (typeKey == "Active") {
            finalEmData.addAll(activeEmpData);
          } else if (typeKey == "InActive") {
            finalEmData.addAll(inActiveEmpData);
          } else {
            finalEmData.addAll(empData);
          }
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EmloyeeListScreen()),
        );
      },
      child: Container(
        width: 329.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              color: isSelected ? Color(0xFFC3262C) : Colors.grey.shade300,
            ),
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
                  color: color,
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    image,
                    height: 50.h,
                    width: 50.w,
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
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff6C6C6C),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// =======================
  /// API Calls
  /// =======================
  Future<void> ApiGetAllLead(String URL, int pageNo) async {
    EasyLoading.show();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl =
        "${ApiConstant.GET_ALL_LEAD}?organisationId=${loginDeatils!.data!.organisationId}&page=$pageNo&size=10&sortBy=id&sortDir=asc";

    final dio = Dio();
    final response = await dio.get(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        }));

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
      for (var element in leadData) {
        if (element.status == null) element.status = "pending";
        finalLeadData.add(element);
        if (element.status!.toLowerCase() == "converted") {
          convertedLead.add(element);
        } else if (element.status!.toLowerCase() == "pending") {
          pendingLead.add(element);
        } else if (element.status!.toLowerCase() == "rejected") {
          rejectedLead.add(element);
        }
      }
      setState(() {});
    }
  }

  Future<void> ApiGetAllEmployee(String URL, int pNo) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show();
    Dio dio = Dio();

    final response = await dio.get(
        "${ApiConstant.GET_ALL_EMPLOYEE}?organisationId=${loginDeatils!.data!.organisationId}&page=$pNo&size=10000",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        }));

    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      employeeListResponse =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      finalEmData.clear();
      activeEmpData.clear();
      inActiveEmpData.clear();

      empData.clear();
      empData.addAll(employeeListResponse!.data!.content!);
      for (var element in empData) {
        if (element.isActive == 1) {
          activeEmpData.add(element);
        } else {
          inActiveEmpData.add(element);
        }
      }
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeListResponse!.data!.content!);
      setState(() {});
    }
  }
}
