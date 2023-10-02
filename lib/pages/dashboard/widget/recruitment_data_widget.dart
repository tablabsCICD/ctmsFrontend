import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/pages/widget/progress_dialog.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/images.dart';
import '../../../model/response/employeelist.dart';
import '../../widget/textviewone.dart';

class RecruitmentDataWidget extends StatefulWidget {
  final String title;

  const RecruitmentDataWidget({Key? key, required this.title}) : super(key: key);
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {

  List<int>video=[];
  List<EmpData>emData=[];

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData("");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   widget.title,
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: AppColor.black,
              //     fontSize: 22,
              //   ),
              // ),
              getHeader(),
              // Container(
              //   decoration: BoxDecoration(
              //       color: AppColor.yellow,
              //       borderRadius: BorderRadius.circular(100)),
              //   padding: EdgeInsets.symmetric(
              //     vertical: 10,
              //     horizontal: 20,
              //   ),
              //   child: Text(
              //     "View All",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold, color: AppColor.black),
              //   ),
              // )
              filterIcon(),

            ],
          ),
          // Divider(
          //   thickness: 0.5,
          //   color: Colors.grey,
          // ),
          // Table(
          //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   children: [
          //     /// Table Header
          //     TableRow(
          //       decoration: BoxDecoration(
          //         border: Border(
          //             bottom: BorderSide(
          //           color: Colors.grey,
          //           width: 0.5,
          //         )),
          //       ),
          //       children: [
          //         tableHeader("Full Name"),
          //         if (!AppResponsive.isMobile(context))
          //           tableHeader("Designation"),
          //         tableHeader("Status"),
          //         if (!AppResponsive.isMobile(context)) tableHeader(""),
          //       ],
          //     ),
          //
          //     /// Table Data
          //
          //     for (int i=0;i<emData.length;i++)  tableRow(
          //       context,
          //       name: emData[i].firstName!+" "+emData[i].lastName!,
          //       color: Colors.blue,
          //       image: "assets/user1.jpg",
          //       designation: "tets",
          //       status: "Practical Round",
          //     ),
          //
          //   ],
          // ),




          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Showing 4 out of 4 Results"),
          //       Text(
          //         "View All",
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // )

          getEmpTable(),
        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, designation, status, color}) {
    return TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        children: [
          //Full Name
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset(
                    image,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(name)
              ],
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(designation),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(status),
            ],
          ),
          // Menu icon
          if (!AppResponsive.isMobile(context))
            Image.asset(
              "assets/more.png",
              color: Colors.grey,
              height: 30,
            )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
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


  getEmpTable(){
    return Container(
      width: 809.w,
      // height: 700.h,
      margin: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      padding: EdgeInsets.symmetric(horizontal: 21.w,vertical: 24.h),
      child: Column(
        children: [
          getTitle(),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: emData.length,
              itemBuilder: (context,index){
                return getEmpRecord(emData[index]);
              }
          ),
        ],
      ),
    );
  }

  getTitle(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 21.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 32.w,),
          SizedBox(
            width: 100.w,
            child: Text(
              "Name",
              style:TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
              "Designation",
              style:TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
              width: 120.w,
              child: Text(
                "Gmail",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
          ),
          SizedBox(
              width: 100.w,
              child: Text(
                "Contact",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
          ),
          SizedBox(
              width: 87.w,
              child: Text(
                "Status",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              )
          ),

        ],
      ),
    );
  }
  getEmpRecord(EmpData employeeModel){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 21.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            child: Container(
              width: 32.w,
              height: 32.h,
              child: Image.network(employeeModel!.image!),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Text(
             employeeModel.firstName.toString()+" "+employeeModel.lastName.toString(),
              style:TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
             employeeModel!.role!.name!,
              style:TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: Text(
               employeeModel.emailId!,
             style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Text(
               employeeModel.mobileNumber.toString(),
              style:TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            height: 27.h,
            width: 83.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: employeeModel.isSelected!?Colors.amber.shade50:Colors.red.shade50
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.circle,size: 8,color: employeeModel.isSelected!?Colors.amber :Colors.red),
                Text(
                  employeeModel.isSelected!?"Selected":"Pending",
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
        ],
      ),
    );
  }
}
