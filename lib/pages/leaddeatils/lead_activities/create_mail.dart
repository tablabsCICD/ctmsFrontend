import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/calender_widget.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_colors.dart';
import '../../../model/response/lead_list.dart';
import '../../../utils/constant.dart';

class CreateMail extends StatefulWidget {
  bool onlyMail;
  Lead? lead;

  CreateMail({Key? key, required this.onlyMail,this.lead}) : super(key: key);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    toNameController.text = widget.lead!.emailId!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.onlyMail==true?570.w: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         widget.onlyMail==true?SizedBox.shrink() :Container(
            height: 848.h,
            width: 361.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/images/img2.svg',height: 500.h,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextView(
                    title: 'Writing good emails is tough.Finding out when, and what to write is even tougher.',
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 40.h,),
                TextView(
                  title: 'GET READY!',
                  fontSize: 20.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 30.h,),
                SizedBox(
                  height: 86.h,
                  width: 308.w,
                  child: ElevatedButton(
                      onPressed: () async {

                      },
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
          widget.onlyMail==true?SizedBox.shrink() : SizedBox(width: 48.w,),
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
                    widget.onlyMail==true?IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back,color: Colors.white,)):SizedBox.shrink(),
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
          widget.onlyMail==true?SizedBox.shrink() : SizedBox(width: 60.w,),
          widget.onlyMail==true?SizedBox.shrink() : Container(
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
                    color: ThemeColor.theme_blue,
                    borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20.w,
                ),

                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColor.white),
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
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
           // labelText: label,
            hintText: label,
            labelStyle: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w300),
            hintStyle: TextStyle(color: Color(0xffcccccc),fontSize: 13.sp,fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  void callAPI() async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show(status: "Loading");
    Map<String,dynamic> parameter={
      "emailId": toNameController.text,
      "subject": subjectController.text,
      "message": mailController.text,
    };
    print(parameter);
    var data= jsonEncode(parameter);
    Dio dio=Dio();
    print(ApiConstant.CREATE_MAIL);
    var response=await dio.post(ApiConstant.CREATE_MAIL+"?emailId=${toNameController.text}&subject=${subjectController.text}&message=${mailController.text}",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the response is ${response}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
     // ToastMessage.show(context, "mail send successfully");
      showCustomToast(context, "Mail Sent Successfully", Icons.check, Colors.green);
      toNameController.clear();
      mailController.clear();
      subjectController.clear();
      setState(() {
      });
    }

   /* Dio dio = Dio();
    var response = await dio.post(
        "http://ec2-13-235-70-174.ap-south-1.compute.amazonaws.com:8080/crm/api/Employee/SendEmailRemainder", queryParameters: {
      "message": mailController.text.toString(),
      "emailId": toNameController.text.toString(),
      "subject": subjectController.text.toString()
    });
    print('the body ${response.data}');
    if (response.statusCode == 200) {

    }*/

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