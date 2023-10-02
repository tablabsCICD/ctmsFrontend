import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/widget/header_widget.dart';
import 'lead_activities/create_mail.dart';
import 'lead_activities/create_reminder.dart';
import 'lead_activities/lead_activity_list.dart';
import 'lead_activities/lead_reminder.dart';

class LeadInfo extends StatefulWidget {
  LeadData leadData;

   LeadInfo({Key? key, required this.leadData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LeadInfo();
  }



}

class _LeadInfo extends State<LeadInfo>{

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
              HeaderWidget(title: "Lead Info"),

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
                                widget.leadData.lead!.companyName!,
                                style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                )
                            ),

                            Text(
                                widget.leadData.lead!.typeOfBusiness!,
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
                                "Lead Address",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                  Text(
                    widget.leadData.lead!.address!,
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
                                "Assign to",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text(
                                widget.leadData.lead!.leadAssignedTo!.firstName!+" "+widget.leadData.lead!.leadAssignedTo!.lastName!,
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
                                "Contact information",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            Text(
                                widget.leadData!.lead!.mobileNumber!+"\n"+widget.leadData!.lead!.emailId!,
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

                        },child:tab(isActivity,"Activities")),
                    InkWell(

                        onTap: (){
                          isActivity=false;
                          isReminder=true;
                          isCreateMail=false;
                          isMeeting=false;
                          setState(() {

                          });

                        },child:tab(isReminder,"Reminder")),
                    InkWell(

                        onTap: (){
                          isActivity=false;
                          isReminder=false;
                          isCreateMail=true;
                          isMeeting=false;
                          setState(() {

                          });

                        },child:tab(isCreateMail,"Create Email")),
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
              SizedBox(height: 20.h,),

              Visibility(visible:isActivity ,child: LeadActivity(id: widget.leadData.lead!.id!,)),
              Visibility(visible:isReminder ,child: LeadReminder()),
              //Visibility(visible:isCreateMail ,child:CreateReminder()),
              Visibility(visible:isCreateMail ,child:CreateMail()),
              Visibility(visible:isMeeting ,child:ListMeeting(id: widget.leadData.lead!.id!,)),

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