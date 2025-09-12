import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/response/jwt_login_data.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/sharepreferences.dart';

class SideBarOrganization extends StatefulWidget {
  @override
  _SideBarOrganization createState() => _SideBarOrganization();
}

class _SideBarOrganization extends State<SideBarOrganization> {
  static bool isDashbord = true;
  static bool isMonitoring = false;
  static bool isCRM = false;
  static bool isCustomer = false;
  static bool isHRM = false;
  static bool isBuilty = false;
  static bool isAdv = false;
  final orgProvider = locator<OrgProvider>();

  @override
  void initState() {
    super.initState();
    getLoginDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 47.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  height: 77.h,
                  width: 133.w,
                ),
              ),
            ),
            SizedBox(height: 47.h),
            DrawerListTile(
              isSelect: isDashbord,
              title: "Dashboard",
              icon: "assets/menu/dashboard_menu.svg",
              press: () {
                isMonitoring = false;
                isCRM = false;
                isHRM = false;
                isBuilty = false;
                isAdv = false;
                isDashbord = true;
                setState(() {});
              },
            ),
            DrawerListTile(
              isSelect: isMonitoring,
              title: "Monitoring",
              icon: Images.monitoring,
              press: () async {
                isMonitoring = true;
                isCRM = false;
                isHRM = false;
                isBuilty = false;
                isAdv = false;
                isDashbord = false;
                setState(() {});
                Organization? organization =
                await orgProvider.getOrgDetails();
                print(organization!.companyName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => CompanyDashboard(organization),
                  ),
                );
              },
            ),
            DrawerListTile(
              isSelect: isCRM,
              title: "CRM",
              icon: Images.crm,
              press: () {
                isMonitoring = false;
                isCRM = true;
                isHRM = false;
                isBuilty = false;
                isAdv = false;
                isDashbord = false;
                setState(() {});
                Navigator.pushNamed(context, AppRoutes.crm);
              },
            ),
            DrawerListTile(
              isSelect: isHRM,
              title: "HRM",
              icon: Images.hrm,
              press: () async {
                isMonitoring = false;
                isCRM = false;
                isHRM = true;
                isBuilty = false;
                isAdv = false;
                isDashbord = false;
                setState(() {});
                final url = Uri.parse(
                  "http://tkd-hrms.s3-website.ap-south-1.amazonaws.com/hrm/employee",
                );
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            /* DrawerListTile(
              isSelect: isCustomer,
              title: "E-Invoices",
              icon: Images.invoice,
              press: () {

              },
            ),*/
            DrawerListTile(
              isSelect: isBuilty,
              title: "E-Bilty",
              icon: Images.bilty,
              press: () async {
                isMonitoring = false;
                isCRM = false;
                isHRM = false;
                isBuilty = true;
                isAdv = false;
                isDashbord = false;
                setState(() {});
                await getEmpToken(loginDeatils!.data!.id!);
                final url = Uri.parse(
                  ApiConstant.BILTY_URL +
                      "?token=${token}&empId=${loginDeatils!.data!.id!}&orgId=${loginDeatils!.data!.organisationId}",
                );
                debugPrint("Bilty Url : " + url.toString());
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            DrawerListTile(
              isSelect: isAdv,
              title: "Advertise Portal",
              icon: Images.hrm,
              press: () async {
                isMonitoring = false;
                isCRM = false;
                isHRM = false;
                isBuilty = false;
                isAdv = true;
                isDashbord = false;
                setState(() {});
                advProvider.getAdvertiseListByOrg(
                    loginDeatils!.data!.organisationId!);
                advProvider.getAdvertiseListByUser(
                    loginDeatils!.data!.id!);
                Navigator.pushNamed(context, AppRoutes.advertise);
              },
            ),
            DrawerListTile(
              isSelect: false,
              title: "Log Out",
              icon: "assets/menu/logout_menu.svg",
              press: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String? token;

  Future<void> getEmpToken(int empId) async {
    String authToken = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    String myUrl =
        ApiConstant.BASE_URL + "api/getTokenByEmployeeId?employeeId=${empId}";
    debugPrint("Get Token Url:" + myUrl);

    EasyLoading.show(status: "Loading");
    final req = await http.get(
      Uri.parse(myUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${authToken}',
      },
    );
    EasyLoading.dismiss();
    print('the body is ${req.body}');
    if (req.statusCode == 200) {
      var jwtResponse = json.decode(req.body);
      print('the response is ${jwtResponse}');
      JWTLoginData jwtLoginData = JWTLoginData.fromJson(jwtResponse);
      if (jwtLoginData.data != null) {
        token = jwtLoginData.data!;
        print("Final Generated Token ::" + token!);
      } else {
        showCustomToast(
          context,
          jwtLoginData.message!,
          Icons.clear,
          Colors.red,
        );
      }
    }
  }

  final advProvider = locator<AdvProvider>();
  bool isAdmin = false;
  LoginDeatils? loginDeatils;

  Future<void> getLoginDetail() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    isAdmin = loginDeatils!.data!.isAdmin!;
    advProvider.getCtmsOrganization();
    // getEmpToken(loginDeatils!.data!.id!);
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        await LocalSharePreferences().logOut();
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.entry,
              (route) => false,
        );
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Do you want to log out"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String? title, icon;
  final VoidCallback? press;
  final bool isSelect;

  const DrawerListTile({
    Key? key,
    this.title,
    this.icon,
    this.press,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Container(
        width: 232.w,
        height: 65.h,
        decoration: isSelect
            ? ShapeDecoration(
          color: Color(0xFFC3262C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
            : ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 33.w),
              SvgPicture.asset(
                icon!,
                color: isSelect ? AppColor.white : Colors.grey,
                height: 25.h,
                width: 25.w,
              ),
              SizedBox(width: 27.w),
              Text(
                title!,
                style: isSelect
                    ? TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                )
                    : TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
