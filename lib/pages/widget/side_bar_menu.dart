import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
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
 static bool isShortLead=false;
 static bool isCustomer=false;
 static bool isMeeting=false;
 static bool isreport=false;
 static bool isProfile=false;
 static bool isEmpReport=false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
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
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(child: SvgPicture.asset("assets/logo.svg",height: 77.h,width: 133.w,)),
              ),

              SizedBox(height: 30.h,),
              DrawerListTile(
                isSelect: isDashbord,
                title: "Dashboard",
                icon: "assets/menu/dashboard_menu.svg",
                press: () {
                   isDashbord=true;
                   isEmp=false;
                   isLead=false;
                   isMeeting=false;
                   isCustomer = false;
                   isreport=false;
                   isProfile=false;
                   isEmpReport=false;
                   isShortLead = false;
                   setState(() {

                   });
                  Navigator.restorablePushReplacementNamed(context,AppRoutes.crm);

                },
              ),
              DrawerListTile(
                isSelect: isEmp,
                title: "Employee",
                icon: "assets/menu/emp_menu.svg",
                press: () {
                  isDashbord=false;
                  isEmp=true;
                  isCustomer = false;
                  isLead=false;
                  isMeeting=false;
                  isreport=false;
                  isProfile=false;
                  isEmpReport=false;
                  isShortLead = false;
                  setState(() {

                  });
                  Navigator.restorablePushReplacementNamed(context,AppRoutes.employee_dashbord);
                },
              ),
              DrawerListTile(
                isSelect: isLead,
                title: "Leads",
                icon: "assets/menu/lead_menu.svg",
                press: () {
                  isDashbord=false;
                  isCustomer = false;
                  isEmp=false;
                  isLead=true;
                  isMeeting=false;
                  isreport=false;
                  isEmpReport=false;
                  isProfile=false;
                  isShortLead = false;
                  setState(() {

                  });
                  Navigator.restorablePushReplacementNamed(context,AppRoutes.lead_dashbord);
                },
              ),
              DrawerListTile(
                isSelect: isShortLead,
                title: "Short Leads",
                icon: "assets/menu/lead_menu.svg",
                press: () {
                  isDashbord=false;
                  isCustomer = false;
                  isEmp=false;
                  isLead=false;
                  isShortLead = true;
                  isMeeting=false;
                  isreport=false;
                  isEmpReport=false;
                  isProfile=false;
                  setState(() {

                  });
                  Navigator.restorablePushReplacementNamed(context,AppRoutes.shortLead_dashbord);
                },
              ),
              DrawerListTile(
                isSelect: isMeeting,
                title: "Meetings",
                icon: "assets/menu/meeting_menu.svg",
                press: () {
                  isDashbord=false;
                  isEmp=false;
                  isLead=false;
                  isMeeting=true;
                  isCustomer = false;
                  isreport=false;
                  isEmpReport=false;
                  isProfile=false;
                  isShortLead = false;
                  setState(() {

                  });


                  Navigator.restorablePushReplacementNamed(context,AppRoutes.meeting);
                },
              ),
              DrawerListTile(
                isSelect: isCustomer,
                title: "Customer",
                icon: "assets/menu/customer_menu.svg",
                press: () {
                  isDashbord=false;
                  isEmp=false;
                  isLead=false;
                  isMeeting=false;
                  isCustomer = true;
                  isreport=false;
                  isEmpReport=false;
                  isShortLead = false;
                  isProfile=false;
                  setState(() {

                  });


                  Navigator.restorablePushReplacementNamed(context,AppRoutes.customer);
                },
              ),
              DrawerListTile(
                isSelect: isreport,
                title: "Reports",
                icon: "assets/menu/report_menu.svg",
                press: () {
                  isDashbord=false;
                  isEmp=false;
                  isCustomer = false;
                  isLead=false;
                  isMeeting=false;
                  isreport=true;
                  isEmpReport=false;
                  isShortLead = false;
                  isProfile=false;
                  setState(() {

                  });

                  Navigator.restorablePushReplacementNamed(context, AppRoutes.report);
                },
              ),
              DrawerListTile(
                isSelect: isEmpReport,
                title: "Employee Reports",
                icon: "assets/menu/report_menu.svg",
                press: () {
                  isDashbord=false;
                  isEmp=false;
                  isCustomer = false;
                  isLead=false;
                  isMeeting=false;
                  isreport=false;
                  isEmpReport = true;
                  isShortLead = false;
                  isProfile=false;
                  setState(() {
                  });
                  Navigator.restorablePushReplacementNamed(context, AppRoutes.empReport);
                },
              ),
              DrawerListTile(
                isSelect: isProfile,
                title: "Profile",
                icon: "assets/menu/profile_menu.svg",
                press: () {

                  isDashbord=false;
                  isEmp=false;
                  isCustomer = false;
                  isLead=false;
                  isMeeting=false;
                  isreport=false;
                  isEmpReport=false;
                  isShortLead = false;
                  isProfile=true;
                  setState(() {

                  });
                  Navigator.restorablePushReplacementNamed(context, AppRoutes.profile);
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
        height: 65.h,
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
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ):TextStyle(
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
