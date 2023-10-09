import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/orgnaization/side_bar_orgnization.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
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
                       empCounts("0","Monitoring",Images.monitoring,Color(0xFFEAF8F4)),
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