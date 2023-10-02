import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/widget/header_widget.dart';
import 'activity/assign_project.dart';
import 'activity/emp_meeting.dart';


class EmpInfo extends StatefulWidget {
  EmpData empData;

  EmpInfo({Key? key, required this.empData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EmpInfo();
  }



}

class _EmpInfo extends State<EmpInfo>{

  bool isActivity=true;
  bool isReminder=false;
  bool isCreateMail=false;
  bool isMeeting=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color(0xffF6F6F6),
          child: Column(
            children: [
              HeaderWidget(title: "Employee Info"),

              Container(
                padding: EdgeInsets.all(30),
                width: 1362.w,
                height: 320.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        CircleAvatar(
                            radius: 50.r,
                            backgroundImage: NetworkImage('assets/user1.jpg')
                        ),
                        SizedBox(width: 32.w,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                widget.empData.firstName!+" "+widget.empData.lastName!,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                )
                            ),

                            Text(
                                widget.empData!.role!.name!,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w300,
                                )
                            )
                          ],
                        )

                      ],



                    ),

                    SizedBox(height: 36.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                                "Address",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text(
                                widget.empData!.address!,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w300,
                                )
                            )



                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: Color(0xffc3262c))
                        ),
                        Column(
                          children: [
                            Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text(
                                widget.empData.emailId!,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w300,
                                )
                            )



                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: Color(0xffc3262c))
                        ),
                        Column(
                          children: [
                            Text(
                                "Mobile Number",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text(
                                widget.empData!.mobileNumber!,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w300,
                                )
                            )
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: Color(0xffc3262c))
                        ),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 20.h,),

              SizedBox(height: 20.h,),

              Container(
                padding: EdgeInsets.all(30),
                child: Row(
                  children: [
                    InkWell(

                        onTap: (){
                          isActivity=true;
                          isReminder=false;
                          isCreateMail=false;
                          isMeeting=false;
                          setState(() {

                          });

                        },child:tab(isActivity,"Assign Lead")),
                    InkWell(

                        onTap: (){
                          isActivity=false;
                          isReminder=false;
                          isCreateMail=false;;
                          isMeeting=true;
                          setState(() {

                          });

                        },child:tab(isMeeting,"Meeting")),
                  ],
                ),
              ),

              Visibility(visible: isActivity,child: AssignProject(id:  widget.empData!.id!,)),
              Visibility(visible: isMeeting,child: EmpMeeting(id:widget.empData!.id!))


            ],


          ),
        ),
      ),

    );
  }


  tab(bool isSelect,String title){
    return  Container(
      width: 220.w,
      height: 78.h,
      child: Stack(
        children: <Widget>[

          SvgPicture.asset(
            'assets/react.svg',
            alignment: Alignment.center,
            width: 150.w,
            height: 78.h,
            color: isSelect?Color(0xffC3262C):Colors.white,
          ),
          Container(
              transform: Matrix4.translationValues(-24.w, 0, 0.0),
              child: SvgPicture.asset("assets/back_arrow.svg")),
          Container(
            transform: Matrix4.translationValues(-20.w, 0, 0.0),
            height: 78.h,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelect?Colors.white:Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }



}