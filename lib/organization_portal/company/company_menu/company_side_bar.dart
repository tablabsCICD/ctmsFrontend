import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constant/images.dart';
import '../../company/company_menu/all_users.dart';
import '../../company/company_menu/comp_buy_sell.dart';
import '../../company/company_menu/comp_full_load.dart';
import '../../company/company_menu/company_bids.dart';
import '../../company/company_menu/company_dashboard.dart';
import '../../company/company_menu/company_general_post.dart';
import '../../company/company_menu/company_jobs.dart';
import '../../company/company_menu/company_news.dart';

class CompanySideBar extends StatefulWidget {
  @override
  _CompanySideBarState createState() => _CompanySideBarState();
}

class _CompanySideBarState extends State<CompanySideBar> {
  static bool isDashbord = true;
  static bool isAllUser = false;
  static bool isFullLoad = false;
  static bool isBuySell = false;
  static bool isDiscussion = false;
  static bool isJob = false;
  static bool isGeneralPost = false;
  static bool isBid = false;
  static bool isNews = false;

  Organization? organization;

  @override
  void initState() {
    super.initState();
    _loadOrganization();
  }

  Future<void> _loadOrganization() async {
    final orgProv = locator<OrgProvider>();

    await orgProv.loadOrgFromLocal();

    if (orgProv.org == null) {
      await orgProv.getCtmsOrganization();
    }

    if (mounted) {
      setState(() {
        organization = orgProv.org;
      });
    }

    if (organization == null && mounted) {
      ToastMessage.show(
        context,
        "No organisation found. Please contact admin.",
      );
    } else {
      debugPrint(
          "✅ Organization Loaded: ${organization!.id}, ${organization!.companyName}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // listen to provider updates too
    final org = context.watch<OrgProvider>().org ?? organization;

    if (org == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _goBackButton(context),
              _logoHeader(),
              SizedBox(height: 47.h),
              DrawerListTile(
                isSelect: isDashbord,
                title: "Dashboard",
                icon: "assets/menu/dashboard_menu.svg",
                press: () => _navigate(context, CompanyDashboard(org), 'dashboard'),
              ),
              DrawerListTile(
                isSelect: isAllUser,
                title: "All Users",
                icon: "assets/org/all_users.svg",
                press: () => _navigate(context, AllUsers(org), 'users'),
              ),
              DrawerListTile(
                isSelect: isFullLoad,
                title: "Full Load",
                icon: "assets/org/full_load.svg",
                press: () => _navigate(context, CompLoadScreen(org), 'fullLoad'),
              ),
              DrawerListTile(
                isSelect: isBuySell,
                title: "Buy & Sell",
                icon: "assets/org/buy_sell.svg",
                press: () => _navigate(context, CompBuySell(org), 'buySell'),
              ),
              DrawerListTile(
                isSelect: isBid,
                title: "Quote",
                icon: "assets/org/bid.svg",
                press: () => _navigate(context, CompanyBidsScreen(org), 'bid'),
              ),
              DrawerListTile(
                isSelect: isJob,
                title: "Jobs",
                icon: "assets/org/job.svg",
                press: () => _navigate(context, CompJobsScreen(org), 'job'),
              ),
              DrawerListTile(
                isSelect: isGeneralPost,
                title: "General Post",
                icon: "assets/org/directory.svg",
                press: () => _navigate(context, GeneralPostScreen(org), 'post'),
              ),
              DrawerListTile(
                isSelect: isNews,
                title: "All News",
                icon: "assets/org/directory.svg",
                press: () => _navigate(context, NewsScreen(org), 'news'),
              ),
              DrawerListTile(
                isSelect: false,
                title: "Log Out",
                icon: "assets/menu/logout_menu.svg",
                press: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget page, String menu) {
    setState(() {
      isDashbord = menu == 'dashboard';
      isAllUser = menu == 'users';
      isFullLoad = menu == 'fullLoad';
      isBuySell = menu == 'buySell';
      isBid = menu == 'bid';
      isJob = menu == 'job';
      isGeneralPost = menu == 'post';
      isNews = menu == 'news';
    });
    Navigator.of(context).restorablePush((context, arguments) =>
        MaterialPageRoute(builder: (builder) => page));
  }

  Widget _goBackButton(BuildContext context) => InkWell(
    onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 47.h,
      width: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ThemeColor.baground,
        borderRadius: BorderRadius.circular(0.r),
      ),
      child: Text(
        "Go Back",
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  Widget _logoHeader() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Center(
      child: SvgPicture.asset(
       // "assets/logo.svg",
        Images.logo,
        height: 77.h,
        width: 133.w,
      ),
    ),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Log Out"),
        content: const Text("Do you want to log out?"),
        actions: [
          TextButton(
            onPressed: () async {
              await LocalSharePreferences().logOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.entry,
                    (route) => false,
              );
            },
            child: const Text("Ok"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
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
        decoration: ShapeDecoration(
          color: isSelect ? const Color(0xFFC3262C) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon!,
              color: isSelect ? AppColor.white : Colors.grey,
              height: 25.h,
              width: 25.w,
            ),
            SizedBox(width: 27.w),
            Text(
              title!,
              style: TextStyle(
                color: isSelect ? Colors.white : Colors.black,
                fontSize: 18.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
