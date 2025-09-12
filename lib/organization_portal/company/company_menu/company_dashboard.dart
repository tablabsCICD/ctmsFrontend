import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization_portal/company/all_bids.dart';
import 'package:flutter_hr_management/organization_portal/company/all_user_list.dart';
import 'package:flutter_hr_management/organization_portal/company/buy_sell_list.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization_portal/company/load_list.dart';
import 'package:flutter_hr_management/organization_portal/get_city_list.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/all_users.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_buy_sell.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_discussion_screen.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_bids.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

class CompanyDashboard extends StatefulWidget {
  final Organization? organization;
  const CompanyDashboard(this.organization, {Key? key}) : super(key: key);

  @override
  _CompanyDashboardState createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  final orgProvider = locator<OrgProvider>();

  String? selectedFromCity;
  String? selectedToCity;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.organization?.id != null) {
      // Load default data once on screen load
      orgProvider.getUsersByCompanyId(widget.organization!.id!);
      orgProvider.getBuyVehicles(widget.organization!.id!);
      orgProvider.getStaticData(widget.organization!.id!);

      _loadAllRecords();
    }
  }

  Future<void> _loadAllRecords() async {
    if (widget.organization?.id == null) return;
    setState(() => isLoading = true);
    await orgProvider.getOrgFullLoadList(widget.organization!.id!);
    setState(() => isLoading = false);
  }

  Future<void> _searchRecords() async {
    if (widget.organization?.id == null) return;
    setState(() => isLoading = true);
    await orgProvider.getSearchByNameList(
      widget.organization!.id!,
      '',
      selectedFromCity ?? "",
      selectedToCity ?? "",
    );
    setState(() => isLoading = false);
  }

  void _onSearchButtonPressed() async {
    if ((selectedFromCity ?? "").isEmpty && (selectedToCity ?? "").isEmpty) {
      await _loadAllRecords();
    } else {
      await _searchRecords();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CompanySideBar(),
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgProvider>(
        builder: (context, model, child) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Row(
                  children: [
                    if (AppResponsive.isDesktop(context))
                      Expanded(child: CompanySideBar()),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          HeaderWidget(isSearchVisible: false, scaffoldKey: _scaffoldKey),
                          SizedBox(height: 35.h),

                          /// SEARCH BAR
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                            child: Row(
                              children: [
                                CustomSearchCityTextField(
                                  hintText: 'From',
                                  controller: selectedFromCity ?? "",
                                  onTap: () async {
                                    final value = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => GetCityList()),
                                    );
                                    if (value != null && value is List && value.isNotEmpty) {
                                      setState(() => selectedFromCity = value[0]?.toString());
                                    }
                                  },
                                ),
                                SizedBox(width: 25.w),
                                CustomSearchCityTextField(
                                  hintText: 'To',
                                  controller: selectedToCity ?? "",
                                  onTap: () async {
                                    final value = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => GetCityList()),
                                    );
                                    if (value != null && value is List && value.isNotEmpty) {
                                      setState(() => selectedToCity = value[0]?.toString());
                                    }
                                  },
                                ),
                                SizedBox(width: 25.w),
                                ElevatedButton(
                                  onPressed: _onSearchButtonPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CustomText("Search", style: Style.button),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35.h),

                          /// DASHBOARD CARDS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              getContainer("Total User", 0, model.allUserList.length.toString(),
                                  const Color(0xffEAF8F4), 'assets/org/total_users.svg'),
                              getContainer("Load Post", 1, model.fullLoadPostCount.toString(),
                                  const Color(0xffFFEDF9), 'assets/org/all_load.svg'),
                              getContainer("Buy Sell", 3, model.buySellPostCount.toString(),
                                  const Color(0xffFEF0E5), 'assets/org/buy_sell.svg'),
                              getContainer("All Quotes", 4, model.bidCont.toString(),
                                  const Color(0xffEDE8FF), 'assets/org/bid.svg'),
                            ],
                          ),
                          SizedBox(height: 35.h),

                          /// LIST VIEW
                          Expanded(
                            child: isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : LoadList(widget.organization!, index: 0), // <-- Use LoadList directly
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getContainer(
      String title, int value, String count, Color bgColor, String img) {
    return InkWell(
      onTap: () {
        if (widget.organization == null) return;

        // Switch between tabs (optional)
        switch (value) {
          case 0:
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => AllUsersList(widget.organization!),
            ));
            break;
          case 1:
            _loadAllRecords();
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => BuySellList(widget.organization!),
            ));
            break;
          case 4:
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => BidList(widget.organization!),
            ));
            break;
        }
      },
      child: Container(
        width: 243.w,
        height: 162.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 89.w,
              height: 89.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: const CircleBorder(),
              ),
              child: SvgPicture.asset(img, height: 50.h, width: 50.w),
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
                  fontSize: 20.sp,
                  color: const Color(0xff6C6C6C),
                  fontWeight: FontWeight.w300,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
