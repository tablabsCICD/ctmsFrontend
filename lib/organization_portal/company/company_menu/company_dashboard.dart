import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization_portal/company/all_bids.dart';
import 'package:flutter_hr_management/organization_portal/company/all_user_list.dart';
import 'package:flutter_hr_management/organization_portal/company/buy_sell_list.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/load_list.dart';
import 'package:flutter_hr_management/organization_portal/get_city_list.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';

import '../../../common/app_responsive.dart';

class CompanyDashboard extends StatefulWidget {
  final Organization? organization;

  const CompanyDashboard(this.organization, {Key? key}) : super(key: key);

  @override
  _CompanyDashboardState createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  final orgProvider = locator<OrgProvider>();
  final compBuySellProvider = locator<CompBuySellProvider>();
  String? selectedFromCity;
  String? selectedToCity;
  bool isLoading = false;
  int selectedTabIndex = 1; // default to "Load Post"
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.organization?.id != null) {
        _initializeDashboard();
      }
    });
  }

  /// Reusable loader wrapper
  Future<void> _withLoader(Future<void> Function() apiCall) async {
    try {
      setState(() => isLoading = true);
      await apiCall();
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// Initial API calls on dashboard load
  Future<void> _initializeDashboard() async {
    await _withLoader(() async {
      await orgProvider.getStaticData(widget.organization!.id!);
      await compBuySellProvider.getBuyVehicles(widget.organization!.id!);
    });
  }

  Future<void> _loadAllRecords() async {
    if (widget.organization?.id == null) return;
    await _withLoader(() => orgProvider.getOrgFullLoadList(widget.organization!.id!, currentPage: 0));
  }

  Future<void> _searchRecords() async {
    if (widget.organization?.id == null) return;
    await _withLoader(() => orgProvider.getSearchByNameList(
      widget.organization!.id!,
      '',
      selectedFromCity ?? "",
      selectedToCity ?? "",
    ));
  }

  Future<void> _getBuyVehicles() async {
    if (widget.organization?.id == null) return;
    await _withLoader(() => compBuySellProvider.getBuyVehicles(widget.organization!.id!));
  }

  @override
  Widget build(BuildContext context) {
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
                    if (AppResponsive.isDesktop(context)) Expanded(child: CompanySideBar()),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          HeaderWidget(isSearchVisible: false, scaffoldKey: _scaffoldKey),
                          SizedBox(height: 35.h),

                          /// DASHBOARD CARDS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              getContainer("Total User", 0, model.userCount.toString(),
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

                          Expanded(
                            child: isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : Builder(
                              builder: (context) {
                                switch (selectedTabIndex) {
                                  case 0:
                                    return AllUsersList(widget.organization!);
                                  case 1:
                                    return LoadList(widget.organization!, index: 0);
                                  case 3:
                                    return BuySellList(widget.organization!);
                                  case 4:
                                    return BidList(widget.organization!);
                                  default:
                                    return LoadList(widget.organization!, index: 0);
                                }
                              },
                            ),
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

  Widget getContainer(String title, int value, String count, Color bgColor, String img) {
    return InkWell(
      onTap: () async {
        // Only change the tab index after the API call
        switch (value) {
          case 1: // Load Post
            await _loadAllRecords();
            break;
          case 3: // Buy Sell
            await _getBuyVehicles();
            break;
          case 0: // Total User
          case 4: // All Quotes
          // Add API calls if needed
            break;
        }

        // Update selectedTabIndex AFTER API call to avoid double loader
        setState(() {
          selectedTabIndex = value;
        });
      },
      child: Container(
        width: 243.w,
        height: 162.h,
        decoration: ShapeDecoration(
          color: selectedTabIndex == value ? Colors.blue.shade50 : Colors.white,
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
