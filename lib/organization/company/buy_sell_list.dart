import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization/open_whatsapp.dart';
import 'package:flutter_hr_management/organization/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization/util/date_converter.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';

class BuySellList extends StatefulWidget {
  final buySellProvider = locator<OrgProvider>();
  Organization organization;

  BuySellList(this.organization, {Key? key}) : super(key: key) {
    buySellProvider.getBuyVehicles(organization.id!);
  }

  @override
  _BuySellListState createState() => _BuySellListState();
}

class _BuySellListState extends State<BuySellList> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();

  var selectedPageNumber = 1;
  ScrollController _scrollController = ScrollController();
  final buySellProvider = locator<BuySellProvider>();

 /* @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        buySellProvider.getBuyVehicles(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            getCircularContainer(
                                "Buy Vehicle",
                                (model.selectedBuySellTab == "Buy Vehicle"),
                                0,
                                model),
                            SizedBox(width: 10.w,),
                            getCircularContainer(
                                "Sell Vehicle",
                                (model.selectedBuySellTab == "Sell Vehicle"),
                                1,
                                model),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      model.finalBuySellList.isEmpty
                          ?  Container(
                          height:
                          MediaQuery.of(context).size.height - 600,
                          decoration: BoxDecoration(
                              color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: TextView(
                                  title: "No Record Found",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)))
                          : Container(
                                  height: 433.h,
                                  width: 1052.w,
                                  padding: EdgeInsets.all(29),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/org/logo_iveco.png',
                                                height: 24.h,
                                                width: 126.w,
                                              ),
                                              TextView(
                                                title: model.finalBuySellList[0]
                                                    .vehicleRegistrationNumber
                                                    .toString(),
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize: 25.sp,
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                             /* InkWell(
                                                onTap: () {},
                                                child: getIconData(
                                                    'assets/call.svg', 'Phone',
                                                    onTap: () {}),
                                              ),
                                              getIconData(
                                                  'assets/mail.svg', 'Email',
                                                  onTap: () {}),
                                              SizedBox(
                                                width: 5.w,
                                              ),*/
                                              SizedBox(
                                                width: 119.w,
                                                height: 40.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) => new CupertinoAlertDialog(
                                                          title: Column(
                                                            children: [
                                                              Text(
                                                                  'Contact Number : ${model.finalBuySellList[0].contactNumber}',
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold)),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(10.0),
                                                                child: Text('Ok',
                                                                    style: TextStyle(
                                                                        color: Colors.green,
                                                                        fontSize: 18)),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        ThemeColor.theme_blue,
                                                    onPrimary: Colors.white,
                                                    elevation: 3,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.r))),
                                                  ),
                                                  child: TextView(
                                                    title: "Contact",
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffffffff),
                                                  ),
                                                ),
                                              ),
                                              /*getIconData(
                                                  'assets/more_icon.svg',
                                                  'more',
                                                  onTap: () {}),*/
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            height: 250.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                getCard(
                                                    'Engine Power',
                                                    model.finalBuySellList[0]
                                                        .enginePower
                                                        .toString()),
                                                SizedBox(
                                                  height: 17.h,
                                                ),
                                                getCard(
                                                    'Transmission',
                                                    model.finalBuySellList[0]
                                                        .transmission
                                                        .toString()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18.w,
                                          ),
                                          SizedBox(
                                            width: 120.w,
                                            height: 250.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                getCard(
                                                    'Drive Type',
                                                    model.finalBuySellList[0]
                                                        .driverType
                                                        .toString()),
                                                SizedBox(
                                                  height: 17.h,
                                                ),
                                                getCard(
                                                    'Weight',
                                                    model.finalBuySellList[0]
                                                        .weight
                                                        .toString()),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/org/cargo_truck.png',
                                            height: 286.h,
                                            width: 720.w,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                      SizedBox(height: 34.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            title: 'All Trucks',
                            color: Colors.black,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            children: [
                              filterIcon(model),
                              SizedBox(
                                width: 10.w,
                              ),
                              TextView(
                                title: 'View All',
                                color: ThemeColor.theme_blue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      model.finalBuySellList.isEmpty
                          ? Container(
                              height:
                                  MediaQuery.of(context).size.height - 200,
                              child: Center(
                                  child: Text(
                                "No Record Found",
                                style: Style.heading,
                              )))
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 39.w, vertical: 31.h),
                              child: StaggeredGridView.countBuilder(
                                controller: _scrollController,
                                physics: ScrollPhysics(),
                                crossAxisCount:
                                    ResponsiveWidget.isDesktop(context)
                                        ? 2
                                        : ResponsiveWidget.isMobile(context)
                                            ? 1
                                            : 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                                itemCount: model.finalBuySellList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  'assets/org/cargo_truck.png',
                                                  height: 129.h,
                                                  width: 335.w,
                                                ),
                                                Text(
                                                  model.finalBuySellList[index]
                                                      .vehicleInfo
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.sp,
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  '${model.finalBuySellList[index].enginePower} | ${model.orgBuySellList[index].weight}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.sp,
                                                    fontFamily:
                                                        GoogleFonts.poppins()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 140.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Current Location',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 16,
                                                      ),
                                                      Text(
                                                        '${model.finalBuySellList[index].city}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15.sp,
                                                          fontFamily: GoogleFonts
                                                                  .poppins()
                                                              .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 39.h,),
                                                  Row(
                                                    children: [
                                                      getImage('',height: 30.h),
                                                      SizedBox(width: 10.w,),
                                                      Expanded(
                                                        child: Text(
                                                          "${model.finalBuySellList[index].ownerName}",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize:15.sp,
                                                            fontWeight: FontWeight.w300,
                                                            color: Color(0xff000000),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h,),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 15.w,),
                                                      SvgPicture.asset('assets/sheild.svg',height: 15.h,width: 15.w,),
                                                      SizedBox(width: 5.w,),
                                                      TextView(
                                                        title: "${model.finalBuySellList[index].driverType}",
                                                        fontSize:14.sp,
                                                        fontWeight: FontWeight.w200,
                                                        color: Color(0xff000000),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                //  physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                staggeredTileBuilder: (int index) =>
                                    StaggeredTile.fit(1),
                              ),
                            ),
                      //getLoader(model.isLoading)
                    ],
                  ),
                ),
              )),
    );
  }

  getCircularContainer(
      String title, bool isSelected, int i, OrgProvider model) {
    return InkWell(
      onTap: () {
        model.getFinalBuySellList(title);
      },
      child: Container(
        width: 200.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? Color(0xffC3262C) : Colors.white,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 20.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  getUserDetails(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(children: [
        SizedBox(
          width: 150.w,
          child: TextView(
            title: title,
            fontSize: 12.sp,
            fontWeight: FontWeight.w300,
            color: Color(0xff000000),
          ),
        ),
        SizedBox(
          width: 50.w,
          child: TextView(
            title: ':',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        TextView(
          title: value,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000),
        ),
      ]),
    );
  }

  getIconData(String icon, String title, {required Function() onTap}) {
    return Container(
      height: 40.h,
      width: 105.w,
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: icon == "assets/more_icon.svg"
              ? Border(
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none)
              : Border.all(color: Colors.black)),
      child: Row(
        children: [
          icon == ""
              ? SizedBox.shrink()
              : SvgPicture.asset(
                  icon,
                  height: 25.h,
                  width: 25.h,
                ),
          SizedBox(
            width: 5.w,
          ),
          icon == "assets/more_icon.svg"
              ? SizedBox.shrink()
              : TextView(
                  title: title,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 14.sp,
                )
        ],
      ),
    );
  }

  filterIcon(OrgProvider model) {
    return Container(
        width: 125.w,
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {},
                itemBuilder: (ctx) => [
                  _buildPopupMenu('Sort By Name A to Z', 0, model),
                  _buildPopupMenu('Sort By Name Z to A', 1, model),
                ],
              ),
              Text(
                "Filter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  PopupMenuItem _buildPopupMenu(
    String title,
    int? id,
    OrgProvider model,
  ) {
    return PopupMenuItem(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w500,
            color: Colors.black),
      ),
      onTap: () {
        if (id == 0) {
          model.orgBuySellList
              .sort((b, a) => b.ownerName!.compareTo(a.ownerName!));
          setState(() {});
        } else {
          model.orgBuySellList
              .sort((a, b) => b.ownerName!.compareTo(a.ownerName!));
          setState(() {});
        }
      },
    );
  }

  getCard(String title, String subtitle) {
    return Container(
      height: 115.h,
      width: 123.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: Color(0xffF7F7F7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextView(
            title: title,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 15.sp,
          ),
          TextView(
            title: subtitle,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 22.sp,
          )
        ],
      ),
    );
  }
}
