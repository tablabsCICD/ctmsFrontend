import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/response/lead_activity.dart';

class LeadActivity extends StatefulWidget{
  int id ;

   LeadActivity({Key? key, required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LeadActivity();
  }

}
class _LeadActivity extends State<LeadActivity>{

  List<LeadUpdateData>listLeadActivityData=[];

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 220.w,
                  child: Text(
                    'All Activities',
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

            Container(
              height: 300.h,
              child: ListView.builder(
                shrinkWrap: true,
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
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

      child: Center(
        child: ListTile(

          leading:  CircleAvatar(
              radius: 40.r,
              backgroundImage: NetworkImage('assets/user1.jpg')
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listLeadActivityData[index].description!} \n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),

               Row(
                 children: [
                   Text(
                     "Udpate by: ${listLeadActivityData[index].updatedByUser!.firstName!}",
                     style: TextStyle(
                       color: Colors.blueAccent,
                       fontSize: 20.sp,
                       fontFamily: 'Poppins',
                       fontWeight: FontWeight.w400,
                     ),
                   ),

                   Text(
                     "Next Follow up by: ${listLeadActivityData[index].nextFollowUpBy!.firstName}",
                     style: TextStyle(
                       color: Colors.blueAccent,
                       fontSize: 20.sp,
                       fontFamily: 'Poppins',
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                 ],
               )
              ],
            ),
          ),

          trailing:  Text(
            "${listLeadActivityData[index].date}",
            style: TextStyle(
              color: Color(0xFF858585),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),


        ),
      ),
    );
  }

  void callGetApi()async {
    try{
      Dio dio=Dio();
      EasyLoading.show(status: "Loading");
      var response=await dio.get(ApiConstant.GET_ACTIVITY(widget.id));
      print('the lead is ${response.data}');
      if(response.statusCode==200){
        LeadActivityModel leadActivity =LeadActivityModel.fromJson(jsonDecode(response.data));
        listLeadActivityData.addAll(leadActivity.data!);
        setState(() {

        });

      }else{
        ToastMessage.show(context, "Refresh page");
      }

      EasyLoading.dismiss();
    }catch(e){
      EasyLoading.dismiss();
      print(e);
    }

  }



}