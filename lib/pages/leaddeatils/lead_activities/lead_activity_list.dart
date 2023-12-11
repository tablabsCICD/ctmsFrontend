import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/refresh.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/view_image-dialog.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/response/lead_activity.dart';

class LeadActivity extends StatefulWidget {
  int id;

  LeadActivity({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LeadActivityState();
  }
}

class LeadActivityState extends State<LeadActivity> implements AbRefresh{
  List<LeadUpdateData> listLeadActivityData = [];

  static AbRefresh? abRefresh;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    abRefresh = this;
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
                  width: 150.w,
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
           /* Container(
              height: 900.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listLeadActivityData.length,
                itemBuilder: (context, i) {
                  return listTile(context, i);
                },
              ),
            )*/
            Container(
              decoration: BoxDecoration(
                 color: AppColor.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(20),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(70),
                  1: FlexColumnWidth(30),
                  2: FlexColumnWidth(30),
                  3: FlexColumnWidth(30),
                  4: FlexColumnWidth(30),
                  5: FlexColumnWidth(30),
                },
                children: [
                  /// Table Header
                  TableRow(
                    children: [
                      tableHeader("Comment"),
                      tableHeader("Created By"),
                      tableHeader("Assigned To"),
                      tableHeader("Status"),
                      if (!AppResponsive.isMobile(context)) tableHeader("Date"),
                      if (!AppResponsive.isMobile(context)) tableHeader("Action"),

                    ],
                  ),

                  /// Table Data

                  for (int i=0;i<listLeadActivityData.length;i++)  tableRow(
                      context,
                      image: listLeadActivityData[i].lead!.addLogo!,
                      comment: listLeadActivityData[i].description!,
                      createdBy: listLeadActivityData[i].updatedByUser!.firstName!,
                      assignedTo: listLeadActivityData[i].nextFollowUpBy!.firstName!,
                      status: listLeadActivityData[i].status,
                      date: listLeadActivityData[i].date,
                      index: i
                  ),

                ],
              ),
            )//:Center(child: Text("No Any Meeting Found")),
          ],
        ),
      ),
    );
  }

  void refresh(){
    debugPrint("In lead activity");
  }


  Widget tableHeader(text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: TextView(title:text,fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.w900,)
    );
  }

  TableRow tableRow(context, {image,comment, createdBy, assignedTo, status, date, index}) {
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
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  getImage(image,height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: TextView(title:comment,fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.w400,))
                ],
              ),
            ),
          ),
          // Designation
         TextView(title:createdBy,fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),
          TextView(title:assignedTo,fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),
          TextView(title:status,fontSize: 16.sp,color: Colors.red,fontWeight: FontWeight.w400,),
          if (!AppResponsive.isMobile(context))
            TextView(title:date,fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),
         // TextView(title:"View Document",fontSize: 16.sp,color: Colors.blue,fontWeight: FontWeight.w400,),
          listLeadActivityData[index].document==''?SizedBox.shrink():InkWell(
            onTap: () async {
              final url =Uri.parse(listLeadActivityData[index].document.toString());
              if (!await launchUrl(url,)) {
                throw Exception('Could not launch $url');
              }
              /*await showDialog(
              context: context,
              builder: (_) => ImageDialog(
                  listLeadActivityData[index].document!));*/
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
        ]);

  }

  listTile(context, index) {
    return Container(
      width: 1362.w,
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
              final url =Uri.parse(listLeadActivityData[index].document.toString());
              if (!await launchUrl(url,)) {
                throw Exception('Could not launch $url');
              }

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
      listLeadActivityData.clear();
      if (response.statusCode == 200) {
        LeadActivityModel leadActivity =
            LeadActivityModel.fromJson(jsonDecode(response.data));
        listLeadActivityData.addAll(leadActivity.data!);
        setState(() {});
      } else {
       // ToastMessage.show(context, "Refresh page");
        showCustomToast(context, "Refresh Page", Icons.check, Colors.green);
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  @override
  void refreshPage() {
    // TODO: implement refreshPage
    debugPrint("In page refresh");
    callGetApi();
  }
}
