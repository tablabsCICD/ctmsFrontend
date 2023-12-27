import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/lead_model.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_hr_management/utils/camerabottomsheet.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/post_lead.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_info.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../constant/constants.dart';
import '../../model/request/save_lead.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/lead_list.dart';
import '../../utils/constant.dart';
import '../../utils/image_upload.dart';
import '../../utils/sharepreferences.dart';
import '../dashboard/widget/header_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/employee_dialog.dart';
import '../widget/one_emp_dilaog.dart';

class ShortLeadListScreen extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  ShortLeadListScreen(this.scaffoldKey);

  @override
  _ShortLeadListScreen createState() => _ShortLeadListScreen();
}

class _ShortLeadListScreen extends State<ShortLeadListScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _sourceofleadController = TextEditingController();
  TextEditingController _coordinatorController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _typeOfBusinessController = TextEditingController();

  TextEditingController _editnameController = TextEditingController();
  TextEditingController _editemailController = TextEditingController();
  TextEditingController _editphoneController = TextEditingController();
  TextEditingController _editsourceofleadController = TextEditingController();
  TextEditingController _editcoordinatorController = TextEditingController();
  TextEditingController _editaddressController = TextEditingController();
  TextEditingController _edittypeOfBusinessController = TextEditingController();

  List<LeadData> leadData = [];
  List<LeadData> finalLeadData = [];
  List<LeadData> convertedLead = [];
  List<LeadData> rejectedLead = [];
  List<LeadData> pendingLead = [];
  List<LeadData> todaysLeadData = [];
  List<LeadData> dateWiseLead = [];
  bool isLoad = false;
  late EmployeeData empData = EmployeeData();
  int selectedEmp = 0;
  int editselectedEmp = 0;
  bool isRR = false;

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetails();
    ApiGetData("", selectedPageNumber);
    //  getAllEmployee();
    super.initState();
  }

  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.baground,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [

          /// Header Part
          HeaderWidget(
            scaffoldKey: widget.scaffoldKey,
            isSearchVisible: true,
            onSearchTap: (value) {
              filterSearchResults(value);
            },
          ),
          Container(
            margin: EdgeInsets.all(33),
            child: Row(
              children: [
                Text(
                  'Lead Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontFamily: GoogleFonts
                        .poppins()
                        .fontFamily,
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
                      width: 205.w,
                      child: ElevatedButton(
                          onPressed: () async{
                            isRR = await LocalSharePreferences.localSharePreferences.getBool("isRoundRobin");
                            _showAlertDialog(true);
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
                                title: "Upload Short Lead",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 180.w,
                      child: ElevatedButton(
                          onPressed: () async{
                            isRR = await LocalSharePreferences.localSharePreferences.getBool("isRoundRobin");
                            _showAlertDialog(false);
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
                                title: "Add Lead",
                                fontSize: 14.sp,
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
            margin: EdgeInsets.symmetric(horizontal: 33.w, vertical: 20.h),
            child: Row(
              children: [
                leadCountCard('Total Leads', '${totalElements}', '', true,
                    Colors.green.shade50),
                SizedBox(
                  width: 32.w,
                ),
                leadCountCard('Converted', '${convertedLead.length}', '', false,
                    Colors.red.shade50),
                SizedBox(
                  width: 32.w,
                ),
                leadCountCard('Rejected', '${rejectedLead.length}', '', false,
                    Colors.orange.shade50),
                SizedBox(
                  width: 32.w,
                ),
                leadCountCard('Pending', '${pendingLead.length}', '', false,
                    Colors.blue.shade50),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: leadList(context)),
          ),
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total leads : ${leadData.length}');
    finalLeadData.clear();
    debugPrint('Total leads : ${leadData.length}');
    ApiShortLeadSearchData("", selectedPageNumber, query);

    /*leadData.forEach((element) {
      if (element.lead!.companyName!.toLowerCase().contains(query.toLowerCase()) ||
          element.lead!.mobileNumber!.contains(query)) {
        finalLeadData.add(element);
      }
    });*/
    debugPrint('Final Leads : ${finalLeadData.length}');
    setState(() {});
  }

  Future<void> ApiGetData(String URL, int pageNo) async {
    isLoad = true;
    setState(() {});
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.GET_ALL_SHORTLEAD +
        "?organisationId=${loginDeatils!.data!.organisationId}&page=${pageNo}&size=10&sortBy=id&sortDir=asc";
    print("Get All Leads :" + myUrl
    );
    final dio = Dio();
    final response = await dio.get(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    isLoad = false;
    if (response.statusCode == 200) {
      LeadListResponse leadList =
      LeadListResponse.fromJson(jsonDecode(response.data));
      leadData.clear();
      finalLeadData.clear();
      convertedLead.clear();
      pendingLead.clear();
      rejectedLead.clear();
      leadData.addAll(leadList.data!.detailsWithPage! as Iterable<LeadData>);
      totalPages = leadList.data!.totalPages!;
      totalElements = leadList.data!.totalElements!;
      debugPrint("TotalPages:: ${totalPages}\n TotalRecord:: ${totalElements}");
      leadData.forEach((element) {
        finalLeadData.add(element);

        if (element.status == null) element.status = "pending";

        if (element.status!.toLowerCase() == "converted") {
          convertedLead.add(element);
        } else {
          if (element.status!.toLowerCase() == "pending") {
            pendingLead.add(element);
          } else if (element.status!.toLowerCase() == "rejected") {
            rejectedLead.add(element);
          }
        }
        setState(() {});
      });
      print('this is ${leadData.length}');


    }
    setState(() {});
  }


  Future<void> ApiShortLeadSearchData(String URL, int pageNo,String query) async {
    if(query=='') {ApiGetData('', selectedPageNumber);}
    isLoad = true;
    setState(() {});
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.LEAD_SEARCH +
        "?${loginDeatils!.data!.organisationId}&page=${pageNo}&size=10&sortBy=id&sortDir=${"asc"}&searchByKeyword=${query}";
    print("Get All short Leads :" + myUrl
    );
    final dio = Dio();
    final response = await dio.get(
        myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    isLoad = false;
    if (response.statusCode == 200) {
      LeadListResponse leadList =
      LeadListResponse.fromJson(jsonDecode(response.data));
      finalLeadData.clear();
      leadData.clear();
      finalLeadData.addAll(leadList.data!.detailsWithPage! as Iterable<LeadData>);


    }
    setState(() {});
  }

  Future<void> GetFilterdLeadData(int pageNo,String fromDate, String toDate) async {
    isLoad = true;
    setState(() {});
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.LEAD_BETWEEN_TWO_DATE +
        "?page=${selectedPageNumber}&size=10&sortBy=id&sortDir=asc&fromDate=${fromDate}&toDate=${toDate}";
    print("Get All Leads :" + myUrl
    );
    final dio = Dio();
    final response = await dio.get(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      LeadListResponse leadList =
      LeadListResponse.fromJson(jsonDecode(response.data));
      finalLeadData.clear();
      finalLeadData.addAll(leadList.data!.detailsWithPage! as Iterable<LeadData>);
      print('this is ${finalLeadData.length}');
      setState(() {});
      isLoad = false;
    }
  }



  Future<void> _showAlertDialog(bool isShortLead) async {
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
                return isShortLead?uploadLead(setState):addLead(setState);
              }),
        );
      },
    );
  }

  String? uploadedDocument;

  addLead(StateSetter stateSetter){
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
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
                "Add Lead",
                style: TextStyle(
                  fontFamily: GoogleFonts
                      .poppins()
                      .fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
                child: InkWell(
                    onTap: () async {
                      pickFile(stateSetter, true);
                    },
                    child: imgPath == ''
                        ? SvgPicture.asset('assets/upload_profile.svg',
                        height: 202.h, width: 202.w)
                        : CircleAvatar(
                      radius: 75.0,
                      backgroundImage: NetworkImage(imgPath.toString()),
                      backgroundColor: Colors.transparent,
                    ))),
            SizedBox(height: 16.h),
            _buildTextField(
                'Company Name', 'Please Company name', _nameController),
            SizedBox(height: 16.h),
            _buildText(
                '${selectedEmp == 0
                    ? "Select Employee "
                    : "One Employee Selected"}',
                'Select Employee', () async {
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
            SizedBox(height: 16.h),
            _buildTextField(
                'Company Email', 'Please enter your email ID', _emailController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Phone', 'Please enter your phone number', _phoneController),
            SizedBox(height: 16.h),
            _buildDropdownField('Source Of Lead', 'Please select',
                _sourceofleadController, stateSetter),
            SizedBox(height: 16.h),
            _buildTextField('Type Of Business', "Enter type of business",
                _typeOfBusinessController),
            SizedBox(height: 16.h),
            _buildText(
                '${uploadedDocument == null
                    ? "Click here to upload document"
                    : uploadedDocument}',
                'Document', () async {
              pickFile(stateSetter, false);
            }),
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
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: GoogleFonts
                            .poppins()
                            .fontFamily,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  uploadLead(StateSetter stateSetter){
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
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
                "Upload Lead",
                style: TextStyle(
                  fontFamily: GoogleFonts
                      .poppins()
                      .fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
                child: InkWell(
                    onTap: () async {
                      pickXlFile(stateSetter, true);
                    },
                    child: objXlFile == null
                        ? Icon(Icons.file_copy,size: 100,)
                        : Icon(Icons.done_outline,color: Colors.green,size: 100,))),
            SizedBox(height: 16.h),
            Center(
              child: SizedBox(
                height: 45.h,
                width: 120.w,
                child: ElevatedButton(
                    onPressed: () async{
                      pickXlFile(stateSetter, true);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: ThemeColor.theme_blue,
                        onPrimary: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload,
                          size: 18,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        TextView(
                          title: "Browse File",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(height: 25.h),
            TextView(
              title: "Steps to upload the file:",
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            SizedBox(height: 10.h),
            TextView(
              title: "Browse the file from your device",
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            SizedBox(height: 10.h),
            TextView(
              title: 'Click on Submit button to upload the selected file.',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            SizedBox(height: 25.h),
            InkWell(
              onTap: _submitShortLeadForm,
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
                        fontFamily: GoogleFonts
                            .poppins()
                            .fontFamily,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText(String label, String label1, Function onClick) {
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
            width: MediaQuery
                .of(context)
                .size
                .width,
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

  Widget _buildTextField(String label, String hint,
      TextEditingController controller) {
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
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
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

  String dropdownvalue = 'Social Media';
  var items = [
    'Social Media',
    'Referral',
    'Events',
    'Paid Ads'
        'Email Marketing',
    'SEO',
    'Content',
    'Other',
  ];

  Widget _buildDropdownField(String label, String hint,
      TextEditingController controller, StateSetter stateSetter) {
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                    _sourceofleadController.text = dropdownvalue;
                  });
                },
              ),
            ),
          ),
        ),
      ],
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
                icon: SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {},
                itemBuilder: (ctx) =>
                [
                  _buildPopupMenu('Sort By Name A to Z', 0),
                  _buildPopupMenu('Sort By Name Z to A', 1),
                  _buildPopupMenu("Today's Lead", 2),
                  _buildPopupMenu('Date Filter', 3),
                  _buildPopupMenu('All Leads', 4),
                ],
              ),
              Text(
                "Filter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts
                      .poppins()
                      .fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  final _currentDate = DateTime.now();

  PopupMenuItem _buildPopupMenu(String title,
      int? id,) {
    return PopupMenuItem(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16.sp,
            fontFamily: GoogleFonts
                .poppins()
                .fontFamily,
            fontWeight: FontWeight.w500,
            color: Colors.black),
      ),
      onTap: () {
        if (id == 0) {
          leadData.sort(
                  (b, a) =>
                  b.lead!.companyName!.compareTo(a.lead!.companyName!));
          finalLeadData.clear();
          finalLeadData.addAll(leadData);
          setState(() {});
        } else if (id == 1) {
          leadData.sort(
                  (a, b) =>
                  b.lead!.companyName!.compareTo(a.lead!.companyName!));
          finalLeadData.clear();
          finalLeadData.addAll(leadData);
          setState(() {});
        } else if (id == 2) {
          todaysLeadData.clear();
          final date = _currentDate;
          String formattedDate = DateFormat('yyyy-MM-dd').format(date);
          print("FormattedDate is :${formattedDate}");
          leadData.forEach((element) {
            print("actual date is :${element.lead!.date}");
            if (element.lead!.date == formattedDate.toString()) {
              todaysLeadData.add(element);
            }
          });
          setState(() {
            finalLeadData.clear();
            finalLeadData.addAll(todaysLeadData);
          });
        } else if (id == 3) {
          dateWiseLead.clear();
          _showDateWiseDialog();
        } else {
          ApiGetData('', selectedPageNumber);
        }
      },
    );
  }

  void _submitForm() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    DateTime now = DateTime.now();
    String finalDate = DateFormat("yyyy-MM-dd").format(now);
    print(finalDate);

    SaveLeadRequest saveEmploye = SaveLeadRequest();
    _addressController.text = "pune";
    saveEmploye.addLogo = imgPath;
    saveEmploye.document = documentPath;
    saveEmploye.address = _addressController.text;
    saveEmploye.city = _addressController.text;
    saveEmploye.companyName = name;
    saveEmploye.coordinator = loginDeatils.data!.firstName;
    saveEmploye.date = GetDateFormat.getCurrentDate();
    saveEmploye.emailId = email;
    saveEmploye.isEnquiry = 0;
    saveEmploye.leadAssignedTo = selectedEmp;
    saveEmploye.leadAddedBy = loginDeatils.data!.id;
    saveEmploye.mobileNumber = phone;
    saveEmploye.pinCode = '000000';
    saveEmploye.sourceOfLead = _sourceofleadController.text;
    saveEmploye.typeOfBusiness = _typeOfBusinessController.text;

    Map<String, dynamic> requestParameter = {
      "addLogo": imgPath,
      "address": _addressController.text,
      "city": _addressController.text,
      "companyName": name,
      "coordinator": loginDeatils.data!.firstName,
      "date": GetDateFormat.getCurrentDate(),
      "document": documentPath,
      "emailId": email,
      "isEnquiry": 0,
      "leadAddedBy": loginDeatils.data!.id,
      "leadAssignedTo": selectedEmp,
      "mobileNumber": phone,
      "pinCode": "000000",
      "sourceOfLead": _sourceofleadController.text,
      "typeOfBusiness": _typeOfBusinessController.text
    };
    print(requestParameter);
    var reqPara = jsonEncode(requestParameter);
    print(reqPara);
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    //try{
    var response = await dio.post(ApiConstant.SAVE_LEAD,
        data: reqPara,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('Save Lead Response is: ${response.data}');
    if (response.statusCode == 200) {
      PostLead postLead = PostLead.fromJson(jsonDecode(response.data));
      Map<String, dynamic> parameter = {
        "date": GetDateFormat.getCurrentDate(),
        "description": "Lead Created",
        "document": documentPath,
        "isActive": true,
        "lead": postLead.data!.id,
        "nextFollowUpBy": selectedEmp,
        "nextFollowupDate": GetDateFormat.getNextDateOfCurrentDate(),
        "potential": 0,
        "status": "pending",
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
      }
      ApiGetData("", selectedPageNumber);
      Navigator.of(context).pop();
    } else {
      // ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    EasyLoading.dismiss();
    // }catch(e){
    //   EasyLoading.dismiss();
    // }
  }

  void _submitShortLeadForm() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    String myUrl = ApiConstant.UPLOAD_SHORTLEAD;
    debugPrint("Upload short Lead::: "+myUrl);
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer ${token}'
    };
    request.files.add(new http.MultipartFile(
        "file", objXlFile!.readStream!, objXlFile!.size,
        filename: objXlFile!.name));
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      /*var jsonData = jsonDecode(value);
      LeadListResponse leadListResponse =
      LeadListResponse.fromJson(jsonData);
      print(leadListResponse.data!.detailsWithPage!.length);*/
    });
    ApiGetData("", selectedPageNumber);
    Navigator.of(context).pop();
    EasyLoading.dismiss();
    print('the response is ${response}');
  }

  leadList(BuildContext context) {    return Container(

      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                title: selectedLeadType == 'total'
                    ? "All Leads"
                    : selectedLeadType == 'pending'
                    ? "Pending Leads"
                    : selectedLeadType == 'converted'
                    ? "Converted Leads"
                    : "Rejected Leads",
                fontWeight: FontWeight.w600,
                color: AppColor.black,
                fontSize: 24.sp,
              ),
              Container(
                width: 300.w,
                margin: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            getPrevPage(selectedPageNumber);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          )),
                      Text(
                        "Showing ${selectedPageNumber +
                            1}-10 out of ${totalElements} Results",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts
                                .poppins()
                                .fontFamily),
                      ),
                      InkWell(
                          onTap: () {
                            getNextPage(selectedPageNumber);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
          /*  Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),*/
          SizedBox(
            height: 25.h,
          ),
          isLoad
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
              :Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(20),
            child: finalLeadData.isEmpty
                ? Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 400,
                child: Center(
                    child: TextView(
                        title: "No Record Found",
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)))
                : Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(50),
                1: FlexColumnWidth(40),
                2: FlexColumnWidth(40),
                3: FlexColumnWidth(40),
                4: FlexColumnWidth(50),
                5: FlexColumnWidth(30),
              },
              children: [

                /// Table Header
                TableRow(
                  /*decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                  ),*/
                  children: [
                    tableHeader("Name"),
                    tableHeader("Client"),
                    tableHeader("Project"),
                    tableHeader("Contact"),
                    tableHeader("Status"),
                    tableHeader(""),

                    /*if (!AppResponsive.isMobile(context))
                      tableHeader("Email"),
                    tableHeader("Assign to"),
                    if (!AppResponsive.isMobile(context)) tableHeader(""),*/
                  ],
                ),

                /// Table Data

                for (int i = 0; i < finalLeadData.length; i++)
                  tableRow(context, finalLeadData[i],
                      name: finalLeadData[i].lead!.companyName,
                      color: Colors.blue,
                      image: leadData[i].lead!.addLogo,
                      client: finalLeadData[i].lead!.companyName,
                      project: finalLeadData[i].lead!.typeOfBusiness,
                      contact: finalLeadData[i].lead!.mobileNumber,
                      // status: emData[i].lead!.leadAssignedTo!.firstName!+" "+emData[i].lead!.leadAssignedTo!.lastName!,
                      status: finalLeadData[i].status == null
                          ? ""
                          : finalLeadData[i].status!.toUpperCase(),
                      index: i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context, LeadData leadData,
      {name, image, client, project, status, color, index, String? contact}) {
    return TableRow(
        decoration: BoxDecoration(
          /* border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),*/
        ),
        children: [
          //Full Name
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      LeadInfo(
                        leadData: finalLeadData[index],
                      )));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  getImage(image ?? '', height: 30.h, width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  TextView(
                      title: name??"-",
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300)
                ],
              ),
            ),
          ),
          TextView(
              title: client??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: project??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: contact.toString()??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          // TextView(title: status.toString(), fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300),
          Container(
            height: 27.h,
            width: 85.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: status == "CONVERTED"
                    ? Colors.green.shade50
                    : status == "REJECTED"
                    ? Colors.red.shade50
                    : Colors.amber.shade100),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.h),
            margin: EdgeInsets.only(left: 0.w, right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.circle,
                    size: 8,
                    color: status == "CONVERTED"
                        ? Colors.green
                        : status == "REJECTED"
                        ? Colors.red
                        : Colors.amber),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  status??"-",
                  style: TextStyle(
                    color: status == "CONVERTED"
                        ? Colors.green
                        : status == "REJECTED"
                        ? Colors.red
                        : Colors.amber,
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts
                        .poppins()
                        .fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                /*  SizedBox(width: 10.w,),
                Icon(Icons.arrow_drop_down_outlined,size: 18,
                    color: status =="Converted"?Colors.green:status=="Rejected"?Colors.red:Colors.amber),*/
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.only(bottom: 20),
                  icon: Icon(Icons.arrow_drop_down_outlined,
                      size: 18,
                      color: status == "CONVERTED"
                          ? Colors.green
                          : status == "REJECTED"
                          ? Colors.red
                          : Colors.amber),
                  onSelected: (value) {
                    print("Final Status Value:" + value.toString());
                    int lastLeadUpdateIndex =
                        finalLeadData[index].leadUpdates!.length - 1;
                    print("lastLeadUpdateIndex is ${lastLeadUpdateIndex}");
                    callChangeStatusApi(lastLeadUpdateIndex, value);
                    setState(() {
                      status = value;
                    });
                  },
                  itemBuilder: (ctx) =>
                  [
                    _buildPopupMenuItem('Converted', index),
                    _buildPopupMenuItem('Pending', index),
                    _buildPopupMenuItem('Rejected', index),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    showAlertDialog(context, index);
                  },
                  child: Icon(Icons.delete, color: Colors.red)),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                  onTap: () {
                    //  _showAlertDialog();
                    editleadDilaog(leadData);
                  },
                  child: Icon(Icons.edit, color: Colors.grey)),
            ],
          )
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

  showAlertDialog(BuildContext context, int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        callDelete(index);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete !"),
      content: Text("Do you want to delete this lead ?"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void callDelete(int index) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    Dio dio = Dio();
    var response = await dio.delete(ApiConstant.LEAD_DELTEB,
        queryParameters: {"id": finalLeadData[index].lead!.id!},
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    if (response.statusCode == 200) {
      finalLeadData.removeAt(index);
      leadData.removeAt(index);
      setState(() {});
    } else {
      // ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
  }

  Widget _buildTextOne(String label) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Employee'),
                content: setupAlertDialoadContainer(),
              );
            });
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            //margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), Icon(Icons.arrow_drop_down_outlined)],
            ),
          ),
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Constants.allEmployee.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // selectRole=dataRole[index].id!;
              // selectedRole=dataRole[index].name!;
              empData = Constants.allEmployee[index];
              Navigator.pop(context);
              setState(() {});
            },
            child: ListTile(
              title: Text(Constants.allEmployee[index].firstName! +
                  " " +
                  Constants.allEmployee[index].lastName!),
            ),
          );
        },
      ),
    );
  }

  String selectedLeadType = "total";

  leadCountCard(String title,
      String count,
      String img,
      bool isSelected,
      Color bgColor,) {
    return InkWell(
      onTap: () {
        if (title == "Pending") {
          finalLeadData.clear();
          finalLeadData.addAll(pendingLead);
          selectedLeadType = "pending";
        } else if (title == "Converted") {
          finalLeadData.clear();
          finalLeadData.addAll(convertedLead);
          selectedLeadType = "converted";
        } else if (title == "Rejected") {
          finalLeadData.clear();
          finalLeadData.addAll(rejectedLead);
          selectedLeadType = "rejected";
        } else {
          finalLeadData.clear();
          finalLeadData.addAll(leadData);
          selectedLeadType = "total";
        }
        setState(() {
          isSelected = true;
        });
      },
      child: Container(
        width: 243.w,
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
                Images.emp_tot,
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

  editleadDilaog(LeadData leadData) {
    //   editselectedEmp = leadData.lead!.leadAssignedTo!.id!;
    _editnameController.text = leadData.lead!.companyName!;
    _editemailController.text = leadData.lead!.emailId!;
    _editphoneController.text = leadData.lead!.mobileNumber!;
    _editsourceofleadController.text = leadData.lead!.sourceOfLead!;
    _editcoordinatorController.text = leadData.lead!.coordinator!;
    _editaddressController.text = leadData.lead!.address!;
    _edittypeOfBusinessController.text = leadData.lead!.typeOfBusiness!;

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
                return EditLeadLead(leadData, setState);
              }),
        );
      },
    );
  }

  EditLeadLead(LeadData leadData, StateSetter stateSetter) {
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
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
                "Edit Lead",
                style: TextStyle(
                  fontFamily: GoogleFonts
                      .poppins()
                      .fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
                child: InkWell(
                    onTap: () async {
                      pickFile(stateSetter, true);
                    },
                    child: imgPath == ''
                        ? SvgPicture.asset('assets/upload_profile.svg',
                        height: 202.h, width: 202.w)
                        : Container(
                        height: 200.h,
                        width: 408.w,
                        alignment: Alignment.center,
                        child: Image.network(
                          imgPath,
                          width: 202.w,
                        )))),
            SizedBox(height: 16.h),
            _buildTextField(
                'Company Name', 'Please Comapny name', _editnameController),
            SizedBox(height: 16.h),
            _buildText(
                '${editselectedEmp == 0
                    ? "Select Employee "
                    : "One Employee Selected"}',
                'Select Employee', () async {
              int list = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EmpDialogOne();
                  });
              // print('the list is ${list}');
              editselectedEmp = list;
              print('the list is$selectedEmp');
              stateSetter(() {
                editselectedEmp = list;
              });
            }),
            SizedBox(height: 16.h),
            _buildTextField(
                'Email', 'Please enter your email ID', _editemailController),
            SizedBox(height: 16.h),
            _buildTextField('Phone', 'Please enter your phone number',
                _editphoneController),
            SizedBox(height: 16.h),
            _buildDropdownField('Source Of Lead', 'Please select',
                _sourceofleadController, stateSetter),
            SizedBox(height: 16.h),
            _buildTextField('typeOfBusiness', "Enter type of business",
                _edittypeOfBusinessController),
            /*ElevatedButton(
              onPressed: _submitForm,
              child: Center(child: Text('Submit')),
            ),*/
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                submitEditForm(leadData);
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
                        fontFamily: GoogleFonts
                            .poppins()
                            .fontFamily,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void submitEditForm(LeadData leadData) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _editnameController.text.toString();
    String email = _editemailController.text.toString();
    String phone = _editphoneController.text.toString();
    SaveLeadRequest saveEmploye = SaveLeadRequest();
    saveEmploye.id = leadData.lead!.id;
    saveEmploye.companyName = name;
    saveEmploye.coordinator = loginDeatils.data!.firstName;
    saveEmploye.emailId = email;
    saveEmploye.mobileNumber = phone;
    saveEmploye.address = _editaddressController.text;
    saveEmploye.sourceOfLead = _editsourceofleadController.text;
    saveEmploye.typeOfBusiness = _edittypeOfBusinessController.text;
    saveEmploye.leadAssignedTo = editselectedEmp;
    saveEmploye.leadAddedBy = loginDeatils.data!.id;
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    //try{
    var response = await dio.put(ApiConstant.UPDATE_LEAD,
        data: jsonEncode(saveEmploye.toJson()),
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    if (response.statusCode == 200) {
      PostLead postLead = PostLead.fromJson(jsonDecode(response.data));
      Map<String, dynamic> parameter = {
        "date": GetDateFormat.getCurrentDate(),
        "description": " Lead Created ",
        "document": documentPath,
        "isActive": true,
        "lead": postLead.data!.id,
        "nextFollowUpBy": editselectedEmp,
        "nextFollowupDate": GetDateFormat.getNextDateOfCurrentDate(),
        "potential": 0,
        "status": "Pending",
        "updatedByUser": loginDeatils.data!.id,
      };
      var para = jsonEncode(parameter);
      var leadResponse = await dio.post(ApiConstant.SAVE_LEAD_UPDATe,
          data: para,
          options: Options(headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
          }));
      if (leadResponse.statusCode == 200) {
        print('done is done ');
      }
      Navigator.pop(context);
      ApiGetData("", selectedPageNumber);
    } else {
      // ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    EasyLoading.dismiss();
    // }catch(e){
    //   EasyLoading.dismiss();
    // }
  }

  String? selectedStatus;

  PopupMenuItem _buildPopupMenuItem(String title,
      int? id,) {
    return PopupMenuItem(
      child: Text(title),
      onTap: () {
        int lastLeadUpdateIndex = finalLeadData[id!].leadUpdates!.length - 1;
        print(
            "lastLeadUpdateIndex is ${lastLeadUpdateIndex} and value is ${finalLeadData[id]
                .leadUpdates![lastLeadUpdateIndex].id}");
        callChangeStatusApi(
            finalLeadData[id].leadUpdates![lastLeadUpdateIndex].id!, title);
        print("Final Title Value:" + title.toString());
        setState(() {
          selectedStatus = title;
        });
        print("Final selected Value:" + selectedStatus.toString());
      },
    );
  }

  Future<void> callChangeStatusApi(int id, Object? value) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    EasyLoading.show(status: "Loading");
    print('the url is ${ApiConstant.UPDATE_LEAD_STATUS}');
    Map<String, dynamic> parameter = {"id": id, "status": value.toString()};
    print(parameter);
    var data = jsonEncode(parameter);
    Dio dio = Dio();
    var response = await dio.put(ApiConstant.UPDATE_LEAD_STATUS,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the response is ${response}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      // ToastMessage.show(context, "Status updated");
      showCustomToast(context, "Status Updated", Icons.check, Colors.green);
      ApiGetData('', selectedPageNumber);
      // Navigator.of(context).pop();
    }
  }

  String selectedFromDate = '';
  String selectedToDate = '';

  Future<void> _showDateWiseDialog() async {
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
              builder: (BuildContext context, StateSetter stateSetter) {
                return Container(
                  width: 350.w,
                  height: 350.h,
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close,size: 20,),
                        ),
                      ),
                      Align(
                        alignment:Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: _buildText(
                                  selectedFromDate, "Select From Date", () async {
                                selectedFromDate =
                                await DateTimePickerDialog().pickBeforeDateDialog(
                                    context);
                                if (selectedFromDate == null) {
                                  selectedFromDate = "Select From Date";
                                }
                                stateSetter(() {});
                              }),
                            ),
                            SizedBox(height: 20.h,),
                            SizedBox(
                              width: 200.w,
                              child: _buildText(
                                  selectedToDate, "Select To Date", () async {
                                selectedToDate =
                                await DateTimePickerDialog().pickBeforeDateDialog(context);
                                if (selectedToDate == null) {
                                  selectedToDate = "Select To Date";
                                }
                                stateSetter(() {});
                              }),
                            ),
                            SizedBox(height: 20.h,),
                            SizedBox(
                              height: 50.h,
                              child: ElevatedButton(
                                  onPressed: () async{
                                    isLoad = true;
                                    setState(() {});
                                    String token = await LocalSharePreferences()
                                        .getString(SharedPreferencesConstant.AuthToken);
                                    String myUrl = ApiConstant.LEAD_BETWEEN_TWO_DATE +
                                        "?page=${selectedPageNumber}&size=10&sortBy=id&sortDir=asc&fromDate=${selectedFromDate}&toDate=${selectedToDate}";
                                    print("Get All Leads :" + myUrl
                                    );
                                    final dio = Dio();
                                    final response = await dio.get(
                                        myUrl,
                                        options: Options(headers: {
                                          "Content-Type": "application/json",
                                          'Authorization': 'Bearer ${token}',
                                        }));
                                    print(response.data);
                                    isLoad = false;
                                    if (response.statusCode == 200) {
                                      LeadListResponse leadList =
                                      LeadListResponse.fromJson(jsonDecode(response.data));
                                      finalLeadData.clear();
                                      finalLeadData.addAll(leadList.data!.detailsWithPage! as Iterable<LeadData>);
                                      print('this is ${leadData.length}');
                                    }
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: ThemeColor.theme_blue,
                                      onPrimary: Colors.white),
                                  child: TextView(
                                    title: "Search",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  String imgPath = '';
  String documentPath = '';
  PlatformFile? objFile;
  PlatformFile? objXlFile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(StateSetter stateSetter, bool isImg) async {
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
        uploadedDocument = isImg ? null : fileName;
        print('the url is ${ApiConstant.UPLOAD_LEAD_IMG}');
        var postUri = Uri.parse(ApiConstant.UPLOAD_LEAD_IMG);
        var request = new http.MultipartRequest("POST", postUri);

        Map<String, String> headers = {
          "Content-Type": "multipart/form-data",
          'Authorization': 'Bearer ${token}'
        };
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
          if (isImg) {
            imgPath = imgUploadResponse.data!;
          } else {
            documentPath = imgUploadResponse.data!;
          }
          print("Uploaded Img Path From s3 bucket::" +
              imgPath +
              "\ndocumentPath" +
              documentPath);
          stateSetter(() {});
        });
        print('the response is ${response}');

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          // ToastMessage.show(context, "Image uploaded");
          showCustomToast(context, "Image Uploaded", Icons.check, Colors.green);
        }
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

  pickXlFile(StateSetter stateSetter, bool isImg) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      stateSetter(() {
        objXlFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imageBytes = result.files.first.bytes;
        print(fileName);
        uploadedDocument = isImg ? null : fileName;
          showCustomToast(context, "File Uploaded", Icons.check, Colors.green);
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

  int selectedPageNumber = 0;
  int totalPages = 0;
  int totalElements = 0;

  void getPrevPage(selectedPageNumer) {
    if (selectedPageNumber == 0) {
      ApiGetData("", selectedPageNumber);
    } else if (selectedPageNumber > 0) {
      selectedPageNumber--;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }

  void getNextPage(selectedPageNumer) {
    if (selectedPageNumber < totalPages - 1) {
      selectedPageNumber++;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }
}
