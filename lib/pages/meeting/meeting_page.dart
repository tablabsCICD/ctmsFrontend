import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/request/create_meeting.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/meeting_list.dart';
import 'package:flutter_hr_management/model/response/roles.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/textviewone.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/request/save_emp.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/meeting_by_employee.dart';
import '../../utils/constant.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/datepicker.dart';
import '../widget/employee_dialog.dart';
import '../widget/lead_dialog.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MeetingPageScreen extends StatefulWidget {
  @override
  _MeetingPageScreen createState() => _MeetingPageScreen();
}

class _MeetingPageScreen extends State<MeetingPageScreen> {
  TextEditingController _meetingTitleController = TextEditingController();
  TextEditingController _meetingDecController = TextEditingController();
  TextEditingController _meetingLinkController = TextEditingController();

  String selectDate = "Select Date";
  String selectTime = "Select Time";

  TextEditingController _editmeetingTitleController = TextEditingController();
  TextEditingController _editmeetingDecController = TextEditingController();
  TextEditingController _editmeetingLinkController = TextEditingController();

  String editSelectDate = "Select Date";
  String editSelectTime = "Select Time";
  List<int> selectedEmpList = [];
  List<int> selectedLead = [];


  List<int> editSelectedEmpList = [];
  List<int> editSelectLead = [];
  ScrollController _scrollController = ScrollController();


  bool isLoad = false;
  List<MeetingData> meetingList = [];

  @override
  void initState() {
    // TODO: implement initState
    ApiGetMeeting();
    getLoginDetail();
    super.initState();
  }

