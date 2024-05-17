import 'package:flutter/material.dart';
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/all_users.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_buy_sell.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_discussion_screen.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_bids.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_general_post.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_jobs.dart';
import 'package:flutter_hr_management/organization_portal/company/jobs/job_list_screen.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/orgnaization_page/home_orgnization.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvertiseSideBar extends StatefulWidget {
  @override
  _AdvertiseSideBarState createState() => _AdvertiseSideBarState();
}

class _AdvertiseSideBarState extends State<AdvertiseSideBar> {
  static bool isHomeAdv = false;
  static bool isSaveAdv = false;
  static bool isComapnyAdv = true;
  static bool isUserAdv = false;
  final advProvider = locator<AdvProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advProvider.getCtmsOrganization();
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
           /* InkWell(
              onTap: (){
                isHomeAdv = false;
                isSaveAdv = false;
                isComapnyAdv = true;
                isUserAdv = false;
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
                height: 47.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ThemeColor.baground,
                    borderRadius: BorderRadius.circular(0.r)
                ),
                child: Text("Go Back",style:TextStyle(
                  fontSize: 16.sp,
                  fontFamily:
                  GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ),*/
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    height: 77.h,
                    width: 133.w,
                  )),
            ),
            SizedBox(
              height: 47.h,
            ),
           /* DrawerListTile(
              isSelect: isHomeAdv,
              title: "Dashboard",
              icon: "assets/menu/dashboard_menu.svg",
              press: () {
                isHomeAdv = true;
                isSaveAdv = false;
                isComapnyAdv = false;
                isUserAdv = false;

                setState(() {});
                Navigator.restorablePushReplacementNamed(context,AppRoutes.advertise_home);

              },
            ),*/
            DrawerListTile(
              isSelect: isComapnyAdv,
              title: "All Advertise",
              icon: "assets/org/all_users.svg",
              press: () {
                isHomeAdv = false;
                isSaveAdv = false;
                isUserAdv = false;
                isComapnyAdv = true;
                setState(() {});
                Navigator.restorablePushReplacementNamed(context,AppRoutes.org_advertise);
              },
            ),
            DrawerListTile(
              isSelect: isUserAdv,
              title: "My Advertise",
              icon: "assets/org/buy_sell.svg",
              press: () {
                isHomeAdv = false;
                isUserAdv = true;
                isSaveAdv = false;
                isComapnyAdv = false;

                setState(() {});
                 Navigator.restorablePushReplacementNamed(context,AppRoutes.my_advertise);

              },
            ),
            DrawerListTile(
              isSelect: isSaveAdv,
              title: "Pay Advertise",
              icon: "assets/org/buy_sell.svg",
              press: () {
                isHomeAdv = false;
                isSaveAdv = true;
                isComapnyAdv = false;
                isUserAdv = false;

                setState(() {});
                 Navigator.restorablePushReplacementNamed(context,AppRoutes.save_advertise);
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        await LocalSharePreferences().logOut();
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.entry, (route) => false);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Do you want to log out"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*Organization? organization;
  final orgProvider = locator<OrgProvider>();

  Future<void> getOrganization() async {
    organization = await orgProvider.getOrgDetails();
  }*/
}

class DrawerListTile extends StatelessWidget {
  final String? title, icon;
  final VoidCallback? press;
  final bool isSelect;

  const DrawerListTile(
      {Key? key, this.title, this.icon, this.press, required this.isSelect})
      : super(key: key);

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
              SizedBox(
                width: 33.w,
              ),
              SvgPicture.asset(
                icon!,
                color: isSelect ? AppColor.white : Colors.grey,
                height: 25.h,
                width: 25.w,
              ),
              SizedBox(
                width: 27.w,
              ),
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
