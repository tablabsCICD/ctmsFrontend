import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../model/response/meeting_list.dart';
import '../../dashboard/widget/calender_widget.dart';

class ListMeeting extends StatefulWidget{
   int id;

   ListMeeting({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListMeeting();
  }

}

class _ListMeeting extends State<ListMeeting>{

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
          listMeeting.length>0?
          Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(20),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                /// Table Header
                TableRow(
                  /*decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                  ),*/
                  children: [
                    tableHeader("Subject"),
                    if (!AppResponsive.isMobile(context))
                      tableHeader("Create By"),
                    tableHeader("Meeting Link"),
                    if (!AppResponsive.isMobile(context)) tableHeader("Time"),

                  ],
                ),

                /// Table Data

                for (int i=0;i<listMeeting.length;i++)  tableRow(
                    context,
                    time: listMeeting[i].date!+" "+listMeeting[i].time!,
                    guest: listMeeting[i].createdMettingBy!.firstName!+" "+listMeeting[i].createdMettingBy!.lastName!,

                    image: "assets/user1.jpg",
                    meetinglink: listMeeting[i].meetingLink,
                    title: listMeeting[i].title,
                    index: i
                ),

              ],
            ),
          ):Center(child: Text("No Any Meeting Found")),

        ],


      ),

    );
  }

  TableRow tableRow(context, {title, image, guest, meetinglink, time, index}) {
    return TableRow(
        /*decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),*/
        children: [
          //Full Name
          InkWell(
            onTap: (){

            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  getImage(image,height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  TextView(title:title,fontSize: 18.sp,color: Colors.grey,fontWeight: FontWeight.w400,)
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) TextView(title:guest,fontSize: 16.sp,color: Colors.grey,fontWeight: FontWeight.w400,),
         Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              TextView(title:meetinglink,fontSize: 16.sp,color: Colors.grey,fontWeight: FontWeight.w400,)
            ],
          ),

          if (!AppResponsive.isMobile(context))
            TextView(title:time,fontSize: 16.sp,color: Colors.grey,fontWeight: FontWeight.w400,)
        ]);
  }


  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(title:text,fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.w900,)
    );
  }
   getMeetingData()async {
    var response= await ApiHelper().apiGet(ApiConstant.GET_LEAD_METTING(widget.id));
    if(response.status==200){
      MeetingList meetingList=MeetingList.fromJson(response.response);
      listMeeting.addAll(meetingList.data!);
      setState(() {

      });
    }
  }
}