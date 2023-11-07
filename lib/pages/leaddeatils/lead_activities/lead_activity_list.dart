import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/view_image-dialog.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/response/lead_activity.dart';

class LeadActivity extends StatefulWidget {
  int id;

  LeadActivity({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeadActivity();
  }
}

class _LeadActivity extends State<LeadActivity> {
  List<LeadUpdateData> listLeadActivityData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      color: Color(0xffF6F6F6),
      child: SingleChildScrollView(
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
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 900.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listLeadActivityData.length,
                itemBuilder: (context, i) {
                  return listTile(context, i);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  listTile(context, index) {
    return Container(
      width: 1362.w,
      height: 125.h,
      padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: ListTile(
              leading: getImage('', height: 30.h, width: 30.w),
              title:  Text(
                "${listLeadActivityData[index].description!}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                 Text(
                    "Udpate by: ${listLeadActivityData[index].updatedByUser!.firstName!}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Next Follow up by: ${listLeadActivityData[index].nextFollowUpBy!.firstName}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              trailing: SizedBox(
                width: 300.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${listLeadActivityData[index].date}",
                      style: TextStyle(
                        color: Color(0xFF858585),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${listLeadActivityData[index].status}",
                      style: TextStyle(
                        color: Color(0xFF858585),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          listLeadActivityData[index].document==''?SizedBox.shrink():InkWell(
            onTap: () async {
              await showDialog(
              context: context,
              builder: (_) => ImageDialog(
                  listLeadActivityData[index].document!));
            },
            child: Text(
              "View Document",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callGetApi() async {
    print("In get activity function");
    try {
      Dio dio = Dio();
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      EasyLoading.show(status: "Loading");
      var response = await dio.get(ApiConstant.GET_ACTIVITY(widget.id),
          options: Options(headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
          }));
      print('the activity is ${response.data}');
      if (response.statusCode == 200) {
        LeadActivityModel leadActivity =
            LeadActivityModel.fromJson(jsonDecode(response.data));
        listLeadActivityData.addAll(leadActivity.data!);
        setState(() {});
      } else {
        ToastMessage.show(context, "Refresh page");
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
