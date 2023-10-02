import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/model/request/create_meeting.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/meeting_list.dart';
import 'package:flutter_hr_management/model/response/roles.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import '../../model/request/save_emp.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/meeting_by_employee.dart';
import '../../utils/constant.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/datepicker.dart';
import '../widget/employee_dialog.dart';
import '../widget/lead_dialog.dart';

class MeetingPageScreen extends StatefulWidget {
  @override
  _MeetingPageScreen createState() => _MeetingPageScreen();
}

class _MeetingPageScreen extends State<MeetingPageScreen> {
  TextEditingController _meetingTitleController = TextEditingController();
  TextEditingController _meetingDecController = TextEditingController();
  TextEditingController _meetingLinkController = TextEditingController();

  String selectDate="Select Date";
  String selectTime="Select Time";

  bool isLoad = false;
  List<MeetingData> meetingList = [];

  @override
  void initState() {
    // TODO: implement initState
    ApiGetMeeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          HeaderWidget(
            title: "Meeting Data",
          ),
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
                          empdeatils(),
                          if (AppResponsive.isMobile(context)) ...{
                            //AddEmployee(),

                            addemp(),
                            SizedBox(
                              height: 20,
                            ),
                          },
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
                            // AddEmployee(),

                            addemp(),
                            SizedBox(
                              height: 20,
                            ),
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

  addemp() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Add Meeting",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          SizedBox(height: 16),
          _buildTextField('Title', _meetingTitleController),
          SizedBox(height: 16),
          _buildTextField('Description', _meetingDecController),
          SizedBox(height: 16),
          _buildTextField('Link', _meetingLinkController),
          SizedBox(height: 16),
          _buildText(selectDate, () async {
            selectDate= await DateTimePickerDialog().pickDateDialog(context);
            if(selectDate==null){
              selectDate="Select Date";
            }
            setState(() {

            });
          }),
          SizedBox(height: 16),
          _buildText(selectTime, () async {
            selectTime=  await DateTimePickerDialog().selectTime(context);
            if(selectTime==null){
              selectTime="Select Time";
            }
            setState(() {

            });
          }),
          SizedBox(height: 16),
          _buildText('Select Employee', () async{
            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialog();
                });
            print('the list is ${list}');
          }),
          SizedBox(height: 16),
          _buildText("Select Lead", ()async {



            var list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LeadDialog();
                });
            print('the list is ${list}');



          }),
          SizedBox(height: 16),
          InkWell(
            onTap: _submitForm,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
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
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();

    String title=_meetingTitleController.text;
    String dec=_meetingDecController.text;
    String link=_meetingLinkController.text;
    CreateMeeting createMeeting=CreateMeeting();
    createMeeting.time=selectTime;
    createMeeting.date=selectDate;
    createMeeting.title=title;
    createMeeting.description=dec;
    createMeeting.meetingLink=link;
    createMeeting.active=true;
    createMeeting.createdMettingBy=deatils.data!.id;
    createMeeting.leadId=1;
    createMeeting.employeeId=[1];
    var response=await ApiHelper().postParameter(ApiConstant.CREATE_MEETING, createMeeting.toJson());
    print('the response is ${response.response}');
    if(response.status==200){
      ApiGetMeeting();
    }





  }

  empdeatils() {
    return isLoad
        ? Center(
            child: Container(),
          )
        : Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Meetings List",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                        fontSize: 22,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.yellow,
                          borderRadius: BorderRadius.circular(100)),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: AppColor.black),
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
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

                Table(
                  defaultVerticalAlignment:
                  TableCellVerticalAlignment.middle,
                  children: [
                    /// Table Header
                    TableRow(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            )),
                      ),
                      children: [
                        tableHeader("Subject"),
                        if (!AppResponsive.isMobile(context))
                          tableHeader("Create By"),
                        tableHeader("Meeting Link"),
                        if (!AppResponsive.isMobile(context)) tableHeader("Time"),

                      ],
                    ),

                    /// Table Data

                    for (int i=0;i<meetingList.length;i++)  tableRow(
                        context,
                        time: meetingList[i].date!+" "+meetingList[i].time!,
                        guest: meetingList[i].createdMettingBy!.firstName!+" "+meetingList[i].createdMettingBy!.lastName!,

                        image: "assets/user1.jpg",
                        meetinglink: meetingList[i].meetingLink,
                        title: meetingList[i].title,
                        index: i
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Showing ${meetingList.length} out of ${meetingList.length} Results"),
                      Text(
                        "View All",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  TableRow tableRow(context, {title, image, guest, meetinglink, time, index}) {
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
          InkWell(
            onTap: (){

            },
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
                  Text(title)
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(guest),
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
              Text(meetinglink),
            ],
          ),

          if (!AppResponsive.isMobile(context))
            Text(time)
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

  Future<void> ApiGetMeeting() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();

    isLoad = true;
    setState(() {});
    var roleResponse = await ApiHelper()
        .apiGet(ApiConstant.GET_EMPLOYE_ALL_METTING(deatils.data!.id!));
    print('the data us ${roleResponse.response}');
    if (roleResponse.status == 200) {
      MeetingList role = MeetingList.fromJson(roleResponse.response);
      meetingList.addAll(role!.data!);
    }

    isLoad = false;
    setState(() {});
  }
}
