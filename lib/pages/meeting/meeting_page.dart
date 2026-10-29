import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/request/create_meeting.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/meeting_list.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/textviewone.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/request/save_emp.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/meeting_by_employee.dart';
import '../../constant/constant.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/datepicker.dart';
import '../widget/employee_dialog.dart';
import '../widget/lead_dialog.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MeetingPageScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  MeetingPageScreen(this.scaffoldKey);

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
  List<MeetingData> filteredMeetingList = [];
  List<MeetingData> upcomingMeetingList = [];
  List<MeetingData> todayMeetingList = [];
  List<MeetingData> rescheduleMeetingList = [];
  List<MeetingData> inActiveMeetingList = [];
  List<MeetingData> pastMeetingList = [];

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetail();
    ApiGetMeeting();

    super.initState();
  }

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total leads : ${meetingList.length}');
    filteredMeetingList.clear();
    debugPrint('Total leads : ${meetingList.length}');
    meetingList.forEach((element) {
      if (element.title!.toLowerCase().contains(query.toLowerCase()) || element.date!.contains(query.toLowerCase())) {
        filteredMeetingList.add(element);
      }
    });
    debugPrint('Final Leads : ${filteredMeetingList.length}');
    setState(() {});
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
        color: ThemeColor.baground,
        child: Column(
          children: [
            /// Header Part
            HeaderWidget(
              scaffoldKey: widget.scaffoldKey,
              isSearchVisible:true,
              onSearchTap: (value) {
                filterSearchResults(value);
              },
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Meeting',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            filterIcon(),
                            SizedBox(
                              width: 27.w,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 200.w,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _showAlertDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ThemeColor.theme_blue,
                                      foregroundColor: Colors.white),
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
                        meetingCard('Schedule', '${meetingList.length}',
                            'assets/schedule.svg', true, Colors.green.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        meetingCard(
                            'Reschedule',
                            '${rescheduleMeetingList.length}',
                            'assets/re_schedule.svg',
                            false,
                            Colors.red.shade50),
                        SizedBox(
                          width: 32.w,
                        ),
                        meetingCard(
                            'Cancelled',
                            '${inActiveMeetingList.length}',
                            'assets/canceled.svg',
                            false,
                            Colors.orange.shade50),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 33, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          selectedMeetingType.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            ApiGetMeeting();
                          },
                          child: Container(
                            width: 101.w,
                            height: 43.h,
                          //  padding: EdgeInsets.symmetric(horizontal: 12.w),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 33, vertical: 10),
                      child:  isLoad
                          ? Container(
                        height: MediaQuery.of(context).size.height - 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                            child: Center(
                        child: CircularProgressIndicator(),
                      ),
                          )
                          : filteredMeetingList.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height - 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: TextView(
                                      title: "No Record Found",
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900)))
                          : StaggeredGridView.countBuilder(
                          controller: _scrollController,
                          physics: ScrollPhysics(),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(1),
                          shrinkWrap: true,
                          crossAxisCount: ResponsiveWidget.isMobile(context)? 1: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: filteredMeetingList.length,

                          ///meetingList.length,
                          itemBuilder: (context, index) {
                            return meetingDetailCard(
                                filteredMeetingList[index]);
                          }))
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
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    )),
                SizedBox(
                  width: 5.w,
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
            _buildTextField('Title', 'Title', _meetingTitleController),
            SizedBox(height: 16),
            _buildTextField('Description', 'Description', _meetingDecController),
            SizedBox(height: 16),
            _buildTextField('Link', 'Link', _meetingLinkController),
            SizedBox(height: 16),
            _buildText(selectDate, "Select Date",() async {
              selectDate = await DateTimePickerDialog().pickDateDialog(context);
              if (selectDate == null) {
                selectDate = "Select Date";
              }
              setState(() {});
            }),
            SizedBox(height: 16),
            _buildText(selectTime, "Select Time", () async {
              selectTime = await DateTimePickerDialog().selectTime(context);
              if (selectTime == null) {
                selectTime = "Select Time";
              }
              setState(() {});
            }),
            SizedBox(height: 16),
            _buildText(
                selectedEmpList.length == 0
                    ? 'Select Employee'
                    : 'selected emp is ${selectedEmpList.length}', "Select Employee",() async {
              var list = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EmpDialog();
                  });
              print('the list is ${list}');
              selectedEmpList = list;
              setState(() {
                selectedEmpList = list;
              });
            }),
            SizedBox(height: 16),
            _buildText(
                selectedLead.length == 0
                    ? "Select Lead"
                    : 'selected lead count ${selectedLead.length.toString()}', "Select Lead",
                () async {
              var list = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LeadDialog();
                  });
              print('the list is ${list}');
              selectedLead = list;
              setState(() {
                selectedLead = list;
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
      ),
    );
  }

  editMeeting(MeetingData meetingData, StateSetter setState) {
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    )),
                SizedBox(
                  width: 5.w,
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
            _buildTextField('Title', 'Title', _editmeetingTitleController),
            SizedBox(height: 16),
            _buildTextField(
                'Description', 'Description', _editmeetingDecController),
            SizedBox(height: 16),
            _buildTextField('Link', 'Link', _editmeetingLinkController),
            SizedBox(height: 16),
            _buildText(editSelectDate,"Select Date", () async {
              editSelectDate =
                  await DateTimePickerDialog().pickDateDialog(context);
              if (editSelectDate == null) {
                editSelectDate = "Select Date";
              }
              setState(() {});
            }),
            SizedBox(height: 16),
            _buildText(editSelectTime,"Select Time", () async {
              editSelectTime = await DateTimePickerDialog().selectTime(context);
              if (editSelectTime == null) {
                editSelectTime = "Select Time";
              }
              setState(() {});
            }),
            SizedBox(height: 16),
            _buildText(
                editSelectedEmpList.length == 0
                    ? 'Select Employee'
                    : 'selected emp is ${editSelectedEmpList.length}', "Select Employee",() async {
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
            _buildText(
                editSelectLead.length == 0
                    ? "Select Lead"
                    : 'selected lead ${editSelectLead.length.toString()}',"Select Lead", () async {
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
              onTap: () {
                _editSubmitForm(meetingData);
              },
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
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height:label=="Description"?75.h: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis
              ),
              maxLines: label=="Description"?5:1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                    color: Color(0xffcccccc),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText(String label, String label1,Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Text(
              label1,
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 52.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.r),
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
        ],
      ),
    );
  }

  void _submitForm() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();
    selectedEmpList.add(deatils.data!.id!);
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
    createMeeting.status =  'schedule';
    createMeeting.createdMettingBy = deatils.data!.id;
    createMeeting.leadId = selectedLead[0];
    createMeeting.employeeId = selectedEmpList;
    createMeeting.organisationId = deatils.data!.organisationId;
    var response = await ApiHelper()
        .postParameter(ApiConstant.CREATE_MEETING, createMeeting.toJson());
    print('the response is ${response.response}');
    if (response.status == 200) {
      ApiGetMeeting();
      Navigator.of(context).pop();
    }
  }

  void _editSubmitForm(MeetingData meetingData) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
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
    createMeeting.organisationId = deatils.data!.organisationId;
    Map<String, dynamic> parameter = {
      "active": true,
      "date": editSelectDate,
      "description": dec,
      "id": meetingData.id,
      "meetingLink": link,
      "status": "reschedule",
      "time": editSelectTime,
      "title": title
    };
    print(parameter);
    var data = jsonEncode(parameter);

    Dio dio = Dio();
    var response = await dio.put(ApiConstant.EDIT_MEETING,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the response is ${response}');
    if (response.statusCode == 200) {
     // ToastMessage.show(context, "Meeting Edit Success");
      showCustomToast(context, "Meeting Updated", Icons.check, Colors.green);
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
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 16,
                                    )),
                                Text(
                                  "Showing ${filteredMeetingList.length} out of ${meetingList.length} Results",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w300,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SvgPicture.asset('assets/more_icon.svg')
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),

                Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.all(20),
                  child: filteredMeetingList.isEmpty
                      ? Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height - 400,
                              child: Center(
                                  child: TextView(
                                      title: "No Record Found",
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900))))
                      : Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
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
                            for (int i = 0; i < filteredMeetingList.length; i++)
                              tableRow(context,
                                  time: filteredMeetingList[i].date! +
                                      " " +
                                      filteredMeetingList[i].time!,
                                  guest: filteredMeetingList[i]
                                          .createdMettingBy!
                                          .firstName! +
                                      " " +
                                      filteredMeetingList[i]
                                          .createdMettingBy!
                                          .lastName!,
                                  image: filteredMeetingList[i]
                                      .createdMettingBy!
                                      .image,
                                  meetinglink:
                                      filteredMeetingList[i].meetingLink,
                                  title: filteredMeetingList[i].title,
                                  index: i),
                          ],
                        ),
                ),
              ],
            ),
          );
  }

  bool isJoin = true;

  Widget meetingDetailCard(MeetingData meetingData) {
    final participantCount = meetingData.employeeId?.length ?? 0;

    return Card(
      margin: EdgeInsets.symmetric(vertical:12.h,horizontal: 6.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                getImage(
                  meetingData.createdMettingBy?.image ?? '',
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    meetingData.title ?? "No Title",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(),

            /// Meeting Link
            Text(
              "Meeting Link",
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _launchUrl(meetingData.meetingLink ?? ""),
                    child: Text(
                      meetingData.meetingLink ?? "No link",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Copy Link",
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: meetingData.meetingLink ?? ""),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Link copied!")),
                    );
                  },
                  icon: Icon(Icons.copy, color: Colors.blue),
                ),
                IconButton(
                  tooltip: "Share",
                  onPressed: () {
                    Share.share(
                      "To Join the meeting on Google Meet, click this link:\n${meetingData.meetingLink}",
                      subject: "Please join meet",
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/share_icon.svg',
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            /// Company Name + Participants
            Text(
              meetingData.lead?.companyName ?? "Unknown Company",
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 40.h,
              child: Stack(
                children: [
                  for (int i = 0; i < participantCount && i < 3; i++)
                    Positioned(
                      left: i * 28,
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.blue.shade200,
                        child: getImage(
                          "", // replace with employee image if available
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                    ),
                  if (participantCount > 3)
                    Positioned(
                      left: 3 * 28,
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.redAccent,
                        child: Text(
                          "+${participantCount - 3}",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            /// Date + Time
            Row(
              children: [
                SvgPicture.asset(
                  'assets/time.svg',
                  width: 18.w,
                  height: 18.h,
                ),
                SizedBox(width: 10.w),
                Text(
                  "${meetingData.date ?? ''} ${meetingData.time ?? ''}",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// If creator → Reschedule + Cancel
                if (loginDetails?.data?.id == meetingData.createdMettingBy?.id)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () => _showEditAlertDialog(meetingData),
                        child: Text("Reschedule"),
                      ),
                      SizedBox(width: 5.w),
                      if (meetingData.active == true)
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () => cancelMeetingg(meetingData.id),
                          child: Text("Cancel"),
                        ),
                    ],
                  ),

                /// Participant Buttons
                if (meetingData.active == true)
                  isMeetingCompleted(meetingData.date, meetingData.time)
                      ? OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text("Completed"),
                  )
                      : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ThemeColor.theme_blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      _launchUrl(meetingData.meetingLink ?? "");
                      setState(() => isJoin = true);
                    },
                    child: Text("Join"),
                  )
                else
                  Text(
                    "Inactive Meeting",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  filterIcon() {
    return Container(
        width: 125.w,
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon:  SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {

                },
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem('Sort By Name A to Z',0),
                  _buildPopupMenuItem('Sort By Name Z to A',1),
                  _buildPopupMenuItem("Today's Meeting",4),
                  _buildPopupMenuItem('Upcoming Meetings',2),
                  _buildPopupMenuItem("Completed Meeting",5),
                  _buildPopupMenuItem('All Meetings',3),
                ],
              ),
              Text(
                "Filter",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  final _currentDate = DateTime.now();

  final upcomingDates  = <Widget>[];
  PopupMenuItem _buildPopupMenuItem(
      String title, int? id,
      ) {
    return PopupMenuItem(
      child: Text(title,style: TextStyle(
      fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
        color: Colors.black),),
      onTap: (){
       // ApiGetMeeting();
        if(id==0) {

          filteredMeetingList.sort((b, a) => b.date!.compareTo(a.date!));
          setState(() {});
        }
        else if(id==1) {
          filteredMeetingList.sort((a, b) => b.date!.compareTo(a.date!));
          setState(() {});
        }
        else if(id==2) {
          upcomingMeetingList.clear();
          for (int i = 0; i < 7; i++) {
            final date = _currentDate.add(Duration(days: i));
            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
            print("FormattedDate is :${formattedDate}");
            filteredMeetingList.forEach((element) {
              print("actual date is :${element.date}");
              if(element.date==formattedDate.toString()){
                upcomingMeetingList.add(element);
              }
            });
          }
          setState(() {
            filteredMeetingList.clear();
            filteredMeetingList.addAll(upcomingMeetingList);
          });
        }
        else if(id==4) {
          todayMeetingList.clear();
            final date = _currentDate;
            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
            print("FormattedDate is :${formattedDate}");
            filteredMeetingList.forEach((element) {
              print("actual date is :${element.date}");
              if(element.date==formattedDate.toString()){
                todayMeetingList.add(element);
              }
            });
            setState(() {
            filteredMeetingList.clear();
            filteredMeetingList.addAll(todayMeetingList);
          });
        }
        else if(id==5) {
          setState(() {
            filteredMeetingList.clear();
            filteredMeetingList.addAll(pastMeetingList);
          });
        }
        else{
          ApiGetMeeting();
        }
      },
    );
  }


  Future<void> _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    await launchUrl(
      _url,
     // mode: LaunchMode.externalApplication,
    );
  }

  TableRow tableRow(context, {title, image, guest, meetinglink, time, index}) {
    return TableRow(children: [
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
              TextView(
                  title: title,
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w300)
            ],
          ),
        ),
      ),
      // Designation
      if (!AppResponsive.isMobile(context))
        TextView(
            title: guest,
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w300),
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
          TextView(
              title: meetinglink,
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300)
        ],
      ),

      if (!AppResponsive.isMobile(context))
        TextView(
            title: time,
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w300)
    ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(
          title: text,
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w900),
    );
  }

  Future<void> ApiGetMeeting() async {
    LocalSharePreferences localSharePreferences = LocalSharePreferences();
    LoginDeatils deatils = await localSharePreferences.getLoginData();
    print("EmpId::${deatils.data!.id!}");

    isLoad = true;
    meetingList.clear();
    filteredMeetingList.clear();
    setState(() {});

    print(ApiConstant.GET_EMPLOYE_ALL_METTING(deatils.data!.id!));
    var roleResponse = await ApiHelper()
        .apiGet(ApiConstant.GET_EMPLOYE_ALL_METTING(deatils.data!.id!));

    print('the data is: ${roleResponse.response}');

    if (roleResponse.response["success"] == true) {
      MeetingListResponse meetingResponse =
      MeetingListResponse.fromJson(roleResponse.response);

      meetingList.addAll(meetingResponse.data ?? []);
      filteredMeetingList.clear();
      pastMeetingList.clear();
      rescheduleMeetingList.clear();
      inActiveMeetingList.clear();
      upcomingMeetingList.clear();

      for (var element in meetingList) {
        filteredMeetingList.add(element);

        if (element.status == "reschedule") {
          rescheduleMeetingList.add(element);
        }

        if (element.active == false) {
          inActiveMeetingList.add(element);
        }

        // ✅ Use new time-based expiry check
        if (isMeetingCompleted(element.date, element.time)) {
          pastMeetingList.add(element);
        } else {
          upcomingMeetingList.add(element);
        }
      }

      print("PastMEETING lIST : ${pastMeetingList.length}");
      print("upcomingMEETING lIST : ${upcomingMeetingList.length}");
      setState(() {});
    }

    print('meetingList Length : ${meetingList.length}');
    isLoad = false;
    setState(() {});
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.centerRight,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          // <-- SEE HERE
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return addMeeting(setState);
          }),
        );
      },
    );


  }

  Future<void> _showEditAlertDialog(MeetingData meetingData) async {
    _editmeetingTitleController.text = meetingData.title!;
    _editmeetingDecController.text = meetingData.description!;
    _editmeetingLinkController.text = meetingData.meetingLink!;
    editSelectDate = meetingData.date!;
    editSelectTime = meetingData.time!;
    editSelectLead = [meetingData.lead!.id == null ? 0 : meetingData.lead!.id!];
    editSelectedEmpList = [
      meetingData.lead!.id == null ? 0 : meetingData.lead!.id!
    ];

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.centerRight,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          // <-- SEE HERE
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return editMeeting(meetingData, setState);
          }),
        );
      },
    );

  }

  String? selectedMeetingType = "Your Meetings";
  meetingCard(
    String title,
    String count,
    String img,
    bool isSelected,
    Color bgColor,
  ) {
    return InkWell(
      onTap: () {
      if (title == "Reschedule") {
          filteredMeetingList.clear();
          filteredMeetingList.addAll(rescheduleMeetingList);
          selectedMeetingType = title;
        } else if (title == "Cancelled") {
          filteredMeetingList.clear();
          filteredMeetingList.addAll(inActiveMeetingList);
          selectedMeetingType = title;
        } else {
          ApiGetMeeting();
          selectedMeetingType = "Your Meetings";
        }
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
                color: isSelected ? Color(0xFFC3262C) : Color(0xFFC3262C)),
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

  bool isMeetingCompleted(String? date, String? time) {
    if (date == null || date.isEmpty) return false;

    try {
      // Parse date safely
      DateTime meetingDate = DateFormat("yyyy-MM-dd").parse(date);

      if (time != null && time.isNotEmpty) {
        // Clean extra spaces → "06 : 00 PM" → "06:00 PM"
        String cleanTime = time.replaceAll(" ", "");

        DateTime parsedTime;
        if (cleanTime.contains("AM") || cleanTime.contains("PM")) {
          parsedTime = DateFormat("hh:mm a").parse(cleanTime);
        } else {
          parsedTime = DateFormat("HH:mm").parse(cleanTime);
        }

        meetingDate = DateTime(
          meetingDate.year,
          meetingDate.month,
          meetingDate.day,
          parsedTime.hour,
          parsedTime.minute,
        );
      }

      print("DEBUG :: meetingDateTime = $meetingDate, now = ${DateTime.now()}");
      return DateTime.now().isAfter(meetingDate);
    } catch (e) {
      debugPrint("❌ isMeetingCompleted parse error: $e");
      return false;
    }
  }



  Future<void> cancelMeetingg(int? id) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show(status: "Loading");
    print('the url is ${ApiConstant.CANCEL_MEETING}?active=false&id=${id}');
    Dio dio = Dio();
    var response = await dio.put(ApiConstant.CANCEL_MEETING+"?active=false&id=${id}",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the response is ${response}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
     // ToastMessage.show(context, "Meeting Cancelled");
      showCustomToast(context, "Meeting Cancelled", Icons.clear, Colors.red);
      ApiGetMeeting();
      // Navigator.of(context).pop();
    }
  }


}
