import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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

class _LeadInfo extends State<LeadInfo> {
  bool isActivity = true;
  bool isReminder = false;
  bool isCreateMail = false;
  bool isMeeting = false;

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
              SizedBox(height: 26.h,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 10.h, top: 20.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Images.back_arrow,
                        height: 21.h,
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 25.h,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 40.h),
                child: Text(
                  'About Lead',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.all(30),
                width: 1362.w,
                height: 486.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 50.r,
                                backgroundImage: NetworkImage('assets/user1.jpg')),
                            SizedBox(
                              width: 32.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(widget.leadData.lead!.companyName!,
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(widget.leadData.lead!.typeOfBusiness!,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w300,
                                    ))
                              ],
                            ),

                          ],
                        ),
                        Row(
                          children: [
                            getIconData('assets/add.svg',onTap:(){

                            }),
                            getIconData('assets/call.svg',onTap:(){

                            }),
                            getIconData('assets/mail.svg',onTap:(){

                            }),
                            getIconData('assets/more_icon.svg',onTap:(){

                            }),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 83.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 61.w,
                              height: 61.h,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: Color(0xffEFEFEF),
                                shape: CircleBorder(),
                              ),
                              child: SvgPicture.asset(Images.emp_tot,height: 30.h,width: 30.w,),
                            ),
                            SizedBox(width: 23.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("About Me",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(widget.leadData!.lead!.leadAssignedTo!.firstName! +" "+
                                    widget.leadData!.lead!.leadAssignedTo!.firstName!+"\n"+widget.leadData!.lead!.mobileNumber! +
                                "\n" +
                                widget.leadData!.lead!.emailId!,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w300,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 213.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 61.w,
                              height: 61.h,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: Color(0xffEFEFEF),
                                shape: CircleBorder(),
                              ),
                              child: SvgPicture.asset(Images.location,height: 30.h,width: 30.w,),
                            ),
                            SizedBox(width: 23.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(widget.leadData.lead!.address!,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w300,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 213.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 61.w,
                                  height: 61.h,
                                  alignment: Alignment.center,
                                  decoration: ShapeDecoration(
                                    color: Color(0xffEFEFEF),
                                    shape: CircleBorder(),
                                  ),
                                  child: SvgPicture.asset("assets/lead_status.svg",height: 30.h,width: 30.w,),
                                ),
                                SizedBox(width: 23.w,),
                                Text("Lead Status",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text("10",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColor.red
                                        )),
                                    Text("Converted",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                                SizedBox(width: 60.w,),
                                Column(
                                  children: [
                                    Text("25",
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeColor.green
                                        )),
                                    Text("Rejected",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                                SizedBox(width: 60.w,),
                                Column(
                                  children: [
                                    Text("15",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.orange
                                        )),
                                    Text("Pending",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              Container(
                padding: EdgeInsets.all(30),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          isActivity = true;
                          isReminder = false;
                          isCreateMail = false;
                          isMeeting = false;
                          setState(() {});
                        },
                        child: tab(isActivity, "Activities")),
                    InkWell(
                        onTap: () {
                          isActivity = false;
                          isReminder = true;
                          isCreateMail = false;
                          isMeeting = false;
                          setState(() {});
                        },
                        child: tab(isReminder, "Reminder")),
                    InkWell(
                        onTap: () {
                          isActivity = false;
                          isReminder = false;
                          isCreateMail = true;
                          isMeeting = false;
                          setState(() {});
                        },
                        child: tab(isCreateMail, "Create Email")),
                    InkWell(
                        onTap: () {
                          isActivity = false;
                          isReminder = false;
                          isCreateMail = false;
                          ;
                          isMeeting = true;
                          setState(() {});
                        },
                        child: tab(isMeeting, "Meeting")),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              Visibility(
                  visible: isActivity,
                  child: LeadActivity(
                    id: widget.leadData.lead!.id!,
                  )),
              Visibility(visible: isReminder, child: LeadReminder()),
              //Visibility(visible:isCreateMail ,child:CreateReminder()),
              Visibility(visible: isCreateMail, child: CreateMail()),
              Visibility(
                  visible: isMeeting,
                  child: ListMeeting(
                    id: widget.leadData.lead!.id!,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  tab(bool isSelect, String title) {
    return Container(
      width: 220.w,
      height: 78.h,
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/react.svg',
            alignment: Alignment.center,
            width: 150.w,
            height: 78.h,
            color: isSelect ? Color(0xffC3262C) : Colors.white,
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
                  color: isSelect ? Colors.white : Colors.black,
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

  getIconData(String icon, {required  Function() onTap}) {
    return Container(
      height: 54.h,
      width: 48.w,
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: icon=="assets/more_icon.svg"?Border(top: BorderSide.none,bottom: BorderSide.none,left: BorderSide.none,right: BorderSide.none):Border.all(color: Colors.black)
      ),
      child: SvgPicture.asset(icon,height: 30.h,width: 30.h,),
    );
  }
}
