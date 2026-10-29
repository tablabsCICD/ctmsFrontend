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
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/editText_email.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/constant/constant.dart';
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
  GlobalKey<ScaffoldState>? scaffoldKey;

  HeaderWidget(
      {Key? key,
      this.onSearchTap,
      required this.isSearchVisible,
      this.scaffoldKey})
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
  TextEditingController _companyIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _panController = TextEditingController();
  TextEditingController _tanController = TextEditingController();
  TextEditingController _gstNoController = TextEditingController();
  List<TextEditingController> _rulesListController = [TextEditingController()];
  List<TextEditingController> _instructionListController = [
    TextEditingController()
  ];
  List<String> _rulesForTaxInvoiceList = [];
  List<String> instructionList = [];

  final orgProvider = locator<OrgProvider>();
  CtmsOrganization? organization;

  Future<void> getCompanyDetail() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String myUrl = ApiConstant.BASE_URL +
        "api/Organisation/getById?Id=${loogedInUser!.data!.organisationId}";
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
      organization = ctmsOrganizationResponse.data!;
      print('this is ${organization}');
    }
    setupData();
    setState(() {});
  }

  setupData() {
    imgPath = organization!.logo!;
    _companyNameController.text = organization!.orgName ?? '';
    _companyIdController.text = organization!.id!.toString();
    _emailController.text = organization!.officialEmailId ?? '';
    _mobileController.text = organization!.orgMobileNumber ?? '';
    _addressController.text = organization!.orgAddress ?? '';
    _panController.text = organization!.panCardNumber ?? '';
    _tanController.text = organization!.tanCardNumber ?? "";
    _gstNoController.text = organization!.gstNumber ?? "";
    _rulesForTaxInvoiceList = organization!.rulesForTaxinvoice ?? [];
    instructionList = organization!.instruction ?? [];
    invoiceLogo = organization!.invoiceLogo ?? '';
    unLoadingLogo = organization!.unloadingLogo ?? '';
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
                    onPressed: () {
                      widget.scaffoldKey!.currentState!.openDrawer();
                    },
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
                          widget.isSearchVisible==false?null:Navigator.restorablePushReplacementNamed(
                              context, AppRoutes.profile);
                        },
                        child: Text('${Constants.LOGIN_NAME}',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
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
                            loogedInUser!.data!.image == null
                                ? ''
                                : loogedInUser!.data!.image!,
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
                      loogedInUser!.data!.isAdmin==false?SizedBox.shrink(): Container(
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
                            /* PopupMenuItem(
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
                            )),*/
                            isAdmin
                                ? PopupMenuItem(
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
                                            insetAnimationCurve:
                                                Curves.easeOutExpo,
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
                                : PopupMenuItem(child: SizedBox.shrink())
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
                fontSize: 14.sp,
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

  LoginDeatils? loogedInUser;
  bool isLoading = false;
  late bool isAdmin;

  void getLoginDetails() async {
    isLoading = true;
    setState(() {});
    loogedInUser = await LocalSharePreferences().getLoginData();
    Constants.LOGIN_NAME =
        loogedInUser!.data!.firstName! + " " + loogedInUser!.data!.lastName!;
    isLoading = false;
    isAdmin = loogedInUser!.data!.isAdmin!;
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
                      pickFile(stateSetter, true, false, false);
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
                'Company Id', 'Please Comapny Id', _companyIdController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Company Name', 'Please Company name', _companyNameController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Email', 'Please enter your email ID', _emailController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Phone', 'Please enter your phone number', _mobileController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Address', 'Please enter address', _addressController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Pan Card Number', 'Please enter pan number', _panController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Tan Card Number', 'Please enter tan number', _tanController),
            SizedBox(height: 16.h),
            _buildTextField(
                'GST Number', 'Please enter gst number', _gstNoController),
            SizedBox(height: 16.h),
            _rulesForTaxInvoiceList.isNotEmpty
                ? _buildDisplayList("Rules Fore TaxInvoice", "",
                    _rulesForTaxInvoiceList, stateSetter, true)
                : _buildList(
                    "Rules Fore TaxInvoice", "enter rules", stateSetter, true),
            SizedBox(height: 16.h),
            instructionList.isNotEmpty
                ? _buildDisplayList(
                    "Instructions", "", instructionList, stateSetter, false)
                : _buildList(
                    "Instructions", "enter instructions", stateSetter, false),
            SizedBox(height: 16.h),
            _buildText(true,
                '${invoiceLogo == '' ? "Click here to upload logo" : invoiceLogo}',
                'Invoice Logo', () async {
              pickFile(stateSetter, false, true, false);
            }),
            SizedBox(height: 16.h),
            _buildText(false,
                '${unLoadingLogo == '' ? "Click here to upload logo" : unLoadingLogo}',
                'UnLoading Logo', () async {
              pickFile(stateSetter, false, false, true);
            }),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                _rulesListController.forEach((element) {
                  _rulesForTaxInvoiceList.add(element.text);
                });
                _instructionListController.forEach((element) {
                  instructionList.add(element.text);
                });
                if(_mobileController.text==''){
                  showCustomToast(context, "Please enter mobile Number", Icons.clear, Colors.red);
                }else if(_companyNameController.text==''){
                  showCustomToast(context, "Please enter Company Name", Icons.clear, Colors.red);
                }else if(_emailController.text==''){
                  showCustomToast(context, "Please enter Email Id", Icons.clear, Colors.red);
                }else{
                submitEditForm();
                Navigator.of(context).pop();}
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

  Widget _buildText(bool isInvoiceLogo,String label, String label1, Function onClick) {
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
          isInvoiceLogo
              ? Center(
                  child: invoiceLogo == ''
                      ? SvgPicture.asset('assets/upload_profile.svg',
                          height: 150.h, width: 150.w)
                      : Container(
                          height: 150.h,
                          width: 200.w,
                          alignment: Alignment.center,
                          child: Image.network(
                            invoiceLogo,
                            width: 150.w,
                          )))
              : Center(
                  child: unLoadingLogo == ''
                      ? SvgPicture.asset('assets/upload_profile.svg',
                          height: 150.h, width: 150.w)
                      : Container(
                          height: 150.h,
                          width: 200.w,
                          alignment: Alignment.center,
                          child: Image.network(
                            unLoadingLogo,
                            width: 150.w,
                          ))),
          /*Container(
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
          ),*/
        ],
      ),
    );
  }

  void submitEditForm() async {
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    Map<String, dynamic> parameter = {
      "active": true,
      "city": organization!.city,
      "description": organization!.description,
      "emailId": _emailController.text,
      "gstNumber": _gstNoController.text,
      "gstNumber2": organization!.gstNumber2,
      "id": organization!.id,
      "instruction": instructionList,
      "invoiceLogo": invoiceLogo,
      "isVerified": organization!.isVerified,
      "landLineNumber": organization!.landLineNumber,
      "logo": imgPath,
      "officialEmailId": organization!.emailId,
      "orgAddress": _addressController.text,
      "orgMobileNumber": _mobileController.text,
      "orgName": _companyNameController.text,
      "panCardNumber": _panController.text,
      "rulesForTaxinvoice": _rulesForTaxInvoiceList,
      "state": organization!.state,
      "tanCardNumber": _tanController.text,
      "typeOfRegistration": organization!.typeOfRegistration,
      "unloadingLogo": unLoadingLogo,
      "website": organization!.website,
      "connectUserId" : organization!.connectUserId,
      "connectOrgId" : organization!.connectOrgId
    };
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    var para = jsonEncode(parameter);
    String myUrl = ApiConstant.BASE_URL + 'api/Organisation/update?Id=${organization!.id}';
    print(myUrl);
    var response = await dio.put(myUrl,
        data: para,
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print('the body ${response.data}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      setState(() {});
      showCustomToast(context, "Profile updated", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
  }

  String imgPath = '';
  String invoiceLogo = '';
  String unLoadingLogo = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;

  pickFile(StateSetter stateSetter, bool isImg, bool isInvoice,
      bool isUnloading) async {
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
        if (await result.files.first
            .toString()
            .length >= 500) {
          showCustomToast(
              context, "Image Size should be less than 500 KB", Icons.close, Colors.red);
        } else {
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
          }

          if (isUnloading) {
            unLoadingLogo = imgUploadResponse.data!;
          }
          if (isInvoice) {
            invoiceLogo = imgUploadResponse.data!;
          }
          print("Uploaded Img Path From s3 bucket::" +
              imgPath +
              "\ninvoiceLogo:" +
              invoiceLogo +
              "\nunLoadingLogo:" +
              unLoadingLogo);
          stateSetter(() {});
        });
        print('the response is ${response}');

        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          // ToastMessage.show(context, "Image uploaded");
          showCustomToast(context, "Image Uploaded", Icons.check, Colors.green);
        }
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
              readOnly: label=="Company Id"?true:false,
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

  Widget _buildDisplayList(String label, String hint, List<String> list,
      StateSetter stateSetter, bool isRule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Color(0xff1B1B1B),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 25.h,
                width: 25.w,
                child: InkWell(
                    onTap: () {
                      stateSetter(() {
                        isRule
                            ? _rulesForTaxInvoiceList.clear()
                            : instructionList.clear();
                        isRule
                            ? _rulesListController.clear()
                            : _instructionListController.clear();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: Colors.red),
                          color: Colors.red),
                      alignment: Alignment.center,
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_right,
                    color: Colors.orange,
                    size: 12,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(list[index],
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black)),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildList(
      String label, String hint, StateSetter stateSetter, bool isRule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 7.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Color(0xff1B1B1B),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 25.h,
                width: 25.w,
                child: InkWell(
                    onTap: () {
                      stateSetter(() {
                        isRule
                            ? _rulesListController.add(TextEditingController())
                            : _instructionListController
                                .add(TextEditingController());
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: Colors.green),
                          color: Colors.green),
                      alignment: Alignment.center,
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: isRule
                ? _rulesListController.length
                : _instructionListController.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 52.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          child: TextField(
                            controller: isRule
                                ? _rulesListController[index]
                                : _instructionListController[index],
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
                    ),
                    index != 0
                        ? InkWell(
                            onTap: () {
                              isRule
                                  ? stateSetter(() {
                                      _rulesListController[index].clear();
                                      _rulesListController[index].dispose();
                                      _rulesListController.removeAt(index);
                                    })
                                  : stateSetter(() {
                                      _instructionListController[index].clear();
                                      _instructionListController[index]
                                          .dispose();
                                      _instructionListController
                                          .removeAt(index);
                                    });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                        : SizedBox.shrink()
                  ],
                ),
              );
            })
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
