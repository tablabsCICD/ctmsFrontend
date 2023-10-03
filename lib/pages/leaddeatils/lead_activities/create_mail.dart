import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/calender_widget.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../../utils/constant.dart';

class CreateMail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateMail();
  }


}

class _CreateMail extends State<CreateMail>{
  TextEditingController toNameController=TextEditingController();
  TextEditingController subjectController=TextEditingController();
  TextEditingController mailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 848.h,
            width: 361.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              children: [
                SizedBox(height: 500.h,),
                SizedBox(
                  height: 86.h,
                  width: 308.w,
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          primary: ThemeColor.theme_blue,
                          onPrimary: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle,size:35,),
                          SizedBox(width: 6.w,),
                          TextView(
                            title: "Create Mail",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400, color: Colors.white,
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(width: 48.w,),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: 522.w,
                height: 67.h,
                decoration: ShapeDecoration(
                  color: Color(0xFF102C54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),

                child: Row(
                  children: [
                    Text(
                      'Create email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    )

                  ],
                ),

              ),
              Container(
                width: 522.w,
                height: 800.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),


                  ),

                ),
                child: createReminder(context),
              )
            ],
          ),
          SizedBox(width: 60.w,),
          Container(
              height: 439.h,
              width: 382.w,
              child: CalendarWidget()),
        ],
      ),
    );
  }



  createReminder(context){
    return Container(
      width: 522.w,
      height: 848.h,
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
            _buildTextField("Send To",toNameController),
            SizedBox(height: 15.h,),
            _buildTextField("Subject",subjectController),
            SizedBox(height: 15.h,),
            Container(
                height: 120,
                child: _buildTextField("Mail",mailController)),
            SizedBox(height: 15.h,),
            InkWell(
              onTap: (){
                callAPI();

              },
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

  void callAPI() async{

    Dio dio = Dio();
    var response = await dio.post(
        "http://ec2-13-235-70-174.ap-south-1.compute.amazonaws.com:8080/crm/api/Employee/SendEmailRemainder", queryParameters: {
      "message": mailController.text.toString(),
      "emailId": toNameController.text.toString(),
      "subject": subjectController.text.toString()
    });
    print('the body ${response.data}');
    if (response.statusCode == 200) {

    }

    // print('${mailController.text.isEmpty}');
    //
    // if(mailController.text.toString().isEmpty==false) {
    //   if (toNameController.text.toString().isEmpty==false) {
    //     if (subjectController.text.toString().isEmpty==false) {
    //
    //     } else {
    //       ToastMessage.show(context, "Please enter subject");
    //     }
    //   } else {
    //     ToastMessage.show(context, "Please enter send to ");
    //   }
    // }
    // else{
    //   ToastMessage.show(context, "Please enter mail");
    // }



  }

}