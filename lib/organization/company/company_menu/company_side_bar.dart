import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/company/company_menu/all_users.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_buy_sell.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_discussion_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_bids.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';



class CompanySideBar extends StatefulWidget {
  @override
  _CompanySideBarState createState() => _CompanySideBarState();
}

class _CompanySideBarState extends State<CompanySideBar> {

  static bool  isDashbord=true;
  static bool isAllUser=false;
  static bool isFullLoad=false;
  static bool isBuySell=false;
  static bool isDiscussion=false;
  static bool isBid=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrganization();
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
            SizedBox(height: 47.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(child: SvgPicture.asset("assets/logo.svg",height: 77.h,width: 133.w,)),
            ),
            SizedBox(height: 47.h,),
            DrawerListTile(
              isSelect: isDashbord,
              title: "Dashboard",
              icon: "assets/menu/dashboard_menu.svg",
              press: () {
                isDashbord=true;
                isAllUser=false;
                isFullLoad=false;
                isDiscussion=false;
                isBuySell = false;
                isBid=false;
                setState(() {
                });
                //Navigator.restorablePushReplacementNamed(context,AppRoutes.crm);
                Navigator.of(context).restorablePush((context, arguments) => MaterialPageRoute(builder: (builder)=>CompanyDashboard(organization[0])));
              },
            ),
            DrawerListTile(
              isSelect: isAllUser,
              title: "All Users",
              icon: "assets/org/all_users.svg",
              press: () {
                isDashbord=false;
                isAllUser=true;
                isBuySell = false;
                isFullLoad=false;
                isDiscussion=false;
                isBid=false;
                setState(() {
                });
              //  Navigator.restorablePushReplacementNamed(context,AppRoutes.employee_dashbord);
                Navigator.of(context).restorablePushReplacement((context, arguments) => MaterialPageRoute(builder: (builder)=>AllUsers(organization[0])));
              },
            ),
            DrawerListTile(
              isSelect: isFullLoad,
              title: "Full Load",
              icon: "assets/org/full_load.svg",
              press: () {
                isDashbord=false;
                isBuySell = false;
                isAllUser=false;
                isFullLoad=true;
                isDiscussion=false;
                isBid=false;
                setState(() {
                });
               // Navigator.restorablePushReplacementNamed(context,AppRoutes.lead_dashbord);
                Navigator.of(context).restorablePush((context, arguments) => MaterialPageRoute(builder: (builder)=>CompLoadScreen(organization[0])));
              },
            ),
            DrawerListTile(
              isSelect: isBuySell,
              title: "Buy & Sell",
              icon: "assets/org/buy_sell.svg",
              press: () {
                isDashbord=false;
                isAllUser=false;
                isFullLoad=false;
                isDiscussion=false;
                isBuySell = true;
                isBid=false;
                setState(() {
                });
                Navigator.of(context).restorablePush((context, arguments) => MaterialPageRoute(builder: (builder)=>CompBuySell(organization[0])));
              //  Navigator.restorablePushReplacementNamed(context,AppRoutes.meeting);
              },
            ),
            DrawerListTile(
              isSelect: isDiscussion,
              title: "Discussion",
              icon: "assets/org/discussion.svg",
              press: () {
                isDashbord=false;
                isAllUser=false;
                isFullLoad=false;
                isDiscussion=true;
                isBuySell = false;
                isBid=false;
                setState(() {
                });
                Navigator.of(context).restorablePush((context, arguments) => MaterialPageRoute(builder: (builder)=>CompDiscussionScreen(organization[0])));
               // Navigator.restorablePushReplacementNamed(context,AppRoutes.customer);
              },
            ),
            DrawerListTile(
              isSelect: isBid,
              title: "Bid",
              icon: "assets/org/bid.svg",
              press: () {
                isDashbord=false;
                isAllUser=false;
                isBuySell = false;
                isFullLoad=false;
                isDiscussion=false;
                isBid=true;
                setState(() {
                });
                Navigator.of(context).restorablePush((context, arguments) => MaterialPageRoute(builder: (builder)=>CompanyBidsScreen(organization[0])));
              //  Navigator.restorablePushReplacementNamed(context, AppRoutes.report);
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
      onPressed: () async{
        await LocalSharePreferences().logOut();
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.entry, (route) => false) ;
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
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Organization> organization=[];
  final orgProvider = locator<OrgProvider>();
  Future<void> getOrganization() async {
    organization = await orgProvider.getCompanyDetails(26);
  }
}


class DrawerListTile extends StatelessWidget {
  final String? title, icon;
  final VoidCallback? press;
  final bool isSelect;

  const DrawerListTile({Key? key, this.title, this.icon, this.press, required this.isSelect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,

      title: Container(
        width: 232.w,
        height: 74.h,
        decoration:isSelect? ShapeDecoration(
          color: Color(0xFFC3262C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ): ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 33.w,),
              SvgPicture.asset(
                icon!,
                color: isSelect?AppColor.white:Colors.grey,
                height: 25.h,
                width: 25.w,
              ),
              SizedBox(width: 27.w,),
              Text(
                title!,
                style: isSelect?TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ):TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
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
