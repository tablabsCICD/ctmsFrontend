import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_dashboard.dart';
import 'package:flutter_hr_management/organization/company/company_menu_page.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/orgnaization_page/side_bar_orgnization.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../constant/images.dart';
import '../dashboard/widget/header_widget.dart';

class HomeOrganizationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeOrganizationScreen();
  }

}
class _HomeOrganizationScreen extends State<HomeOrganizationScreen>{
  final orgProvider = locator<OrgProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
    drawer: SideBarOrganization(),
    backgroundColor: AppColor.bgColor,
     body: SafeArea(
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           /// Side Navigation Menu
           /// Only show in desktop
           if (AppResponsive.isDesktop(context))
             Expanded(
               child: SideBarOrganization(),
             ),

           /// Main Body Part
           Expanded(
             flex: 4,
             child: Column(
               children: [
                 HeaderWidget(),
                 SizedBox(height: 38.h,),
                 Container(
                   color:  AppColor.bgColor,
                   // margin: EdgeInsets.all(10),
                   child: Row(
                     children: [
                       SizedBox(width: 38.w,),
                   InkWell(onTap: () async {
                     List<Organization> organization = await orgProvider.getCompanyDetails(26);
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (builder) =>
                                 CompanyDashboard(organization[0])));
                    /* {id: 26, companyName: Skillup, companyAddress: Pune, isVerified: 0, website: www.skillup.com, landlineNumber: 020336677, companyMobileNumber: 8379939930, pointOfContact: Navale, gstNumber: 123456789, gstNumber2: 123456789, typeOfRegistration: Private Ltd., panCardNumber: CHI5789H, tanCardNumber: CHI5789H, officialEmailId: skillup@gmail.com, rating: 5, numberOfRatings: 5, city: Pune, state: Maharastra, otp: }, {id: 41, companyName: abcd, companyAddress: pune, isVerified: 0, website: www.abcd.com, landlineNumber: 123456, companyMobileNumber: 8379939930, pointOfContact: swati, gstNumber: 12345, gstNumber2: "https://s3.ap-south-1.amazonaws.com//tkd-profile/profileImages//1675949056174-aadhar.jpg", typeOfRegistration: One Person Company, panCardNumber: 123456, tanCardNumber: 123456, officialEmailId: swatibahir@gmail.com, rating: 5, numberOfRatings: 1, city: Pune, state: Maharastra, otp: null}*/
                   //  Navigator.pushNamed(context, AppRoutes.org);
                   },
                      child: empCounts("0","Monitoring",Images.monitoring,Color(0xFFEAF8F4)),),
                       SizedBox(width: 38.w,),
                       InkWell(onTap: (){
                         Navigator.pushNamed(context, AppRoutes.crm);
                       },child: empCounts("0","CRM",Images.crm,Color(0xFFFFEDF9)),),
                       SizedBox(width: 38.w,),
                       empCounts("0","HRM",Images.hrm,Color(0xFFFEF0E5)),
                     ],
                   ),
                 ),
                 SizedBox(height: 38.h,),
                 Container(
                   // margin: EdgeInsets.all(10),
                   child: Row(
                     children: [
                       SizedBox(width: 38.w,),
                       empCounts("0","E-Invoices",Images.invoice,Color(0xFFEAF8F4)),
                       SizedBox(width: 38.w,),
                       empCounts("0","E-Bilty",Images.bilty,Color(0xFFFFEDF9)),
                       SizedBox(width: 38.w,),
                      // empCounts("0","Inactive Employee",Images.emp_tot,Color(0xFFFEF0E5)),
                     ],
                   ),
                 )
               ],
             ),
           ),
         ],
       ),
     ),


   );
  }

  empCounts(String totCount,String name,String image,Color color){
    return Container(
      width: 329.w,
      height: 166.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.white),
          borderRadius: BorderRadius.circular(10),

        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 108.w,
              height: 110.h,
              decoration: ShapeDecoration(
                color: color,//Color(0xFFEAF8F4)
                shape: CircleBorder(),

              ),
              child: Padding(
                padding:  EdgeInsets.all(20.0),
                child: SvgPicture.asset(image,height: 10.h,width: 10.w,color: Colors.black,),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                  )
              )
            ],
          )
        ],
      ),
    );
  }

}