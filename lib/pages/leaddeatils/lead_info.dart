import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/model/response/lead_activity.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/refresh.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
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
import 'package:http/http.dart' as http;

class LeadInfo extends StatefulWidget {
  LeadData leadData;

  LeadInfo({Key? key, required this.leadData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeadInfo();
  }
}

class _LeadInfo extends State<LeadInfo> implements AbRefresh{
  bool isActivity = true;
  bool isReminder = false;
  bool isCreateMail = false;
  bool isMeeting = false;

  LeadActivity? leadActivity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callGetApi();
    _potantialController.text = "0";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Color(0xffF6F6F6),
          child: Column(
            children: [
              HeaderWidget(isSearchVisible:true,),
              SizedBox(
                height: 26.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 10.h, top: 20.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(
                height: 25.h,
              ),
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
                height: 496.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getImage(widget.leadData.lead!.addLogo ?? '',
                                height: 57.h, width: 57.w),
                            SizedBox(
                              width: 32.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    )),
                                Text("Created Date : "+widget.leadData.lead!.date!,
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
                            InkWell(
                              onTap: () {
                                _showAlertDialog();
                              },
                              child:
                                  getIconData('assets/add.svg', onTap: () {}),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => new CupertinoAlertDialog(
                                          title: Text(
                                              'Contact Number : ${widget.leadData.lead!.mobileNumber}',
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
                                  getIconData('assets/call.svg', onTap: () {}),
                            ),
                            InkWell(
                              onTap: () {
                                _showMailAlertDialog();
                              },
                              child:
                                  getIconData('assets/mail.svg', onTap: () {}),
                            ),

                            /* getIconData('assets/more_icon.svg',onTap:(){

                            }),*/
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 63.h,
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
                              child: SvgPicture.asset(
                                Images.emp_tot,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                            SizedBox(
                              width: 23.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("About Me",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                    widget.leadData.lead!.companyName! +
                                        "\n" +
                                        widget.leadData.lead!.mobileNumber! +
                                        "\n" +
                                        widget.leadData.lead!.emailId!,
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
                            height: 180.h,
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
                              child: SvgPicture.asset(
                                Images.location,
                                height: 30.h,
                                width: 30.w,
                              ),
                            ),
                            SizedBox(
                              width: 23.w,
                            ),
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
                            height: 180.h,
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
                                  child: SvgPicture.asset(
                                    "assets/lead_status.svg",
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 23.w,
                                ),
                                Text("Current Lead Status : ${widget.leadData.status}",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            SizedBox(height: 16.h,),
                           /* Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text("${convertedLeadActivity.length}",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColor.red)),
                                    Text("Converted",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 60.w,
                                ),
                                Column(
                                  children: [
                                    Text("${rejectedLeadActivity.length}",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColor.green)),
                                    Text("Rejected",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 60.w,
                                ),
                                Column(
                                  children: [
                                    Text("${pendingLeadActivity.length}",
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.orange)),
                                    Text("Pending",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        )),
                                  ],
                                )
                              ],
                            ),*/
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
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
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
                height: 0.h,
              ),

              Visibility(
                  visible: isActivity,
                  child: LeadActivity(
                    id: widget.leadData.lead!.id!,
                  )),
              Visibility(visible: isReminder, child: LeadReminder()),
              //Visibility(visible:isCreateMail ,child:CreateReminder()),
              Visibility(
                  visible: isCreateMail,
                  child: CreateMail(
                    onlyMail: false,
                    lead:widget.leadData.lead!
                  )),
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

  List<LeadUpdateData> totalLeadActivity = [];
  List<LeadUpdateData> convertedLeadActivity = [];
  List<LeadUpdateData> rejectedLeadActivity = [];
  List<LeadUpdateData> pendingLeadActivity = [];
  void callGetApi()async {
    print("In get activity function");
    try{
      Dio dio=Dio();
      String token = await LocalSharePreferences()
          .getString(SharedPreferencesConstant.AuthToken);
      EasyLoading.show(status: "Loading");
      var response=await dio.get(ApiConstant.GET_ACTIVITY(widget.leadData.lead!.id!),options: Options(headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${token}',
      }));
      print('the activity is ${response.data}');
      if(response.statusCode==200){
        LeadActivityModel leadActivity =LeadActivityModel.fromJson(jsonDecode(response.data));
        totalLeadActivity.addAll(leadActivity.data!);
        totalLeadActivity.forEach((element) {
          if (element.status == null) element.status = "pending";
          totalLeadActivity.add(element);
          if (element.status!.toLowerCase() == "converted") {
            convertedLeadActivity.add(element);
          } else {
            if (element.status!.toLowerCase() == "pending") {
              pendingLeadActivity.add(element);
            } else if (element.status!.toLowerCase() == "rejected") {
              rejectedLeadActivity.add(element);
            }
          }
        });
        setState(() {

        });

      }else{
       // ToastMessage.show(context, "Refresh page");
      }

      EasyLoading.dismiss();
    }catch(e){
      EasyLoading.dismiss();
      print(e);
    }

  }

  tab(bool isSelect, String title) {
    return Container(
      width: 200.w,
      height: 75.h,
      margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
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
    ); /*Container(
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

  getIconData(String icon, {required Function() onTap}) {
    return Container(
      height: 54.h,
      width: 48.w,
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: icon == "assets/more_icon.svg"
              ? Border(
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none)
              : Border.all(color: Colors.black)),
      child: SvgPicture.asset(
        icon,
        height: 30.h,
        width: 30.h,
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
            return addActivity(setState);
          }),
        );
      },
    );
  }

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _potantialController = TextEditingController();
  TextEditingController _sourceofleadController = TextEditingController();
  String selectDate = "";
  int selectedEmp = 0;
  String selectedStatus = "Select Status";

  String? uploadedLeadDocument;
  addActivity(StateSetter stateSetter) {
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
              "FollowUp Lead",
              style: TextStyle(
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 16.h),
          _buildTextField(
              'Description', 'Please Description', _descriptionController),
          SizedBox(height: 16.h),
          _buildText('Document',
              '${uploadedLeadDocument == null ? "Click here to upload document" : uploadedLeadDocument}',
                  () async {
                pickFile(stateSetter,false);
              }),
          SizedBox(height: 16.h),
          _buildText('Next Followup Date',selectDate.length == 0 ? 'Next Followup Date' : selectDate,
              () async {
            selectDate = await DateTimePickerDialog().pickDateDialog(context);
            if (selectDate == null) {
              selectDate = "Next Followup Date";
            }
            stateSetter(() {});
          }),
          SizedBox(height: 16.h),
          _buildText('Next Followup By',
              selectedEmp == 0 ? 'Next Followup By' : "Selected one employee",
              () async {
            int list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialogOne();
                });
            // print('the list is ${list}');
            selectedEmp = list;
            print('the list is$selectedEmp');
            stateSetter(() {
              selectedEmp = list;
            });
          }),
          // _buildTextField('Name Coordinator', _coordinatorController),
          //   _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16.h),
          _buildTextField(
              'Potential', 'Please Enter potential', _potantialController),

          SizedBox(height: 16.h),
          _buildDropdownField('Source Of Lead', 'Please select', stateSetter),
          /* Container(
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
          ),*/

          SizedBox(height: 16.h),
          InkWell(
            onTap: (){
            //  leadActivity!.refresh();
              if(selectDate==''){
                showCustomToast(context, "Please select next followup date", Icons.clear, Colors.red);
              }else if(selectedEmp==0){
                showCustomToast(context, "Please select employee", Icons.clear, Colors.red);
              } else{
                _submitForm(stateSetter);
              }
              if(LeadActivityState.abRefresh != null){
                LeadActivityState.abRefresh!.refreshPage();
              }
              stateSetter(() {
                isActivity=false;
              });
              stateSetter(() {
                isActivity=true;
              });
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
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String dropdownvalue = 'Converted';
  var items = [
    'Converted',
    'Pending',
    'Rejected',
  ];

  Widget _buildDropdownField(
      String label, String hint, StateSetter stateSetter) {
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
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.7),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton(
                value: dropdownvalue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                borderRadius: BorderRadius.circular(5.0),
                underline: SizedBox.shrink(),
                hint: Text(
                  "Source of Lead",
                  style: TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  stateSetter(() {
                    dropdownvalue = newValue!;
                    selectedStatus = dropdownvalue;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText(String label,String hint, Function onClick) {
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
                  hint,
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

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(
            label=="Potential"?"Potential(value between 0 to 10)":label,
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
          height:label=="Description"?100.h: 52.h,
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

  String imgPath = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(StateSetter stateSetter,bool isImg) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      stateSetter(() {
        objFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imageBytes = result.files.first.bytes;
        print(fileName);
        uploadedLeadDocument = isImg?null:fileName;
        print('the url is ${ApiConstant.UPLOAD_LEAD_IMG}');
        var postUri = Uri.parse(ApiConstant.UPLOAD_LEAD_IMG);
        var request = new http.MultipartRequest("POST", postUri);

        Map<String, String> headers = {"Content-Type": "multipart/form-data",'Authorization': 'Bearer ${token}'};
        request.files.add(new http.MultipartFile(
            "image1", objFile!.readStream!, objFile!.size,
            filename: objFile!.name));
        /* request.files.add(new http.MultipartFile(
        "imageFile",filename: objectFile.name));*/
        request.headers.addAll(headers);
        var response = await request.send();
        print(response.statusCode);
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          var jsonData = jsonDecode(value);
          ImgUploadResponse imgUploadResponse =
          ImgUploadResponse.fromJson(jsonData);
          if(isImg){
            imgPath = imgUploadResponse.data!;}else{
            documentPath = imgUploadResponse.data!;}
          print("Uploaded Img Path From s3 bucket::" + imgPath+"\ndocumentPath"+documentPath);
          stateSetter(() {});
        });
        print('the response is ${response}');

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
        //  ToastMessage.show(context, "Image uploaded");
          showCustomToast(context, "Image Uploaded", Icons.check, Colors.green);
        }
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

  void _submitForm(StateSetter stateSetter) async {
    LoginDeatils loginDeatils =
        await LocalSharePreferences.localSharePreferences.getLoginData();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    Dio dio = Dio();
    Map<String, dynamic> parameter = {
      "date": GetDateFormat.getCurrentDate(),
      "description": _descriptionController.text,
      "document": documentPath,
      "isActive": true,
      "lead": widget.leadData.lead!.id!,
      "nextFollowUpBy": selectedEmp,
      "nextFollowupDate": selectDate,
      "potential": 0,
      "status": selectedStatus,
      "updatedByUser": loginDeatils.data!.id,
    };
    print(parameter);
    var para = jsonEncode(parameter);
    print(para);
    var leadResponse = await dio.post(ApiConstant.SAVE_LEAD_UPDATe,
        data: para,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print("Lead Update Response" + leadResponse.data);
    if (leadResponse.statusCode == 200) {
      print('done is done ');
      _descriptionController = TextEditingController();
      _sourceofleadController = TextEditingController();
      selectDate = "";
      selectedEmp = 0;
      selectedStatus = "Select Status";
      stateSetter(() {
      });
      Navigator.pop(context);
    } else {
     // ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    EasyLoading.dismiss();
  }

  @override
  void refreshPage() {
    // TODO: implement refreshPage
    setState(() {

    });
  }
}
