import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/lead_assign.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/response/lead_activity.dart';

class AssignProject extends StatefulWidget{
  int id ;

  AssignProject({Key? key, required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AssignProject();
  }

}
class _AssignProject extends State<AssignProject>{

  List<Data>listLeadActivityData=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetApi();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(20),
      color:Color(0xffF6F6F6) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 220.w,
            child: Text(
              'All Lead Assigned',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20.h,),

          Container(
            height: 300.h,
            child: ListView.builder(
              itemCount: listLeadActivityData.length,
              itemBuilder: (context, i) {
                return listTile(context,i);
              },
            ),
          )

        ],


      ),

    );
  }

  listTile(context,index){

    return Container(
      width: 1362.w,
      height: 125.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.r),
        ),
      ),

      child: Center(
        child: ListTile(
          leading: getImage('${listLeadActivityData[index].lead!.addLogo}',height: 30.h,width: 30.w),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listLeadActivityData[index].lead!.companyName!}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily:  GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  "${listLeadActivityData[index].lead!.emailId!}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontFamily:  GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text("${listLeadActivityData[index].date}",
                  style: TextStyle(
                    color: Color(0xFF858585),
                    fontSize: 16.sp,
                    fontFamily:  GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
             ],
            ),
          ),


          trailing:  Text(
            "Lead Status: ${listLeadActivityData[index].status}",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.sp,
              fontFamily:  GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),


        ),
      ),
    );
  }

  void callGetApi()async {
    try{
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      Dio dio=Dio();
      EasyLoading.show(status: "Loading");
      var response=await dio.get(ApiConstant.ASSIGN_PROJECT(widget.id),options: Options(headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      }));
      print('the lead is ${response.data}');
      if(response.statusCode==200){
        LeadAssignModel leadActivity =LeadAssignModel.fromJson(jsonDecode(response.data));
        listLeadActivityData.addAll(leadActivity.data!);
        setState(() {

        });

      }else{
       // ToastMessage.show(context, "Refresh page");
      }

      EasyLoading.dismiss();
    }catch(e){
      EasyLoading.dismiss();
      print(e);
    }

  }



}