  LocalSharePreferences localSharePreferences = LocalSharePreferences();
  LoginDeatils? loginDetails;
  getLoginDetail() async {
  loginDetails = await localSharePreferences.getLoginData();
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            /// Header Part
            HeaderWidget(
              title: "Meeting Data",
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 33,vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Meeting',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            filterIconButton(),
                            SizedBox(
                              width: 27.w,
                            ),
                            SizedBox(
                              height: 58.h,
                              width: 180.w,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _showAlertDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: ThemeColor.theme_blue,
                                      onPrimary: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_circle,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      TextView(
                                        title: "Create Meeting",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 33.w, vertical: 20.h),
                    child: Row(
                      children: [
                        meetingCard('Total Lead', '700', 'assets/schedule.svg', true,
                            Colors.green.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        meetingCard(
                            'Converted', '300', 'assets/re_schedule.svg', false, Colors.red.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        meetingCard('Rejected', '200', 'assets/canceled.svg', false,
                            Colors.orange.shade50),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 33,vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Your Meeting',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                        filterIconButton(),
                      ],
                    ),
                  ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 33,vertical: 10),
                  child: StaggeredGridView.countBuilder(
                      controller: _scrollController,
                      physics: ScrollPhysics(),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.fit(1),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      itemCount: meetingList.length,///meetingList.length,
                      itemBuilder: (context, index) {
                        return meetingDetailCard(meetingList[index]);
                      }
                  )
              )
                 // empdeatils()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMeeting(StateSetter setState) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h,),
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
              "Create Meeting",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildTextField('Title', 'Title',_meetingTitleController),
          SizedBox(height: 16),
          _buildTextField('Description','Description' ,_meetingDecController),
          SizedBox(height: 16),
          _buildTextField('Link','Link' ,_meetingLinkController),
          SizedBox(height: 16),
          _buildText(selectDate, () async {
            selectDate = await DateTimePickerDialog().pickDateDialog(context);
            if (selectDate == null) {
              selectDate = "Select Date";
            }
            setState(() {});
          }),
          SizedBox(height: 16),
          _buildText(selectTime, () async {
            selectTime = await DateTimePickerDialog().selectTime(context);
            if (selectTime == null) {
              selectTime = "Select Time";
            }
            setState(() {});
          }),
          SizedBox(height: 16),
          _buildText(selectedEmpList.length==0?'Select Employee':'selected emp is ${selectedEmpList.length}', () async {
            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialog();
                });
            print('the list is ${list}');
            selectedEmpList = list;
            setState(() {
              selectedEmpList=list;
            });
          }),
          SizedBox(height: 16),
          _buildText(selectedLead.length==0?"Select Lead":'selected lead count ${selectedLead.length.toString()}', () async {
            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LeadDialog();
                });
            print('the list is ${list}');
            selectedLead = list;
            setState(() {
              selectedLead=list;
            });
          }),
          SizedBox(height: 16),
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  editMeeting(MeetingData meetingData,StateSetter setState) {


    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
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
              "Edit Meeting",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildTextField('Title', 'Title',_editmeetingTitleController),
          SizedBox(height: 16),
          _buildTextField('Description','Description' ,_editmeetingDecController),
          SizedBox(height: 16),
          _buildTextField('Link','Link' ,_editmeetingLinkController),
          SizedBox(height: 16),
          _buildText(editSelectDate, () async {
            editSelectDate = await DateTimePickerDialog().pickDateDialog(context);
            if (editSelectDate == null) {
              editSelectDate = "Select Date";
            }
            setState(() {});
          }),
          SizedBox(height: 16),
          _buildText(editSelectTime, () async {
            editSelectTime = await DateTimePickerDialog().selectTime(context);
            if (editSelectTime == null) {
              editSelectTime = "Select Time";
            }
            setState(() {});
          }),
          SizedBox(height: 16),
          _buildText(editSelectedEmpList.length==0?'Select Employee':'selected emp is ${editSelectedEmpList.length}', () async {
            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialog();
                });
            print('the list is ${list}');
            selectedEmpList = list;
            setState(() {});
          }),
          SizedBox(height: 16),
          _buildText(editSelectLead.length==0?"Select Lead":'selected le${editSelectLead.length.toString()}', () async {
            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LeadDialog();
                });
            print('the list is ${list}');
            selectedLead = list;
            setState(() {});
          }),
          SizedBox(height: 16),
          InkWell(
            onTap: (){_editSubmitForm(meetingData);},
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
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

  Widget _buildText(String label, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
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

  void _submitForm() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();

    String title = _meetingTitleController.text;
    String dec = _meetingDecController.text;
    String link = _meetingLinkController.text;
    CreateMeeting createMeeting = CreateMeeting();
    createMeeting.time = selectTime;
    createMeeting.date = selectDate;
    createMeeting.title = title;
    createMeeting.description = dec;
    createMeeting.meetingLink = link;
    createMeeting.active = true;
    createMeeting.createdMettingBy = deatils.data!.id;
    createMeeting.leadId = 1;
    createMeeting.employeeId = [deatils.data!.id!];
    var response = await ApiHelper()
        .postParameter(ApiConstant.CREATE_MEETING, createMeeting.toJson());
    print('the response is ${response.response}');
    if (response.status == 200) {
      ApiGetMeeting();
      Navigator.of(context).pop();
    }
  }

   void _editSubmitForm(MeetingData meetingData) async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();

    String title = _editmeetingTitleController.text;
    String dec = _editmeetingDecController.text;
    String link = _editmeetingLinkController.text;
    CreateMeeting createMeeting = CreateMeeting();
    createMeeting.id = meetingData.id;
    createMeeting.time = editSelectTime;
    createMeeting.date = editSelectDate;
    createMeeting.title = title;
    createMeeting.description = dec;
    createMeeting.meetingLink = link;
    createMeeting.active = true;
    createMeeting.createdMettingBy = deatils.data!.id;
    createMeeting.leadId = 1;
    createMeeting.employeeId = editSelectedEmpList!;
    Map<String,dynamic> parameter={
      "active": true,
      "date": editSelectDate,
      "description": dec,
      "id": meetingData.id,
      "meetingLink": link,
      "time": editSelectTime,
      "title": title
    };
    print(parameter);
    var data= jsonEncode(parameter);

    Dio dio=Dio();
    var response=await dio.put(ApiConstant.EDIT_MEETING,data: data);
    print('the response is ${response}');
    if (response.statusCode == 200) {
      ToastMessage.show(context, "Meeting Edit Success");
      ApiGetMeeting();
      Navigator.of(context).pop();
    }
  }

  empdeatils() {
    return isLoad
        ? Center(
            child: Container(),
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      title: "Meeting",
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                      fontSize: 30.sp,
                    ),
                    Container(
                      width: 350.w,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 270.w,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.arrow_back_ios,size: 16,)),
                                Text("Showing ${meetingList.length} out of ${meetingList.length} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
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
                SizedBox(height: 25.h,),
                // isLoad && meetingList.length > 0
                //     ? Table(
                //         defaultVerticalAlignment:
                //             TableCellVerticalAlignment.middle,
                //         children: [
                //           /// Table Header
                //           TableRow(
                //             decoration: BoxDecoration(
                //               border: Border(
                //                   bottom: BorderSide(
                //                 color: Colors.grey,
                //                 width: 0.5,
                //               )),
                //             ),
                //             children: [
                //               tableHeader("Full Name"),
                //               if (!AppResponsive.isMobile(context))
                //                 tableHeader("Designation"),
                //               tableHeader("Mobile Number"),
                //               if (!AppResponsive.isMobile(context))
                //                 tableHeader(""),
                //             ],
                //           ),
                //
                //           /// Table Data
                //
                //           for (int i = 0; i < meetingList.length; i++)
                //             tableRow(context,
                //                 name: meetingList[i].title,
                //                 color: Colors.blue,
                //                 image: "assets/img.png",
                //                 designation: meetingList[i].description,
                //                 status: meetingList[i].time,
                //                 index: i),
                //         ],
                //       )
                //     : Center(
                //         child: Text("No any meeting found"),
                //       ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(20),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      /// Table Header
                      TableRow(
                        children: [
                          tableHeader("Subject"),
                          if (!AppResponsive.isMobile(context))
                            tableHeader("Create By"),
                          tableHeader("Meeting Link"),
                          if (!AppResponsive.isMobile(context))
                            tableHeader("Time"),
                        ],
                      ),
                      /// Table Data
                      for (int i = 0; i < meetingList.length; i++)
                        tableRow(context,
                            time:
                                meetingList[i].date! + " " + meetingList[i].time!,
                            guest: meetingList[i].createdMettingBy!.firstName! +
                                " " +
                                meetingList[i].createdMettingBy!.lastName!,
                            image: "assets/user1.jpg",
                            meetinglink: meetingList[i].meetingLink,
                            title: meetingList[i].title,
                            index: i),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  bool isJoin = true;

  meetingDetailCard(MeetingData meetingData){
    return Container(
      height: 451.h,
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white
      ),
     // padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 14.0.h,right: 14.w),
                child: SvgPicture.asset('assets/more_icon.svg',height: 14.h,width: 34.w,),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImage(meetingData.createdMettingBy!.image!,height: 35.h,width: 35.w),
                SizedBox(width: 23.w,),
                Text(meetingData.title.toString()??'',
                 // "Document Update",
                  style: TextStyle(color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Divider(),
          SizedBox(height: 2.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Meeting Link",
                  style: TextStyle(color: Colors.black,
                    fontSize: 17.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,),
                ),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(meetingData.meetingLink.toString()??'',
                     // "https:www.googlemeetjk75",
                      style: TextStyle(color: Colors.blue,
                        fontSize: 15.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w300,),
                    ),
                    SvgPicture.asset('assets/images/share_icon.svg',width: 30.w,height: 30.h,)
                  ],
                ),
                SizedBox(height: 20.h,),
                Text(
                  "Members",
                  style: TextStyle(color: Colors.black,
                    fontSize: 17.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,),
                ),
                SizedBox(height:5.h),
                getImage('',height: 20.h,width: 20.w),
                SizedBox(height: 34.h,),
                Row(
                  children: [
                    SvgPicture.asset('assets/time.svg',width: 16.w,height: 19.h,),
                    SizedBox(width: 20.w,),
                    Text(meetingData.time.toString()??'',
                     // "Time : 11:00 AM",
                      style: TextStyle(color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w300,),
                    ),
                  ],
                ),
                SizedBox(height: 34.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginDetails!.data!.id! == meetingData.createdMettingBy!.id ?SizedBox(
                  width: 134.w ,
                  height: 45 .h,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return ThemeColor.white; //<-- SEE HERE
                         return isJoin?ThemeColor.theme_blue:ThemeColor.white; // Defer to the widget's default.
                        },
                      ),
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return ThemeColor.theme_blue; //<-- SEE HERE
                          return isJoin?ThemeColor.white:ThemeColor
                              .theme_blue; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () async {

                      if(loginDetails!.data!.id! == meetingData.createdMettingBy!.id){
                      _showEditAlertDialog(meetingData);}
                      setState(() {
                        isJoin = false;
                      });
                    },
                    child: Textview(
                        TextStyle(
                          fontSize: 16.sp ,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                        title: 'Reschedule'),
                  ),
                ):SizedBox.shrink(),
                SizedBox(
                  width: 23.w,
                ),
                SizedBox(
                  width: 134.w ,
                  height: 45 .h,
                  child: OutlinedButton(
                    style: ButtonStyle(

                      foregroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return ThemeColor.white; //<-- SEE HERE
                          return isJoin?ThemeColor.white:ThemeColor.theme_blue; // Defer to the widget's default.
                        },
                      ),
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return ThemeColor.theme_blue; //<-- SEE HERE
                          return isJoin?ThemeColor.theme_blue:ThemeColor
                              .white; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      _launchUrl(meetingData.meetingLink!);

                      setState(() {
                        isJoin = true;
                      });


                    },
                    child: Textview(
                        TextStyle(
                          fontSize: 16.sp ,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                        title: 'Join'),
                  ),
                ),
              ],
            )


              ],
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication,);
  }

  TableRow tableRow(context, {title, image, guest, meetinglink, time, index}) {
    return TableRow(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
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
                  TextView(title: title, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300)
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) TextView(title: guest, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              TextView(title: meetinglink, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300)
            ],
          ),

          if (!AppResponsive.isMobile(context)) TextView(title: time, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300)
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(title: text, fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w900),
    );
  }

  Future<void> ApiGetMeeting() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();
    print("EmpId::"+deatils.data!.id!.toString());
    isLoad = true;
    setState(() {});
    var roleResponse = await ApiHelper()
        .apiGet(ApiConstant.GET_EMPLOYE_ALL_METTING(deatils.data!.id!));
    print('the data us ${roleResponse.response}');
    if (roleResponse.status == 200) {
      MeetingList role = MeetingList.fromJson(roleResponse.response);
      meetingList.addAll(role!.data!);
      setState(() {

      });
    }
    print('meetingList Length :'+meetingList.length.toString());

    isLoad = false;
    setState(() {});
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,// <-- SEE HERE
          title: const Text(''),
          content:StatefulBuilder(builder: (BuildContext context, StateSetter stateSetter) {

            return SingleChildScrollView(
              child: Container(
                  color: Colors.transparent,
                  height: 1024.h,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.transparent,
                          width: 408.w,
                          child: addMeeting(stateSetter),
                        ),
                      )
                    ],
                  )
              ),
            );
          }),
        );;
      },
    );

    //SingleChildScrollView(
    //             child: Container(
    //                 color: Colors.transparent,
    //                 height: 1024.h,
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Stack(
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.centerRight,
    //                       child: Container(
    //                         color: Colors.transparent,
    //                         width: 408.w,
    //                         child: addMeeting(),
    //                       ),
    //                     )
    //                   ],
    //                 )
    //             ),
    //           )
  }

  Future<void> _showEditAlertDialog(MeetingData meetingData) async {
    _editmeetingTitleController.text = meetingData.title!;
    _editmeetingDecController.text = meetingData.description!;
    _editmeetingLinkController.text = meetingData.meetingLink!;
    editSelectDate = meetingData.date!;
    editSelectTime = meetingData.time!;
    editSelectLead = [meetingData.lead!.id==null?0:meetingData.lead!.id!];
    editSelectedEmpList = [meetingData.lead!.id==null?0:meetingData.lead!.id!];

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,// <-- SEE HERE
          title: const Text(''),
          content:StatefulBuilder(builder: (BuildContext context, StateSetter stateSetter) {

            return SingleChildScrollView(
              child: Container(
                  color: Colors.transparent,
                  height: 1024.h,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.transparent,
                          width: 408.w,
                          child: editMeeting(meetingData,stateSetter),
                        ),
                      )
                    ],
                  )
              ),
            );
          }),
        );;
      },
    );

    //SingleChildScrollView(
    //             child: Container(
    //                 color: Colors.transparent,
    //                 height: 1024.h,
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Stack(
    //                   children: [
    //                     Align(
    //                       alignment: Alignment.centerRight,
    //                       child: Container(
    //                         color: Colors.transparent,
    //                         width: 408.w,
    //                         child: addMeeting(),
    //                       ),
    //                     )
    //                   ],
    //                 )
    //             ),
    //           )
  }

  meetingCard(
    String title,
    String count,
    String img,
    bool isSelected,
    Color bgColor,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = true;
        });
      },
      child: Container(
        width: 329.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: isSelected ? Color(0xFFC3262C) : Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 89.w,
              height: 89.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: CircleBorder(),
              ),
              child: SvgPicture.asset(
                img,
                height: 50.h,
                width: 50.w,
              ),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                    title: count,
                    fontSize: 35.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600),
                TextView(
                    title: title,
                    fontSize: 20.sp,
                    color: Color(0xff6C6C6C),
                    fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _showEditAlertDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.transparent,// <-- SEE HERE
  //         title: const Text(''),
  //         content: SingleChildScrollView(
  //           child: Container(
  //               color: Colors.transparent,
  //               height: 1024.h,
  //               width: MediaQuery.of(context).size.width,
  //               child: Stack(
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.centerRight,
  //                     child: Container(
  //                       color: Colors.transparent,
  //                       width: 408.w,
  //                       child: addMeeting(),
  //                     ),
  //                   )
  //                 ],
  //               )
  //           ),
  //         ),
  //       );;
  //     },
  //   );
  // }
}
