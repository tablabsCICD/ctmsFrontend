import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/create_mail.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../dashboard/widget/header_widget.dart';
import 'activity/assign_project.dart';
import 'activity/customer_grpah.dart';
import 'activity/emp_meeting.dart';

class EmpInfo extends StatefulWidget {
  EmpData empData;

  EmpInfo({Key? key, required this.empData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EmpInfo();
  }
}

class _EmpInfo extends State<EmpInfo> {
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
          color: ThemeColor.baground,
          child: Column(
            children: [
              HeaderWidget(isSearchVisible:true,),
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 40.h),
                child: Text(
                  'About Employee',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.r),
                width: 1362.w,
                height: 350.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getImage('${widget.empData.image!}',height: 100.h,width: 100.w),
                        SizedBox(
                          width: 32.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.empData.firstName! +
                                    " " +
                                    widget.empData.lastName!,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(widget.empData!.designation!,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Spacer(),
                        icons(Images.add_circle),
                        SizedBox(width: 19.w,),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => new CupertinoAlertDialog(
                                  title: Text(
                                      'Contact Number : ${widget.empData.mobileNumber}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(10.0),
                                        child: Text('Ok',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                          },
                          child:
                          icons(Images.call),
                        ),
                        SizedBox(width: 19.w,),
                        InkWell(
                          onTap: () {
                            _showMailAlertDialog();
                          },
                          child:
                          icons(Images.mail_black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Address",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(widget.empData!.address!,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Text("Email",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(widget.empData.emailId!,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Text("Mobile Number",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text(widget.empData!.mobileNumber!,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        // Container(
                        //     width: 6.w,
                        //     height: 100.h,
                        //     decoration:
                        //         BoxDecoration(color: Color(0xffc3262c))
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
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
                        child: tab(isActivity, "Assign Lead")),
                    Container(
                      //transform: Matrix4.translationValues(-80.w, 0, 0.0),
                      child: InkWell(
                          onTap: () {
                            isActivity = false;
                            isReminder = false;
                            isCreateMail = true;
                            ;
                            isMeeting = false;
                            setState(() {});
                          },
                          child: tab(isCreateMail, "Customer Acquisition")),
                    ),
                    Container(
                     // transform: Matrix4.translationValues(-160.w, 0, 0.0),
                      child: InkWell(
                          onTap: () {
                            isActivity = false;
                            isReminder = false;
                            isCreateMail = false;
                            ;
                            isMeeting = true;
                            setState(() {});
                          },
                          child: tab(isMeeting, "Meeting")),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: isActivity,
                  child: AssignProject(
                    id: widget.empData!.id!,
                  )),
              Visibility(
                  visible: isMeeting,
                  child: EmpMeeting(id: widget.empData!.id!)),
              Visibility(visible: isCreateMail, child: CustomerGrpah(id:widget.empData!.id!))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMailAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          // <-- SEE HERE
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return CreateMail(
                  onlyMail: true,
                );
              }),
        );
      },
    );
  }
  tab(bool isSelect, String title) {
    return Container(
      width: 250.w,
      height: 75.h,
      margin: EdgeInsets.symmetric(vertical: 0.h,horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelect ? Color(0xffC3262C) : Colors.white,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelect ? Colors.white : Colors.black,
            fontSize: 20.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  icons(String  Image){
    return Container(
      width: 54.w,
      height: 48.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50),
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
      child: Container(
          width: 30.w,
          height: 30.h,
          child: Padding(
            padding:  EdgeInsets.all(7),
            child: SvgPicture.asset(Image),
          )),
    );
  }
}
