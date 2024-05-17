

import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/advertise_portal/advertise_side_bar_menu.dart';
import 'package:flutter_hr_management/advertise_portal/model/advertise_model.dart';
import 'package:flutter_hr_management/advertise_portal/my_advertise_page.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
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
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';

import 'package:http/http.dart'as http;

import 'provider/advertise_provider.dart';

class AdvertiseHomePage extends StatefulWidget {
  @override
  _AdvertiseHomePageState createState() => _AdvertiseHomePageState();
}

class _AdvertiseHomePageState extends State<AdvertiseHomePage> {

  final advProvider = locator<AdvProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advProvider.getCtmsOrganization();
    getLoginDetails();
  }

  ScrollController _scrollController = ScrollController();
  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    advProvider.getAdvertiseListByOrg(loginDeatils!.data!.organisationId!);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdvertiseSideBar(),
      key: _key,
      backgroundColor: ThemeColor.baground,
      body: Consumer<AdvProvider>(
        builder: (context, model, child) =>  SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Side Navigation Menu
              /// Only show in desktop
              if (AppResponsive.isDesktop(context))
                Expanded(
                  child: AdvertiseSideBar(),
                ),

              /// Main Body Part
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                   HeaderWidget(
                      isSearchVisible: false,
                      scaffoldKey: _key,
                    ),
                    Container(
                      margin: EdgeInsets.all(33),
                      child: Row(
                        children: [
                          Text(
                            'All Advertise',
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
                    Expanded(
                      child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 33, vertical: 0),
                          child:  model.isLoading!
                              ? Container(
                            height: MediaQuery.of(context).size.height - 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                              : model.advertiseListByOrgId.isEmpty
                              ? Container(
                              height: MediaQuery.of(context).size.height - 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: TextView(
                                      title: "No Record Found",
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900)))
                              : StaggeredGridView.countBuilder(
                              controller: _scrollController,
                              physics: ScrollPhysics(),
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                              shrinkWrap: true,
                              crossAxisCount: ResponsiveWidget.isMobile(context)? 1: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                              itemCount: model.advertiseListByOrgId.length,

                              ///meetingList.length,
                              itemBuilder: (context, index) {
                                return advDetailCard(
                                    model.advertiseListByOrgId[index]);
                              })),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  advDetailCard(AdvertiseData advertiseData) {
    return Container(
      height: 465.h,
      width: 330.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: Colors.white),
      // padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  advertiseData.bannerName.toString() ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  advertiseData.companyName.toString() ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Divider(),
          SizedBox(
            height: 2.h,
          ),
          getImage_Video(advertiseData.adImage.toString()),
          Visibility(
            visible: false,
            child: SizedBox(
              height: 5.h,
            ),
          ),
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "category : "+advertiseData.category.toString() ?? '-',
                // "https:www.googlemeetjk75",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              "contact : "+advertiseData.conatctNumber.toString() ?? '-',
              // "https:www.googlemeetjk75",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        Uri url = Uri.parse(advertiseData.bannerHyperlink.toString());
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $url');
                        }

                      },
                      child: Text(
                        advertiseData.bannerHyperlink.toString() ?? '',
                        // "https:www.googlemeetjk75",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    advertiseData.bannerHyperlink.toString()=='' ?SizedBox.shrink():InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text:advertiseData.bannerHyperlink.toString() ));
                        // copied successfully
                      },
                      child: Tooltip(
                          message: "Copy Link",
                          child: Icon(Icons.copy,color: Colors.blue,)
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




}
