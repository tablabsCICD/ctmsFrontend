import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width,
     height: 111.h,
       color: Colors.white,
     child: Container(
       width: MediaQuery.of(context).size.width,
       color: Colors.white,
       margin: EdgeInsets.all(20),
       child: Row(
         children: [
           SvgPicture.asset("assets/logo.svg",height:77.h ,width: 132.w,),
           Container(
             width: 414,
             height: 63,
             decoration: ShapeDecoration(
               color: Color(0xFFF6F6F6),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(43),
               ),
             ),
           ),

           Container(
             height: 46.h,
             width:46.w,
             decoration: ShapeDecoration(
               color: Color(0xFFF6F6F6),
               shape: OvalBorder(),
             ),

             child: SvgPicture.asset("assets/notification.svg",color: Colors.black,height: 27.h,width: 25.w,),
           )
           
         ],
         






       ),

     )
   );
  }

}