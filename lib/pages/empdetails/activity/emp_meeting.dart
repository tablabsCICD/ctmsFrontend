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

  EmpMeeting({Key? key}) : super(key: key);

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
              'Monthly Stock',
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
           color: Colors.white,
           child:
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
                   tableHeader("Month"),
                   if (!AppResponsive.isMobile(context))
                     tableHeader("Available Stock"),
                   tableHeader("Expiry Date"),
                   if (!AppResponsive.isMobile(context)) tableHeader("Purchase Date"),

                 ],
               ),

               /// Table Data

               for (int i=0;i<3;i++)  tableRow(
                   context,
                   month: "June",
                   availableStock: "39",

                   image: "assets/user1.jpg",
                   expiryDate: "20/02/2027",
                   purchaseDate: "01/10/2023",
                   index: i
               ),

             ],
           ),
         )

        ],


      ),

    );
  }

  TableRow tableRow(context, {month, image, availableStock, expiryDate, purchaseDate, index}) {
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
                //  getImage(image,height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  Text(month)
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(availableStock),
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
              Text(expiryDate),
            ],
          ),

          if (!AppResponsive.isMobile(context))
            Text(purchaseDate)
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
   // var response= await ApiHelper().apiGet(ApiConstant.GET_EMPLOYE_ALL_METTING(widget.id));

  }
}