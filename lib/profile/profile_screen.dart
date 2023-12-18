import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/model/request/update_emp.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/create_mail.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_colors.dart';

class ProfileInfo extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  ProfileInfo(this.scaffoldKey);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late LoginDeatils loginDeatils;
  bool isload=true;

  @override
  void initState() {
    // TODO: implement initState
    inCallData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  isload?Center(
      child: CircularProgressIndicator(),

    ):Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWidget(isSearchVisible:false,scaffoldKey: widget.scaffoldKey,),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                margin: EdgeInsets.fromLTRB(39,33,39,33),
                decoration: BoxDecoration(
                   color: AppColor.white,
                   borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                           // getImage(loginDeatils.data!.image!,height: 200.h,width: 200.w),
                            CircleAvatar(
                              radius: 80.0,
                              backgroundImage:
                              NetworkImage(imgPath==''?loginDeatils.data!.image.toString():imgPath),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(height: 10.h,),
                            InkWell(
                              onTap: (){
                                pickFile(context,setState);
                                setState(() {
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt,size: 20,color: Colors.blue,),
                                  SizedBox(width: 5.w,),
                                  Text(
                                    "Edit Profile Image",
                                    style: TextStyle(color: Colors.blue,
                                      fontSize: 16.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w500,),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 220.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                               loginDeatils.data!.firstName!+" "+loginDeatils.data!.lastName!,
                                style: TextStyle(color: Colors.black,
                                  fontSize: 40.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w500,),
                              ),
                              SizedBox(height: 10.h,),
                              Text(
                                loginDeatils.data!.designation!,
                                style: TextStyle(color: Colors.black,
                                  fontSize: 20.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w300,),
                              ),
                             /* SizedBox(height: 20.h,),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/images/fb_logo.svg',height: 25.h,width: 25.h,),
                                  SizedBox(width: 25.w,),
                                  SvgPicture.asset('assets/images/gmail_logo.svg',height: 25.h,width: 25.h,),
                                ],
                              )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => new CupertinoAlertDialog(
                                  title: Text(
                                      'Contact Number : ${loginDeatils.data!.mobileNumber}',
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
                          onTap: (){_showMailAlertDialog(context);},
                          child:getIconData('assets/mail.svg',onTap:(){

                          }),
                        )

                       /* getIconData('assets/more_icon.svg',onTap:(){

                        }),*/
                      ],
                    )
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 33,vertical: 20),
              margin: EdgeInsets.fromLTRB(39,33,39,33),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /* Text(
                    "About",
                    style: TextStyle(color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Engginering degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                    style: TextStyle(color: Colors.grey,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w300,),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.pin_drop_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            loginDeatils.data!.address==null?'':loginDeatils.data!.address!,
                            style: TextStyle(color: Colors.grey,
                              fontSize: 20.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w300,),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.watch_later),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Contact Info",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Email : ${loginDeatils.data!.emailId!}",
                            style: TextStyle(color: Colors.grey,
                              fontSize: 20.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w300,),
                          ),

                          Text(
                            "Mobile : ${loginDeatils.data!.mobileNumber}",
                            style: TextStyle(color: Colors.grey,
                              fontSize: 20.sp,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w300,),
                          )
                        ],
                      )
                    ],
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  String imgPath = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(BuildContext context,StateSetter stateSetter) async {
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
        print('the url is ${ApiConstant.UPLOAD_LEAD_IMG}');
        var postUri = Uri.parse(ApiConstant.UPLOAD_LEAD_IMG);
        var request = new http.MultipartRequest("POST", postUri);

        Map<String, String> headers = {"Content-Type": "multipart/form-data",'Authorization': 'Bearer ${token}'};
        request.files.add(new http.MultipartFile(
            "image1", objFile!.readStream!, objFile!.size,
            filename: objFile!.name));
        request.headers.addAll(headers);
        var response = await request.send();
         print(response.statusCode);
        response.stream.transform(utf8.decoder).listen((value) async {
          print(value);
          var jsonData = jsonDecode(value);
          ImgUploadResponse imgUploadResponse =
          ImgUploadResponse.fromJson(jsonData);
          imgPath = imgUploadResponse.data!;
          await editEmgProfile(context);
          print("Uploaded Img Path From s3 bucket::" + imgPath);
          setState(() {

          });
        });
        print('the response is ${response}');

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
         // ToastMessage.show(context, "Image uploaded");
          showCustomToast(context, "Image Updated", Icons.check, Colors.green);
        }
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

  editEmgProfile(BuildContext context) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    UpdateEMP saveEmploye=UpdateEMP();
    saveEmploye.firstName=loginDeatils.data!.firstName;
    saveEmploye.lastName=loginDeatils.data!.lastName;
    saveEmploye.image = imgPath;
    saveEmploye.emailId=loginDeatils.data!.emailId;
    saveEmploye.address=loginDeatils.data!.address;
    saveEmploye.mobileNumber=loginDeatils.data!.mobileNumber;
    saveEmploye.id=loginDeatils.data!.id;
    print(saveEmploye.toJson());
    Dio dio=Dio();
    var response=await dio.put(ApiConstant.EDIT_EMP,data: jsonEncode(saveEmploye.toJson()),options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response);
    if(response.statusCode==200){
      LoginDeatils loginDeatils = LoginDeatils.fromJson(jsonDecode(response.data));
      if (loginDeatils.data != null) {
        String response = jsonEncode(loginDeatils);
        LocalSharePreferences()
            .setString(SharedPreferencesConstant.LoginKey, response);
      }else {
        //ToastMessage.show(context, loginDeatils.message!);
        showCustomToast(context, loginDeatils.message!, Icons.clear, Colors.red);
      }
      showCustomToast(context, "Emp Edit Success", Icons.check, Colors.green);
    }
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

  Future<void> _showMailAlertDialog(context) async {
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
                return CreateMail(onlyMail: true,);
              }),
        );
      },
    );
  }

  void inCallData()async {

    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    isload=false;
    setState(() {

    });
  }
}

class IconTile extends StatelessWidget {
  final String? imgAssetPath;
  final Color? backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath!,
          width: 20,
        ),
      ),
    );
  }



}