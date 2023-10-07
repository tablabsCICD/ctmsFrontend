import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../dashboard/widget/calender_widget.dart';

class LeadReminder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      color:Color(0xffF6F6F6) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 220.w,
                child: Text(
                  'Reminder',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 100.w,
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          listTile(context),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listTile(context),
              SizedBox(width: 10.w,),
              Container(
                  height: 500.h,
                  width: 400.w,
                  child: CalendarWidget()),
            ],
          ),*/

        ],


      ),

    );
  }

  listTile(context){
    return Container(
     // width: MediaQuery.of(context).size.width-600.h,
      height: 124.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      child: Center(
        child: ListTile(

          leading:  getImage('',height: 30.h,width: 30.w),
          title: Text(
            'You have meeting with vivek within 1hr',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),

          trailing:  SizedBox(
            width: 300.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today, 01:00 PM ',
                  style: TextStyle(
                    color: Color(0xFF858585),
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SvgPicture.asset('assets/notification.svg',color:Colors.black,width: 20.w,height: 20.h,),
                SvgPicture.asset('assets/more_icon.svg',width: 20.w,height: 20.h,)
              ],
            ),
          ),


        ),
      ),
    );
  }






}