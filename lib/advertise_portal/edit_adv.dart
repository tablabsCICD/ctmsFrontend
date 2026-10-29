

import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/advertise_portal/advertise_side_bar_menu.dart';
import 'package:flutter_hr_management/advertise_portal/model/advertise_model.dart';
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_list.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import 'package:http/http.dart'as http;

class EditAdvertisePage extends StatefulWidget {
  AdvertiseData advData;
  EditAdvertisePage(this.advData);

  @override
  _EditAdvertisePageState createState() => _EditAdvertisePageState();
}

class _EditAdvertisePageState extends State<EditAdvertisePage> {

  TextEditingController _bannerNameController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _hyperLinkController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _transactionIdController = TextEditingController();
  TextEditingController _imgController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _noOfDaysController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  String selectedFromDate='',selectedToDate='',uploadedDocument='';
  final orgProvider = locator<OrgProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  //  getLoginDetails();
    //_companyNameController.text = orgProvider.orgnization[0].companyName!;
  }

  setData(){
      _bannerNameController.text = widget.advData.bannerName!;
      _companyNameController.text = widget.advData.companyName!;
      _categoryController.text = widget.advData.category!;
      _mobileNumberController.text = widget.advData.conatctNumber!;
      _noOfDaysController.text =  widget.advData.numberOfDays!.toString();
      _hyperLinkController.text = widget.advData.bannerHyperlink!;
      _transactionIdController.text = widget.advData.transactionId!;
      selectedFromDate = widget.advData.startDate!;
      selectedToDate = widget.advData.endDate!;
      uploadedDocument = widget.advData.adImage!;
      documentPath = widget.advData.adImage!;
      _locationController.text = widget.advData.location!;
  }

  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
    getCompanyDetail();
  }

  final advProvider = locator<AdvProvider>();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: ThemeColor.baground,
      body: Consumer<AdvProvider>(
        builder: (context, model, child) => Container(
         // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap:(){Navigator.of(context).pop();},
                    child: Icon(Icons.arrow_back,size: 20,)),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 33,vertical: 20),
                  alignment: Alignment.center,
                  child: Text(
                    'Edit Advertise',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                _buildTextField('Title', "Enter title",
                    _bannerNameController),
                SizedBox(height: 16.h),
                _buildTextField('Company Name', "Enter company name",
                    _companyNameController),
                SizedBox(height: 16.h),
                _buildTextField('Advertise Link', "Enter link",
                    _hyperLinkController),
                SizedBox(height: 16.h),
                _buildTextField('Contact Number', "Enter mobile Number",
                    _mobileNumberController),
                SizedBox(height: 16.h),
                _buildTextField('Category', "Enter advertise category",
                    _categoryController),
                SizedBox(height: 16.h),
                _buildText(
                    '${uploadedDocument == ""
                        ? "Click here to upload Image"
                        : uploadedDocument}',
                    'Advertise Image/Video', () async {
                  pickFile(setState, false);
                }),
                SizedBox(height: 16.h),
                _buildText(
                    selectedFromDate, "Select Start Date", () async {
                  selectedFromDate =
                  await DateTimePickerDialog().pickDateDialog(
                      context);
                  if (selectedFromDate == "") {
                    selectedFromDate = "Select Start Date";
                  }
                  setState(() {

                  });
                }),
                SizedBox(height: 16.h,),
                _buildText(
                    selectedToDate, "Select End Date", () async {
                  selectedToDate =
                  await DateTimePickerDialog().pickDateAfterDialog(context,selectedFromDate);
                  DateTime tempFromDate = DateTime.now();
                  if (selectedToDate == "") {
                    tempFromDate = new DateFormat("yyyy-MM-dd").parse(selectedFromDate);
                    selectedToDate = DateFormat("yyyy-MM-dd").format(tempFromDate.add(const Duration(days: 5)));
                  }
                  DateTime tempToDate = new DateFormat("yyyy-MM-dd").parse(selectedToDate);
                  final difference = tempToDate.difference(tempFromDate).inDays;
                  _noOfDaysController.text = difference.toString();
                  setState(() {});
                }),
                selectedToDate==""?SizedBox.shrink():Text(
                  "default end date is (5 days) after start days",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildTextField('Number of days', "Enter number of days adv to be displayed",
                    _noOfDaysController),
                SizedBox(height: 16.h),
                _buildTextField('Transaction Id', "Enter transaction Id",
                    _transactionIdController),
                SizedBox(height: 16.h),
                _buildTextField('Location', "Enter Location",
                    _locationController),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () async {
                    final bool mobileValid =
                    RegExp(r'^\+?\d{1,3}[\s-]?\(?\d{1,4}\)?[\s-]?\d{6,10}$')
                        .hasMatch(_mobileNumberController.text);
                    if(_bannerNameController.text==''){
                      showCustomToast(context, "Enter Title", Icons.close, Colors.red);
                    } else if(uploadedDocument==""){
                      showCustomToast(context, "First upload image", Icons.close, Colors.red);
                    }else  if(_mobileNumberController==""){
                      showCustomToast(context, "Enter mobile number", Icons.close, Colors.red);
                      /* }else if(mobileValid==false){
                      showCustomToast(context, "Enter valid mobile number", Icons.close, Colors.red);*/
                    }else
                    if(selectedFromDate==""){
                      showCustomToast(context, "Enter valid start date", Icons.close, Colors.red);
                    }else if(selectedToDate==''){
                      showCustomToast(context, "Enter valid end date", Icons.close, Colors.red);
                    }else {
                      EasyLoading.show(status: "Loading");
                      int code = await model.editAdvertise(
                          id: widget.advData.id,
                          transactionId: _transactionIdController.text,
                          startDate: trimDateTime(selectedFromDate),
                          endDate: trimDateTime(selectedToDate),
                          category: _categoryController.text,
                          numberOfDays: _noOfDaysController.text,
                          companyName: _companyNameController.text,
                          bannerHyperlink: _hyperLinkController.text,
                          bannerName: _bannerNameController.text,
                          adImage: documentPath,
                          contact: _mobileNumberController.text,
                        location: _locationController.text
                      );
                      if(model.isLoading==false) EasyLoading.dismiss();
                      if(code==200){
                        showCustomToast(context, "Advertisement updated successfully", Icons.check, Colors.green);
                       // Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, AppRoutes.advertise_home);
                      }else{
                        showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
                      }
                    }
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
                        "Edit",
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
        ),
      ),
    );
  }

  CtmsOrganization? ctmsOrganization;

  Future<void> getCompanyDetail() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.BASE_URL +
        "api/Organisation/getById?Id=${loginDeatils!.data!.organisationId}";
    print("Get Organization Details :" + myUrl);
    final dio = Dio();
    final response = await dio.get(myUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    //  print(response.data);
    if (response.statusCode == 200) {
      CtmsOrganizationResponse ctmsOrganizationResponse =
      CtmsOrganizationResponse.fromJson(jsonDecode(response.data));
      ctmsOrganization = ctmsOrganizationResponse.data!;
      print('this is ${ctmsOrganization}');
    }
    setState(() {});
  }

  String imgPath = '';
  String documentPath = '';
  PlatformFile? objFile;
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
        print(await result.files.first
            .toString()
            .length);
        //  uploadedDocument = isImg ? null : fileName;

        uploadedDocument = fileName!;
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
          documentPath = imgUploadResponse.data!;

          print("Uploaded Img Path From s3 bucket::" +
              documentPath);
          stateSetter(() {});
        });
        print('the response is ${response}');

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          showCustomToast(
              context, "Image/Video Uploaded", Icons.check, Colors.green);
        }

      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
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
            height: label1=="Advertise Image/Video"?100.h:52.h,
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
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
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
                readOnly: label=="Number of days"?true:false,
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
        ),
      ],
    );
  }

  String trimDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }


}
