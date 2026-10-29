import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/img_upload_response.dart';
import 'package:flutter_hr_management/organization_portal/provider/Create_Org_Provider.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditOrgScreen extends StatefulWidget {
  CtmsOrganization ctmsOrganization;
  final createProvider = locator<CreateOrgProvider>();

  EditOrgScreen(this.ctmsOrganization,{Key? key}) : super(key: key) {
    createProvider.setData(ctmsOrganization);
  }

  @override
  State<EditOrgScreen> createState() => _EditOrgScreenState();
}

class _EditOrgScreenState extends State<EditOrgScreen> {
  final createOrgProvider = locator<CreateOrgProvider>();

  /*TextEditingController ctmsOrgNameController=TextEditingController();
  TextEditingController ctmsOrgEmailIdController=TextEditingController();
  TextEditingController ctmsMobileController=TextEditingController();
  TextEditingController ctmsDescriptionController=TextEditingController();
  TextEditingController ctmsOrgAddressController=TextEditingController();
  TextEditingController ctmsPanController=TextEditingController();
  TextEditingController ctmsTanController=TextEditingController();
  TextEditingController ctmsGst1Controller=TextEditingController();
  TextEditingController ctmsGst2Controller=TextEditingController();
  TextEditingController ctmsLogoController=TextEditingController();
  TextEditingController ctmsTypeOfRegController=TextEditingController();
  TextEditingController ctmsWebsiteController=TextEditingController();
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setData(widget.ctmsOrganization);
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Organization? organization;
  setData(CtmsOrganization ctmsOrganization) async {
    organization = await createOrgProvider.getConnectOrganization(ctmsOrganization.connectOrgId!);
    imgPath = ctmsOrganization.logo.toString();
    unLoadingLogo = ctmsOrganization.unloadingLogo.toString();
    invoiceLogo = ctmsOrganization.invoiceLogo.toString();
    setState(() {
    });
  }

  _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<CreateOrgProvider>(
        builder: (context, provider, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Container(
              width: 500.w,
              decoration: BoxDecoration(
                  color: AppColor.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: InkWell(
                            onTap: () async {
                              pickFile(true, false, false,provider);
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
                        'Company Name', 'Please Company name',provider.ctmsOrgNameController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'Email', 'Please enter your email ID',provider.ctmsOrgEmailIdController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'Phone', 'Please enter your phone number',provider.ctmsMobileController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'Address', 'Please enter address', provider.ctmsOrgAddressController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'Pan Card Number', 'Please enter pan number', provider.ctmsPanController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'Tan Card Number', 'Please enter tan number',provider.ctmsTanController,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'GST Number1', 'Please enter gst number', provider.ctmsGst1Controller,provider),
                    SizedBox(height: 16.h),
                    _buildTextField(
                        'GST Number2', 'Please enter gst number', provider.ctmsGst2Controller,provider),
                    SizedBox(height: 16.h),

                    _buildText(true,
                        '${invoiceLogo == '' ? "Click here to upload logo" : invoiceLogo}',
                        'Invoice Logo', () async {
                          pickFile(false, true, false,provider);
                        }),
                    SizedBox(height: 16.h),
                    _buildText(false,
                        '${unLoadingLogo == '' ? "Click here to upload logo" : unLoadingLogo}',
                        'UnLoading Logo', () async {
                          pickFile(false, false, true,provider);
                        }),
                    SizedBox(height: 16.h),
                    InkWell(
                      onTap: () async {
                        final bool mobileValid =
                        RegExp(r'^\+?\d{1,3}[\s-]?\(?\d{1,4}\)?[\s-]?\d{6,10}$')
                            .hasMatch(provider.ctmsMobileController.text);
                        if(provider.ctmsOrgNameController.text==''){
                          showCustomToast(context, "Enter Name", Icons.close, Colors.red);
                        }else  if(provider.ctmsMobileController.text==""){
                          showCustomToast(context, "Enter mobile number", Icons.close, Colors.red);
                           }else if(mobileValid==false){
                                    showCustomToast(context, "Enter valid mobile number", Icons.close, Colors.red);
                        }else
                        if(provider.ctmsOrgEmailIdController.text==""){
                          showCustomToast(context, "Enter valid email id", Icons.close, Colors.red);
                        }else {
                        var res = await provider.editCtmsOrganization(context,widget.ctmsOrganization);
                        if(res.statusCode == 200){
                          provider.getOrganizationList();
                          showCustomToast(context, "Tkd Organization edited successfully..", Icons.check, Colors.green);
                          var res = await provider.editTkdOrganization(context,organization!);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          } else {
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
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
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
            ),
          );
        },
      ),
      /*  bottomNavigationBar: Consumer<CreateOrgProvider>(
        builder: (context, provider, child) {
          return Button(
              isEnbale: provider.buttonActive,
              width: 335.h,
              height: 48.h,
              title: "Create Organization",
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: AppConstants.FONTFAMILY,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
              onClick: () {
                provider.submitOrgDetails(context);

              });
        },
      ),*/
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

  String imgPath = '';

  String invoiceLogo = '';

  String unLoadingLogo = '';

  String documentPath = '';

  PlatformFile? objFile;

  Uint8List? imageBytes;

  String? fileName;

  pickFile( bool isImg, bool isInvoice,
      bool isUnloading,CreateOrgProvider provider) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
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
              provider.ctmsLogoController.text = imgPath;
            }
            if (isUnloading) {
              unLoadingLogo = imgUploadResponse.data!;
              provider.ctmsUnloadingLogoController.text = unLoadingLogo;
            }
            if (isInvoice) {
              invoiceLogo = imgUploadResponse.data!;
              provider.ctmsInvoiceLogoController.text = invoiceLogo;
            }
            print("Uploaded Img Path From s3 bucket::" +
                imgPath +
                "\ninvoiceLogo:" +
                invoiceLogo +
                "\nunLoadingLogo:" +
                unLoadingLogo);
            setState(() {});
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
      String label, String hint, TextEditingController controller,CreateOrgProvider provider) {
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
              controller: controller,//TextEditingController(text: controller),
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
              onChanged: (val) {
                provider.buttonEnble();
              },
            ),
          ),
        ),
      ],
    );
  }


}
