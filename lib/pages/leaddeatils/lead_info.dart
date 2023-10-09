import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../model/response/login_data.dart';
import '../../utils/constant.dart';
import '../../utils/sharepreferences.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/datepicker.dart';
import '../widget/one_emp_dilaog.dart';
import '../widget/toast.dart';
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
                            getImage('image',height: 50.h,width: 50.w),
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
                            InkWell(onTap: (


                                ){
                              _showAlertDialog();
                            },child: getIconData('assets/add.svg',onTap:(){

                            }),),
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
                    // InkWell(
                    //     onTap: () {
                    //       isActivity = false;
                    //       isReminder = true;
                    //       isCreateMail = false;
                    //       isMeeting = false;
                    //       setState(() {});
                    //     },
                    //     child: tab(isReminder, "Reminder")),
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
      width: 250.w,
      height: 150.h,
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            Images.red_arrow,
            alignment: Alignment.center,
            width: 250.w,
            height: 100.h,
            color: isSelect ? Color(0xffC3262C) : Colors.white,
          ),

          Container(
            transform: Matrix4.translationValues(-30.w, 0, 0.0),
            height: 100.h,
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
          ),
        ],
      ),
    );/*Container(
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
              child: SvgPicture.asset("assets/images/red_arrow.svg")),
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
    );*/
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



  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,// <-- SEE HERE
          title: const Text(''),
          content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {

            return SingleChildScrollView(
              child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.transparent,
                          width: 408.w,
                          child: addLead(setState),
                        ),
                      )
                    ],
                  )
              ),
            );
          }),
        );
      },
    );


  }
  TextEditingController _nameController=TextEditingController();
  TextEditingController _sourceofleadController=TextEditingController();
  String selectDate="";
  int selectedEmp=0;
  String selectedStatus="Select Status";
  addLead(StateSetter stateSetter){
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios,size: 16,)),
              SizedBox(width: 5.w,
              ),
              Text(
                "Back",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "Fllow Up Lead",
              style: TextStyle(
                fontFamily:
                GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 16.h),
          _buildTextField('Description ','Please Description', _nameController),
          SizedBox(height: 16.h),

          SizedBox(height: 16.h),
          _buildText(selectDate.length==0?'Next Followup Date':selectDate,()async{
            selectDate = await DateTimePickerDialog().pickDateDialog(context);
            if (selectDate == null) {
              selectDate = "Next Followup Date";
            }
            stateSetter(() {

            });
          }),
          SizedBox(height: 16.h),
          _buildText(selectedEmp==0?'Next Followup By':"Selected one employee", ()async{

            int list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialogOne();
                });
            // print('the list is ${list}');
            selectedEmp=list;
            print('the list is$selectedEmp');
            stateSetter(() {
              selectedEmp=list;
            });

          }),
          SizedBox(height: 16.h),
          // _buildTextField('Name Coordinator', _coordinatorController),
          //   _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16.h),
          _buildTextField('Potential', 'Please Enter potential',_sourceofleadController),

          SizedBox(height: 16.h),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60.h,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text("$selectedStatus"),
              padding: EdgeInsets.symmetric(horizontal: 10),

              items: <String>['Pending', 'Converted', 'Rejected'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style:TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300)),
                );
              }).toList(),
              onChanged: (val) {
                stateSetter(() {
                  selectedStatus=val!;
                });

              },
            ),
          ),

          SizedBox(height: 16.h),
          InkWell(
            onTap: _submitForm,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeColor.theme_blue,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20.sp,fontFamily:
                  GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }




  Widget _buildText(String label, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: Color(0xff1B1B1B),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(label,style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w300,),),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w500,),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xffcccccc),fontSize: 13.sp,fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() async{

    LoginDeatils loginDeatils= await LocalSharePreferences.localSharePreferences.getLoginData();

    Dio dio=Dio();
    Map<String,dynamic> parameter={
      "date":selectDate,
      "lead":widget.leadData.lead!.id!,
      "nextFollowUpBy":selectedEmp,
      "potential":_sourceofleadController.text,
      "status":selectedStatus,
      "updatedByUser":loginDeatils.data!.id,
      "description":_nameController.text
    };
    var para= jsonEncode(parameter);
    var leadResponse=await dio.post(ApiConstant.SAVE_LEAD_UPDATe,data:para );
    if(leadResponse.statusCode==200){
      print('done is done ');
      _nameController=TextEditingController();
      _sourceofleadController=TextEditingController();
       selectDate="";
       selectedEmp=0;
       selectedStatus="Select Status";
      Navigator.pop(context);

    }else{
      ToastMessage.show(context, "Please try Again");
    }
    EasyLoading.dismiss();



  }
}
