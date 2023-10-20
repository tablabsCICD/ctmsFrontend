import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/textviewone.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/calender_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';
import 'widget/profile_card_widget.dart';
import 'widget/recruitment_data_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  List<int>video=[];
  List<EmpData>finalEmpData=[];

  List<EmpData>emData=[];

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData("");
    super.initState();
  }

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total leads : ${emData.length}');
    finalEmpData.clear();
    debugPrint('Total leads : ${emData.length}');
    emData.forEach((element) {
      if(element.firstName!.contains(query) || element.mobileNumber!.contains(query) || element.lastName!.contains(query)){
        finalEmpData.add(element);
      }
    });
    debugPrint('Final Leads : ${finalEmpData.length}');
    setState(() {});
  }

  TableRow tableRow(context, {name, image, designation, status, color, contact,gmail,isSelected}) {
    return TableRow(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                getImage(image,height: 30.h,width: 30.w),
                SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Text(
            designation,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            gmail,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            contact,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            height: 27.h,
            width: 83.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected!?Colors.amber.shade50:Colors.red.shade50
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.circle,size: 8,color: isSelected!?Colors.amber :Colors.red),
                SizedBox(width: 10.w,),
                Text(
                  isSelected!?"Selected":"Pending",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700, color: AppColor.black,fontSize: 15.sp),
      ),
    );
  }

  Future<void> ApiGetData(String URL) async{
    // ProgressDailog progressDailog=ProgressDailog();
    // progressDailog.progressDailog(context, true);
    // setState(() {
    //
    // });
    final dio = Dio();
    final response = await dio.get(ApiConstant.BASE_URL+"/Employee/getAll");
    print(response.data);
    if(response.statusCode==200){
      EmployeeList employeeList =EmployeeList.fromJson(jsonDecode(response.data));
      //emData=employeeList.data!;
      emData.addAll(employeeList.data!);
      finalEmpData.addAll(employeeList.data!);
      print('this is ${emData.length}');
      setState(() {

      });
    }
    // EmployeeList.fromJson(jsonDecode(response.data));
    // progressDailog.progressDailog(context, false);
    //return response.statusCode!;
  }


  getHeader(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Textview(
                  TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                  title: 'Pending Recruitment'),
              //  filterIcon(),
            ],
          ),
          SizedBox(height: 27.5.h,),

        ],
      ),
    );
  }


  filterIcon() {
    return Container(
        width: 101.w,
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                Images.filter,
                height: 19.h,
                width: 20.w,
              ),
              SizedBox(width: 8.w,),
              Text(
                "Filter",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderWidget(onSearchTap: (value){filterSearchResults(value);},),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                         // NotificationCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          if (AppResponsive.isMobile(context)) ...{
                            CalendarWidget(),
                            SizedBox(
                              height: 20,
                            ),
                          },
                        //  RecruitmentDataWidget(title: 'Pending Recruitment',),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Textview(
                                          TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.sp,
                                            fontFamily: GoogleFonts.poppins().fontFamily,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          title: 'Pending Recruitment'),
                                      filterIcon(),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 300.w,
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(onPressed: (){},
                                                icon: Icon(Icons.arrow_back_ios,size: 16,)),
                                            Text("Showing ${finalEmpData.length} out of ${emData.length} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
                                            GoogleFonts.poppins().fontFamily),),
                                            IconButton(onPressed: (){},
                                                icon: Icon(Icons.arrow_forward_ios,size: 16,))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.only(left: 30.w),
                                  child:  finalEmpData.isEmpty
                                      ? Expanded(
                                      child: Container(
                                          height:
                                          MediaQuery.of(context).size.height - 400,
                                          child: Center(
                                              child: TextView(
                                                  title: "No Record Found",
                                                  fontSize: 16.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900))))
                                      : Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(90),
                                      1: FlexColumnWidth(50),
                                      2: FlexColumnWidth(70),
                                      3: FlexColumnWidth(50),
                                      4: FlexColumnWidth(50),
                                    },
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    children: [
                                      /// Table Header
                                      TableRow(
                                        children: [
                                          tableHeader("Name"),
                                          tableHeader("Designation"),
                                          tableHeader("Contact"),
                                          tableHeader("Gmail"),
                                          tableHeader("Status"),
                                        ],
                                      ),
                                     for (int i=0;i<finalEmpData.length;i++)  tableRow(
                                          context,
                                          name: "${finalEmpData[i].firstName} ${finalEmpData[i].lastName}",
                                          color: Colors.blue,
                                          image: finalEmpData[i].image,
                                          designation: finalEmpData[i].designation,
                                          contact:finalEmpData[i].mobileNumber,
                                          gmail:finalEmpData[i].emailId,
                                          status: finalEmpData[i].status,
                                          isSelected: finalEmpData[i].isSelected
                                      ),

                                    ],
                                  ),
                                ),
                           //  getEmpTable(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(

                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CalendarWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileCardWidget(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }





}
