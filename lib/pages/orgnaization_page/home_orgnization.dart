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
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/orgnaization_page/side_bar_orgnization.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../constant/images.dart';
import '../../model/ctms_organization.dart';
import '../../model/response/ctms_organization.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/toast.dart';

class HomeOrganizationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeOrganizationScreen();
  }

}
class _HomeOrganizationScreen extends State<HomeOrganizationScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final orgProvider = locator<OrgProvider>();
  final advProvider = locator<AdvProvider>();

  String? token;
  bool isAdmin = false;
  LoginDeatils? loginDeatils;
  LoginDeatils? loginDeatil;
  CtmsOrganization? ctmsOrganization;

  @override
  void initState() {
    super.initState();
  //  getLoginDetail();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await orgProvider.loadOrgFromLocal();
      if (orgProvider.org == null) {
        await orgProvider.getCtmsOrganization();
      }

      if (orgProvider.org != null) {
        debugPrint("✅ Org loaded: ${orgProvider.org!.companyName}");
      } else {
        ToastMessage.show(context, "No organisation found. Please contact admin.");
      }
    });
  }

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
            if (AppResponsive.isDesktop(context))
              Expanded(
                child: SideBarOrganization(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  HeaderWidget(scaffoldKey: _scaffoldKey, isSearchVisible: false),
                  SizedBox(height: 38.h),
                  Container(
                    color: AppColor.bgColor,
                    child: Row(
                      children: [
                        SizedBox(width: 38.w),
                        Consumer<OrgProvider>(
                          builder: (context, model, child) => InkWell(
                            onTap: () async {

                              final org = context.read<OrgProvider>().org;
                              if (org == null) {
                                ToastMessage.show(context, "No organisation found. Please contact admin.");
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (builder) => CompanyDashboard(org)),
                              );
                            },
                            child: empCounts(
                              "0",
                              "Monitoring",
                              Images.monitoring,
                              const Color(0xFFEAF8F4),
                            ),
                          ),
                        ),
                        SizedBox(width: 38.w),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.crm);
                          },
                          child: empCounts(
                            "0",
                            "CRM",
                            Images.crm,
                            const Color(0xFFFFEDF9),
                          ),
                        ),
                        SizedBox(width: 38.w),
                        InkWell(
                          onTap: () async {
                            final empId = loginDeatils?.data?.id;
                            if (empId == null) return;

                            await getEmpToken(empId);

                            final orgId = loginDeatils?.data?.organisationId ?? 0;
                            final url = Uri.parse(
                              "${ApiConstant.HRMS_URL}${isAdmin ? "/employee" : "/leave"}"
                                  "?token=$token&empId=$empId&orgId=$orgId",
                            );

                            debugPrint("HRMS Url : $url");

                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: empCounts(
                            "0",
                            "HRM",
                            Images.hrm,
                            const Color(0xFFF6E3D1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 38.h),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(width: 38.w),
                        Visibility(
                          visible: true,
                          child: InkWell(
                            onTap: () async {
                              final empId = loginDeatils?.data?.id;
                              if (empId == null) return;

                              await getEmpToken(empId);

                              final orgId =
                                  loginDeatils?.data?.organisationId ?? 0;
                              final url = Uri.parse(
                                "${ApiConstant.BILTY_URL}?token=$token&empId=$empId&orgId=$orgId",
                              );

                              debugPrint("Bilty Url : $url");

                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: empCounts(
                              "0",
                              "E-Bilty",
                              Images.bilty,
                              const Color(0xFFFFEDF9),
                            ),
                          ),
                        ),
                        SizedBox(width: 38.w),
                        Visibility(
                          visible: true,
                          child: InkWell(
                            onTap: () {
                              final orgId =
                                  loginDeatils?.data?.organisationId ?? 0;
                              final userId = loginDeatils?.data?.id ?? 0;

                              advProvider.getAdvertiseListByOrg(orgId);
                              advProvider.getAdvertiseListByUser(userId);

                              Navigator.pushNamed(
                                  context, AppRoutes.advertise);
                            },
                            child: empCounts(
                              "0",
                              "Advertise Portal",
                              Images.crm,
                              const Color(0xFFFFEDF9),
                            ),
                          ),
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

  Widget empCounts(String totCount, String name, String image, Color color) {
    return Container(
      width: 329.w,
      height: 166.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Colors.white),
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
                shape: const CircleBorder(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  image,
                  height: 10.h,
                  width: 10.w,
                  color: Colors.black,
                ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getEmpToken(int empId) async {
    final authToken = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    final myUrl =
        "${ApiConstant.BASE_URL}api/getTokenByEmployeeId?employeeId=$empId";
    debugPrint("Get Token Url: $myUrl");

    EasyLoading.show(status: "Loading");
    final req = await http.get(
      Uri.parse(myUrl),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $authToken',
      },
    );
    EasyLoading.dismiss();

    debugPrint('the body is ${req.body}');
    if (req.statusCode == 200) {
      final jwtResponse = json.decode(req.body);
      debugPrint('the response is $jwtResponse');

      final jwtLoginData = JWTLoginData.fromJson(jwtResponse);

      if (jwtLoginData.data != null) {
        token = jwtLoginData.data;
        debugPrint("Final Generated Token :: $token");
      } else {
        showCustomToast(
          context,
          jwtLoginData.message ?? "Token generation failed",
          Icons.clear,
          Colors.red,
        );
      }
    }
  }

  /*Future<void> getLoginDetail() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();

    if (loginDeatils?.data != null) {
      debugPrint("CurrentLoggedIn username:::: ${loginDeatils!.data!.firstName}");
      isAdmin = loginDeatils!.data!.isAdmin ?? false;
    }
    await getCtmsOrganization();
  }

  Future<void> getCtmsOrganization() async {
    loginDeatil =
    await LocalSharePreferences.localSharePreferences.getLoginData();

    final orgId = loginDeatil?.data?.organisationId;
    if (orgId == null) return;

    final dio = Dio();
    final token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    final response = await dio.get(
      "${ApiConstant.GET_CTMS_ORG}?Id=$orgId",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
    );

    debugPrint(response.data.toString());

    final ctmsOrganizationResponse = CtmsOrganizationResponse.fromJson(
      jsonDecode(response.data),
    );

    ctmsOrganization = ctmsOrganizationResponse.data;

    if (ctmsOrganization != null) {
      await LocalSharePreferences().setString(
        SharedPreferencesConstant.connectOrganizationId,
        ctmsOrganization!.connectOrgId?.toString() ?? "",
      );
      await LocalSharePreferences().setString(
        SharedPreferencesConstant.connectUserId,
        ctmsOrganization!.connectUserId?.toString() ?? "",
      );

      debugPrint("Tkd OrgId::: ${ctmsOrganization!.connectOrgId}");
      debugPrint(ctmsOrganization!.connectUserId.toString());
    }
  }*/
}
