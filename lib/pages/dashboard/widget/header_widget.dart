import 'dart:convert';
import 'dart:typed_data';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/editText_email.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../constant/constants.dart';
import 'package:http/http.dart' as http;

class HeaderWidget extends StatefulWidget {
  Function? onSearchTap;
  bool? isSearchVisible;

  HeaderWidget({Key? key, this.onSearchTap, required this.isSearchVisible})
      : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetails();
    getCompanyDetail();
    super.initState();
  }

  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  final orgProvider = locator<OrgProvider>();
  Organization? organization;

  Future<void> getCompanyDetail() async {
    await orgProvider.getCompanyDetails(1);
    organization = orgProvider.orgnization[0];
    setupData();
  }

  setupData() {
    imgPath = organization!.companyLogo!;
    _companyNameController.text = organization!.companyName!;
    _emailController.text = organization!.officialEmailId!;
    _mobileController.text = organization!.companyMobileNumber!;
    _addressController.text = organization!.companyAddress!;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? SizedBox(
            height: 60.h,
            width: 60.h,
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.white,
            height: 111.h,
            child: Row(
              children: [
                if (!AppResponsive.isDesktop(context))
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: AppColor.black,
                    ),
                    onPressed: () {},
                  ),
                widget.isSearchVisible == true
                    ? searchBar()
                    : SizedBox.shrink(),
                if (!AppResponsive.isMobile(context)) ...{
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // navigationIcon(icon: Icons.search),
                      // navigationIcon(icon: Icons.send),
                      //navigationIcon(icon: Icons.notifications_none_rounded),

                      InkWell(
                        onTap: () {
                          Navigator.restorablePushReplacementNamed(
                              context, AppRoutes.profile);
                        },
                        child: Text('${Constants.LOGIN_NAME}',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: GoogleFonts.poppins().fontFamily)),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: getImage(
                            details!.data!.image == null
                                ? ''
                                : details!.data!.image!,
                            height: 50.h,
                            width: 50.w),
                      ),
                      SizedBox(
                        width: 27.w,
                      ),
                     /* Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            showAlignedDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return _notificationDialogBuilder(
                                        context, setState);
                                  });
                                },
                                followerAnchor: Alignment.topLeft,
                                targetAnchor: Alignment.bottomLeft,
                                barrierColor: Colors.transparent);
                          },
                          child: Container(
                              width: 50.w,
                              height: 50.h,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  Images.notification,
                                  color: Colors.black,
                                  height: 30.h,
                                  width: 30.w,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeColor.baground)),
                        );
                      }),
                      SizedBox(
                        width: 27.w,
                      ),*/
                      Container(
                        width: 50.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ThemeColor.baground),
                        child: PopupMenuButton(
                          position: PopupMenuPosition.over,
                          icon: Icon(Icons.settings,
                              color: Colors.black, size: 30.h),
                          itemBuilder: (ctx) => [
                            PopupMenuItem(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return Switch(
                                      // This bool value toggles the switch.
                                      value: notificationSwitchValue,
                                      overlayColor: overlayColor,
                                      trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white),
                                      onChanged: (bool value) {
                                        print("switch value: ${value}");
                                        setState(() {
                                          notificationSwitchValue = value;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                            PopupMenuItem(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "RoundRobin",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return Switch(
                                      // This bool value toggles the switch.
                                      value: rrSwitchValue,
                                      overlayColor: overlayColor,
                                      trackColor: trackColor,
                                      thumbColor:
                                          const MaterialStatePropertyAll<Color>(
                                              Colors.white),
                                      onChanged: (bool value) {
                                        print("switch value: ${value}");
                                        setState(() {
                                          rrSwitchValue = value;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                            PopupMenuItem(
                              child: Text(
                                "Update Company Profile",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      alignment: Alignment.centerRight,
                                      backgroundColor: Colors.transparent,
                                      insetAnimationDuration:
                                          Duration(milliseconds: 200),
                                      insetAnimationCurve: Curves.easeOutExpo,
                                      child: StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return EditCompany(setState);
                                      }),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 27.w,
                      ),
                    ],
                  )
                }
              ],
            ),
          );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }

  searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 121.w, top: 23.h, bottom: 25.h),
      width: 414.w,
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(43), color: Color(0xfff6f6f6)),
      child: edittext(),
    );
  }

  edittext() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        width: 414.w,
        height: 60.h,
        alignment: Alignment.center,
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            widget.onSearchTap!(value);
          },
          decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              suffixIcon: Icon(CupertinoIcons.search, color: Color(0xff7F7E7E)),
              hintStyle: TextStyle(
                color: Color(0x662C363F),
                fontSize: 18.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
              )),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  LoginDeatils? details;
  bool isLoading = false;

  void getLoginDetails() async {
    isLoading = true;
    setState(() {});
    details = await LocalSharePreferences().getLoginData();
    Constants.LOGIN_NAME =
        details!.data!.firstName! + " " + details!.data!.lastName!;
    isLoading = false;
    setState(() {});
  }

  bool notificationSwitchValue = false;
  bool rrSwitchValue = false;
  final MaterialStateProperty<Color?> trackColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return ThemeColor.theme_blue;
      }
      return null;
    },
  );
  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return ThemeColor.theme_blue.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.white;
      }
      return null;
    },
  );

  Widget _settingDialogBuilder(BuildContext context, StateSetter stateSetter) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.w),
        child: Card(
          elevation: 7,
          margin: EdgeInsets.only(top: 35.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          child: Container(
            height: 250.h,
            width: 220.w,
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 14.sp),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notification"),
                        Switch(
                          // This bool value toggles the switch.
                          value: notificationSwitchValue,
                          overlayColor: overlayColor,
                          trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(
                              Colors.white),
                          onChanged: (bool value) {
                            print("switch value: ${value}");
                            stateSetter(() {
                              notificationSwitchValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("RoundRobin"),
                        Switch(
                          // This bool value toggles the switch.
                          value: rrSwitchValue,
                          /*activeColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,*/
                          overlayColor: overlayColor,
                          trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(
                              Colors.white),
                          onChanged: (bool value) {
                            print("switch value: ${value}");
                            LocalSharePreferences.localSharePreferences.setBool("isRoundRobin", value);
                            stateSetter(() {
                              rrSwitchValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return Dialog(
                                alignment: Alignment.centerRight,
                                backgroundColor: Colors.transparent,
                                insetAnimationDuration:
                                    Duration(milliseconds: 200),
                                insetAnimationCurve: Curves.easeOutExpo,
                                child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return EditCompany(setState);
                                }),
                              );
                            },
                          );
                          // editProfileDilaog(organization!);
                        },
                        child: Text("Update Company Profile")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  EditCompany(StateSetter stateSetter) {
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
                "Edit Company Details",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
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
                'Company Name', 'Please Comapny name', _companyNameController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Email', 'Please enter your email ID', _emailController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Phone', 'Please enter your phone number', _mobileController),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                submitEditForm();
                Navigator.of(context).pop();
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
      ),
    );
  }

  void submitEditForm() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils =
        await LocalSharePreferences.localSharePreferences.getLoginData();

    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    Map<String, dynamic> parameter = {
      "city": organization!.city,
      "companyAddress": organization!.companyAddress,
      "companyLogo": imgPath,
      "companyMobileNumber": _mobileController.text,
      "companyName": _companyNameController.text,
      "gstNumber": organization!.gstNumber,
      "gstNumber2": organization!.gstNumber2,
      "id": 1,
      "isVerified": organization!.isVerified,
      "landlineNumber": organization!.landlineNumber,
      "numberOfRatings": organization!.numberOfRatings,
      "officialEmailId": _emailController.text,
      "otp": "string",
      "panCardNumber": organization!.panCardNumber,
      "pointOfContact": organization!.pointOfContact,
      "rating": organization!.rating,
      "state": organization!.state,
      "tanCardNumber": organization!.tanCardNumber,
      "typeOfRegistration": organization!.typeOfRegistration,
      "website": organization!.website
    };
    var para = jsonEncode(parameter);
    String myUrl = AppConstants.BASE_URL + 'CompanyDetails';
    print(myUrl);
    var response = await dio.put(
      myUrl,
      data: para,
    );
    print('the body ${response.data}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      showCustomToast(context, "Profile updated", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }

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
        //  uploadedDocument = isImg ? null : fileName;
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

  Widget _notificationDialogBuilder(
      BuildContext context, StateSetter stateSetter) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Card(
        elevation: 7,
        margin: EdgeInsets.only(top: 35.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Container(
          height: 900.h,
          width: 300.w,
          padding: EdgeInsets.symmetric(
            horizontal: 0.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14.sp),
                    ),
                    Text(
                      "Mark all as read",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          dense: true,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          leading: getImage("", height: 50.h, width: 50.h),
                          title: Text(
                            "Parag Sir",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 14.sp),
                          ),
                          subtitle: Text(
                            "Commented in Teams",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 14.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 70, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == 1
                                  ? SizedBox.shrink()
                                  : Container(
                                      height: 135.h,
                                      width: 200.w,
                                      color: Colors.grey,
                                    ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 57.h,
                                    width: 2.w,
                                    color: ThemeColor.red,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "dsnkdsj sdc dsfjodfjeo fdjf eofjewof skjdskjf dsk vcjdsjvcdsli dscj dsvcldsefj efoejf ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.black,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "11 min ago",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ));
                  },
                ),
              ),
              /*Divider(),
              Center(
                child: Text("See More",
                  style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
              ),
*/
            ],
          ),
        ),
      ),
    );
  }
}
