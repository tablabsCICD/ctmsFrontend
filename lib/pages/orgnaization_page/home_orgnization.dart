import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/response/jwt_login_data.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu_page.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/orgnaization_page/side_bar_orgnization.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../constant/images.dart';
import '../dashboard/widget/header_widget.dart';

class HomeOrganizationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeOrganizationScreen();
  }

}
class _HomeOrganizationScreen extends State<HomeOrganizationScreen> {
  final orgProvider = locator<OrgProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getLoginDetail();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBarOrganization(),
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              Expanded(
                child: SideBarOrganization(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  HeaderWidget(scaffoldKey:_scaffoldKey,isSearchVisible: false),
                  SizedBox(height: 38.h,),
                  Container(
                    color: AppColor.bgColor,
                    // margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(width: 38.w,),
                        InkWell(onTap: () async {
                         Organization organization = await orgProvider.getOrgDetails();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      CompanyDashboard(organization)));
                        },
                          child: empCounts(
                              "0", "Monitoring", Images.monitoring, Color(
                              0xFFEAF8F4)),),
                        SizedBox(width: 38.w,),
                        InkWell(onTap: () {
                          Navigator.pushNamed(context, AppRoutes.crm);
                        }, child: empCounts("0", "CRM", Images.crm, Color(
                            0xFFFFEDF9)),),
                        SizedBox(width: 38.w,),
                        InkWell(onTap: () async {
                         await getEmpToken(loginDeatils!.data!.id!);
                          final url = Uri.parse(
                              ApiConstant.HRMS_URL+"${isAdmin?"/employee":"/leave"}"+"?token=${token}&empId=${loginDeatils!.data!.id!}&orgId=${loginDeatils!.data!.organisationId}");
                          debugPrint("HRMS Url : "+url.toString());
                          if (!await launchUrl(url,)) {
                            throw Exception('Could not launch $url');
                          }
                        }, child: empCounts("0", "HRM", Images.hrm, Color(
                            0xFFF6E3D1)),),
                        // empCounts("0","HRM",Images.hrm,Color(0xFFFEF0E5)),
                      ],
                    ),
                  ),
                  SizedBox(height: 38.h,),
                  Container(
                    // margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                       /* SizedBox(width: 38.w,),
                        empCounts("0", "E-Invoices", Images.invoice,
                            Color(0xFFEAF8F4)),*/
                        SizedBox(width: 38.w,),
                        Visibility(
                          visible: false,
                          child: InkWell(
                            onTap: () async {
                            await  getEmpToken(loginDeatils!.data!.id!);
                              final url = Uri.parse(ApiConstant.BILTY_URL+
                                  "?token=${token}&empId=${loginDeatils!.data!.id!}&orgId=${loginDeatils!.data!.organisationId}");
                              debugPrint("Bilty Url : "+url.toString());
                              if (!await launchUrl(url,)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child:
                            empCounts("0", "E-Bilty", Images.bilty, Color(
                                0xFFFFEDF9)),),
                        ),
                     //   SizedBox(width: 38.w,),
                        Visibility(
                          visible: true,
                          child: InkWell(onTap: () {
                            advProvider.getAdvertiseListByOrg(loginDeatils!.data!.organisationId!);
                            advProvider.getAdvertiseListByUser(loginDeatils!.data!.id!);
                            Navigator.pushNamed(context, AppRoutes.advertise);
                          }, child: empCounts("0", "Advertise Portal", Images.crm, Color(
                              0xFFFFEDF9)),),
                        ),
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

  empCounts(String totCount, String name, String image, Color color) {
    return Container(
      width: 329.w,
      height: 166.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.white),
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
                padding: EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  image, height: 10.h, width: 10.w, color: Colors.black,),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  String? token;

  Future<void> getEmpToken(int empId) async {
    String authToken = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    String myUrl = ApiConstant.BASE_URL +
        "api/getTokenByEmployeeId?employeeId=${empId}";
    debugPrint("Get Token Url:" + myUrl);

    EasyLoading.show(status: "Loading");
    final req = await http.get(Uri.parse(myUrl), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${authToken}',
    });
    EasyLoading.dismiss();
    print('the body is ${req.body}');
    if (req.statusCode == 200) {
      var jwtResponse = json.decode(req.body);
      print('the response is ${jwtResponse}');
      JWTLoginData jwtLoginData =
      JWTLoginData.fromJson(jwtResponse);
      if (jwtLoginData.data != null) {
        token = jwtLoginData.data!;
        print("Final Generated Token ::" + token!);
      } else {
        showCustomToast(
            context, jwtLoginData.message!, Icons.clear, Colors.red);
      }
    }
  }

  final advProvider = locator<AdvProvider>();
  bool isAdmin = false;
  LoginDeatils? loginDeatils;
  Future<void> getLoginDetail() async {
    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    isAdmin =  loginDeatils!.data!.isAdmin!;
    advProvider.getCtmsOrganization();
   // getEmpToken(loginDeatils!.data!.id!);
  }
}