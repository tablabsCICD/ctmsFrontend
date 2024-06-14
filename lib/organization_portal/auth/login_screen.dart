import 'dart:async';
import 'dart:convert';

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/open_url.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu_page.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_screen.dart';
import 'package:universal_html/html.dart' as html;

class ImageCarousel{
  String image1;
  String image2;
  String title;
  String subTitle;

  ImageCarousel(this.image1, this.image2, this.title, this.subTitle);
}

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}


class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController mobileController = new TextEditingController();
  bool visitingFlag = true;
  List<ConnectUser> userDetailList = [];
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();
  bool companyLogin=false,userLogin=true;
  List<Organization> orgList = [];
  final _formKey = GlobalKey<FormState>();

  var _current = 0;

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();/*
    loginOrHome();
    companyLoginOrHome();
*/
  }



  companyLoginOrHome() async{
    visitingFlag = (await orgProvider.getCompanyVisitingFlag())!;
    print("visiting flag "+ visitingFlag.toString());
    if(visitingFlag == true){
      int? orgId = await orgProvider.getCompanyOrgId();
      print("visiting flag Id "+ orgId.toString());
      if(orgId != null){
        orgList  = await orgProvider.getCompanyDetails(orgId);

        Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompanyMenuPage(orgList[0])));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      body: Consumer<AuthProvider>(
        builder: (context, model, child) =>
            Container(
              color: ThemeColor.baground,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Side Navigation Menu
                  /// Only show in desktop
                  if (AppResponsive.isDesktop(context))
                    Expanded(
                      flex: 1,
                      child: SideBar(),
                    ),

                  /// Main Body Part
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: getCart(model),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  getCart(AuthProvider model) {
    final orgProvider = locator<OrgProvider>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          height: 400,
          width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:
          ResponsiveWidget.isDesktop(context)?355:MediaQuery.of(context).size.width / 3,
          margin: ResponsiveWidget.isMobile(context)?EdgeInsets.all(0):ResponsiveWidget.isDesktop(context)?EdgeInsets.only(right: MediaQuery.of(context).size.width / 5):EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
          decoration: BoxDecoration(
            color: ColorResources.HOME_BG,
            border: Border.all(width: 1,color: Color(0xffe8e1d8)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sign In",
                    style: Style.loginHeading,textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomTextField(
                    hintText: 'Enter Mobile Number',
                    controller: mobileController,
                    textInputType: TextInputType.number,
                    isPhoneNumber: true,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child:
                  CustomButton(
                      onTap:() async {
                        var result = await  orgProvider.sendOtpByOrgId(mobileController.text);
                        if(result["Status"]=='Success'){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) => OTP_Screen(mobileController.text,companyLogin: true)));
                        }
                        else{
                          print(result['errorMessage']);
                          showSimpleNotification(
                              Text(result['errorMessage'],style: TextStyle(color: Colors.white),),
                              background: Colors.black
                          );
                        }
                      },
                      buttonText: 'SEND OTP'),
                ),
                //  SizedBox(height: 50,),



              ],
            ),
          ),
        ),
      ),
    );
  }







}
