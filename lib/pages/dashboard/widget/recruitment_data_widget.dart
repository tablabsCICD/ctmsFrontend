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
              getHeader(),
              filterIcon(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 350.w,
                margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 260.w,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.arrow_back_ios,size: 16,)),
                          Text("Showing ${emData.length} out of ${emData.length} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
                          GoogleFonts.poppins().fontFamily),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.arrow_forward_ios,size: 16,))
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    SvgPicture.asset('assets/more_icon.svg')
                  ],
                ),
              ),
            ],
          ),
           Container(
             decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(5)),
             padding: EdgeInsets.all(20),
             margin: EdgeInsets.only(left: 15.w),
             child: Table(
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
                 for (int i=0;i<emData.length;i++)  tableRow(
                   context,
                   name: emData[i].firstName!+" "+emData[i].lastName!,
                   color: Colors.blue,
                   image: "assets/user1.jpg",
                   designation: emData[i].role!.name,
                   contact:emData[i].mobileNumber,
                   gmail:emData[i].emailId,
                   status: "Practical Round",
                   isSelected: emData[i].isSelected
                 ),

               ],
             ),
           ),



        //  getEmpTable(),
        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, designation, status, color, contact,gmail,isSelected}) {
    return TableRow(
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
          ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Image.asset('assets/user1.jpg',
              //employeeModel.image.toString(),
              width: 30,
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
