import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../dashboard/widget/calender_widget.dart';

class CreateReminder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      color:Color(0xffF6F6F6) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 220.w,
            child: Text(
              'Create Reminder',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createReminder(context),
              SizedBox(width: 10.w,),
              Container(
                  height: 500.h,
                  width: 400.w,
                  child: CalendarWidget()),
            ],
          ),

        ],


      ),

    );
  }

  createReminder(context){
    return Container(
      width: 600.h,
      height: 500.h,
      padding: EdgeInsets.all(20),

      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      child: Center(

        child: Column(

          children: [
            _buildTextField("Select Date",TextEditingController()),
            SizedBox(height: 15.h,),
            _buildTextField("Select Time",TextEditingController()),
            SizedBox(height: 15.h,),
            _buildTextField("Add Employee",TextEditingController()),
            SizedBox(height: 15.h,),
            InkWell(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.yellow,
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),

                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.black),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }



}