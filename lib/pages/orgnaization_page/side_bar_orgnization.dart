import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/sharepreferences.dart';

class SideBarOrganization extends StatefulWidget {
  @override
  _SideBarOrganization createState() => _SideBarOrganization();
}

class _SideBarOrganization extends State<SideBarOrganization> {

  static bool  isDashbord=true;
  static bool isEmp=false;
  static bool isLead=false;
  static bool isCustomer=false;
  static bool isMeeting=false;
  static bool isreport=false;
  static bool isProfile=false;
  final orgProvider = locator<OrgProvider>();

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


              },
            ),
            DrawerListTile(
              isSelect: isEmp,
              title: "Monitoring",
              icon: Images.monitoring,
              press: () async {
                Organization organization = await orgProvider.getOrgDetails();
                print(organization.companyName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            CompanyDashboard(organization)));
              },
            ),
            DrawerListTile(
              isSelect: isLead,
              title: "CRM",
              icon: Images.crm,
              press: () {
                Navigator.pushNamed(context, AppRoutes.crm);
              },
            ), DrawerListTile(
              isSelect: isMeeting,
              title: "HRM",
              icon: Images.hrm,
              press: () async {
                final url =Uri.parse("http://tkd-hrms.s3-website.ap-south-1.amazonaws.com/hrm/employee");
                if (!await launchUrl(url,)) {
                throw Exception('Could not launch $url');
                }
              },
            ),
            DrawerListTile(
              isSelect: isCustomer,
              title: "E-Invoices",
              icon: Images.invoice,
              press: () {

              },
            ),
            DrawerListTile(
              isSelect: isreport,
              title: "E-Bilty",
              icon: Images.bilty,
              press: () async {
                final url =Uri.parse("http://tkd-bilty.s3-website.ap-south-1.amazonaws.com/create-loading");
                if (!await launchUrl(url,)) {
                throw Exception('Could not launch $url');
                }
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