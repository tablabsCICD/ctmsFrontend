import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/sharepreferences.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

 static bool  isDashbord=true;
 static bool isEmp=false;
 static bool isLead=false;
 static bool isMeeting=false;
 static bool isreport=false;
 static bool isProfile=false;

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
              icon: "assets/menu_home.png",
              press: () {
                 isDashbord=true;
                 isEmp=false;
                 isLead=false;
                 isMeeting=false;
                 isreport=false;
                 isProfile=false;
                 setState(() {

                 });
                Navigator.restorablePushReplacementNamed(context,AppRoutes.home);

              },
            ),
            DrawerListTile(
              isSelect: isEmp,
              title: "Employee",
              icon: "assets/menu_recruitment.png",
              press: () {
                isDashbord=false;
                isEmp=true;
                isLead=false;
                isMeeting=false;
                isreport=false;
                isProfile=false;
                setState(() {

                });
                Navigator.restorablePushReplacementNamed(context,AppRoutes.employee_dashbord);
              },
            ),
            DrawerListTile(
              isSelect: isLead,
              title: "Leads",
              icon: "assets/menu_onboarding.png",
              press: () {
                isDashbord=false;
                isEmp=false;
                isLead=true;
                isMeeting=false;
                isreport=false;
                isProfile=false;
                setState(() {

                });
                Navigator.restorablePushReplacementNamed(context,AppRoutes.lead_dashbord);
              },
            ), DrawerListTile(
              isSelect: isMeeting,
              title: "Meetings",
              icon: "assets/menu_onboarding.png",
              press: () {
                isDashbord=false;
                isEmp=false;
                isLead=false;
                isMeeting=true;
                isreport=false;
                isProfile=false;
                setState(() {

                });


                Navigator.restorablePushReplacementNamed(context,AppRoutes.meeting);
              },
            ),
            DrawerListTile(
              isSelect: isreport,
              title: "Reports",
              icon: "assets/menu_report.png",
              press: () {
                isDashbord=false;
                isEmp=false;
                isLead=false;
                isMeeting=false;
                isreport=true;
                isProfile=false;
                setState(() {

                });

                Navigator.restorablePushReplacementNamed(context, AppRoutes.report);
              },
            ),
            DrawerListTile(
              isSelect: isProfile,
              title: "Profile",
              icon: "assets/menu_calendar.png",
              press: () {

                isDashbord=false;
                isEmp=false;
                isLead=false;
                isMeeting=false;
                isreport=false;
                isProfile=true;
                setState(() {

                });
                Navigator.restorablePushReplacementNamed(context, AppRoutes.profile);
              },
            ),
            DrawerListTile(
              isSelect: false,
              title: "Log Out",
              icon: "assets/menu_settings.png",
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
              Image.asset(
                icon!,
                color: AppColor.white,
                height: 16,
              ),
              SizedBox(width: 27.w,),
              Text(
                title!,
                style: isSelect?TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
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
