import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../model/response/meeting_list.dart';
import '../../dashboard/widget/calender_widget.dart';

class EmpMeeting extends StatefulWidget{
  int id;

  EmpMeeting({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EmpMeeting();
  }

}

class _EmpMeeting extends State<EmpMeeting>{

  List<MeetingData>listMeeting=[];

  @override
  void initState() {

    getMeetingData();
  }

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
              'Meetings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20.h,),
         Container(
           padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
           color: Colors.white,
           child:  listMeeting.length>0?
           Table(
             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
             children: [
               /// Table Header
               TableRow(
                 // decoration: BoxDecoration(
                 //   border: Border(
                 //       bottom: BorderSide(
                 //         color: Colors.grey,
                 //         width: 0.5,
                 //       )),
                 // ),
                 children: [
                   tableHeader("Subject"),
                   if (!AppResponsive.isMobile(context))
                     tableHeader("CreateBy"),
                   tableHeader("Meeting Link"),
                   if (!AppResponsive.isMobile(context)) tableHeader("Time"),

                 ],
               ),

               /// Table Data

               for (int i=0;i<listMeeting.length;i++)  tableRow(
                   context,
                   time: listMeeting[i].date!+" "+listMeeting[i].time!,
                   guest: listMeeting[i].createdMettingBy!.firstName??'-'+" "+"${listMeeting[i].createdMettingBy!.lastName==null?'-':listMeeting[i].createdMettingBy!.lastName}",

                   image: listMeeting[i].createdMettingBy!.image,
                   meetinglink: listMeeting[i].meetingLink,
                   title: listMeeting[i].title,
                   index: i
               ),

             ],
           ):Center(child: Text("No Any Meeting Found")),
         )

        ],


      ),

    );
  }

  TableRow tableRow(context, {String? title,String? image,String? guest,String? meetinglink,String? time,int? index}) {
    return TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.5,
            ),
          ),
        ),
        children: [
          //Full Name
          InkWell(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  getImage(image??'',height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  Text(title??"")
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(guest??''),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(meetinglink??''),
            ],
          ),

          if (!AppResponsive.isMobile(context))
            Text(time??'')
        ]);
  }


  Widget tableHeader(text) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
    );
  }
  getMeetingData()async {
    var response= await ApiHelper().apiGet(ApiConstant.GET_EMPLOYE_ALL_METTING(widget.id));
    if(response.status==200){
      MeetingListResponse meetingList=MeetingListResponse.fromJson(response.response);
      listMeeting.addAll(meetingList.data!);
      setState(() {

      });
    }
  }
}