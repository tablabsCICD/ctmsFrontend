import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization/company/all_bids.dart';
import 'package:flutter_hr_management/organization/company/all_user_list.dart';
import 'package:flutter_hr_management/organization/company/buy_sell_list.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization/company/load_list.dart';
import 'package:flutter_hr_management/organization/get_city_list.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_hr_management/organization/auth/login_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu/all_users.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_buy_sell.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_discussion_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_bids.dart';
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
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';

class CompanyDashboard extends StatefulWidget {
  Organization organization;
  final orgProvider = locator<OrgProvider>();

  CompanyDashboard(this.organization, {Key? key}) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization.id!);
    orgProvider.getBuyVehicles(organization.id!);
    orgProvider.getStaticData(organization.id!);
  }

  @override
  _CompanyDashboardState createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();
  String? selectedFromCity = '', selectedToCity = "";
  late Widget container ;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    container = LoadList(widget.organization,index: 0,);
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Row(
                  children: [
                    if (AppResponsive.isDesktop(context))
                      Expanded(
                        child: CompanySideBar(),
                      ),
                    /// Main Body Part
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          HeaderWidget(isSearchVisible:false),
                          SizedBox(height: 35.h,),
                          SizedBox(
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 25.0.w),
                                    child: InkWell(
                                      onTap: () {
                                       // _showMultiSelect(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomSearchCityTextField(
                                            hintText: 'From',
                                            controller: selectedFromCity!,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GetCityList())).then((value) {
                                                if (value.toString().isNotEmpty &&
                                                    value != null) {
                                                  selectedFromCity = value[0];
                                                  setState(() {});
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 25.w,
                                          ),
                                          TextView(
                                            title: "To",
                                            fontSize:15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000),
                                          ),
                                          SizedBox(
                                            width: 25.w,
                                          ),
                                          CustomSearchCityTextField(
                                            hintText: 'To',
                                            controller: selectedToCity!,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GetCityList())).then((value) {
                                                if (value.toString().isNotEmpty &&
                                                    value != null) {
                                                  selectedToCity = value[0];
                                                  setState(() {});
                                                }
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 25.w,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              model.getSearchByNameList(
                                                  '', selectedFromCity!, selectedToCity!);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.black,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5))),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 0),
                                              child: CustomText("Search",
                                                  style: Style.button),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      filterIcon(model),
                                      SizedBox(
                                        width: 27.w,
                                      ),
                                     /* SvgPicture.asset('assets/more_icon.svg'),
                                      SizedBox(
                                        width: 27.w,
                                      ),*/
                                    ],
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height: 35.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              getContainer("Total User",0,model.allUserList.length.toString(), Color(0xffEAF8F4),'assets/org/total_users.svg'),
                              getContainer("Load Post",1,model.fullLoadPostCount.toString(), Color(0xffFFEDF9),'assets/org/all_load.svg'),
                              getContainer("Buy Sell",3, model.buySellPostCount.toString(), Color(0xffFEF0E5),'assets/org/buy_sell.svg'),
                              getContainer("All Quotes",4,model.bidCont.toString(), Color(0xffEDE8FF),'assets/org/bid.svg'),
                            ],
                          ),
                          SizedBox(height: 35.h,),
                          Expanded(
                              child: container)
                        ],
                      ),
                    ),
                  ],
                ),
                ResponsiveWidget.isDesktop(context)?Positioned(
                  top: 115.h,
                  left: 265.w,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                    child: SvgPicture.asset(
                      "assets/back_button.svg",
                      height: 76.h,
                      width: 76.w,
                    ),
                  ),
                ):SizedBox.shrink(),
              ],
            ),
          )),
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
                icon:  SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {

                },
                itemBuilder: (ctx) => [
                  _buildPopupMenu('All Loads',0,model),
                  _buildPopupMenu('Full Load Available',1,model),
                  _buildPopupMenu('Full Load Required',2,model),
                  _buildPopupMenu('Part Load Available',3,model),
                  _buildPopupMenu('Part Load Required',4,model),
                ],
              ),
              Text(
                "Filter",
                style:TextStyle(
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
      String title, int? id,OrgProvider model
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
      fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
        color: Colors.black),),
      onTap: (){
        setState(() {
        //  selectedTab = title;
          model.getFilterFullLoadList(title);
        });
      },
    );
  }

  void getLogoutFunction(OrgProvider orgProvider) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: Text(getTranslated('log_out', context)!),
              actions: <Widget>[
                TextButton(
                  child: Text(getTranslated('yes', context)!,
                      style: TextStyle(color: ColorResources.RED)),
                  onPressed: () {
                    logoutFunction(orgProvider);
                  },
                ),
                TextButton(
                  child: Text(
                    getTranslated('no', context)!,
                    style: TextStyle(color: ColorResources.GREEN),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Future<void> logoutFunction(OrgProvider authProvider) async {
    await authProvider.setCompanyVisitingFlag(false);
    await authProvider.setCompanyOrgId(0);
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => Login_Screen()));
  }

  getContainer(String title, int value,String count, Color bgColor, String img) {
    return InkWell(
      onTap: (){
        switch(value){
          case 0:
            container = AllUsersList(widget.organization);
          //Navigator.push(context, MaterialPageRoute(builder: (builder)=>AllUsers(widget.organization)));
            break;
          case 1:
            container = LoadList(widget.organization,index: 0,);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompLoadScreen()));
            break;
          case 2:
            container = CompDiscussionScreen(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompanyPoolPurchesScreen()));
            break;
          case 3:
            container = BuySellList(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompBuySell()));
            break;
          case 4:
            container = BidList(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompanyBidsScreen()));
            break;
          default:
            container = AllUsers(widget.organization);
        }
      },
      child:  Container(
        width: 243.w,
        height: 162.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: Colors.white),
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
                img,
                height: 50.h,
                width: 50.w,
              ),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                    title: count,
                    fontSize: 35.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600),
                TextView(
                    title: title,
                    fontSize: 20.sp,
                    color: Color(0xff6C6C6C),
                    fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }
}
