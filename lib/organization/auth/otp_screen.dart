import 'dart:async';

import 'dart:ui';
//import 'dart:html' as html;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization/auth/login_screen.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/open_url.dart';
import 'package:flutter_hr_management/organization/company/company_menu_page.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/provider/route_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization/base_widget/open_url.dart';


class OTP_Screen extends StatefulWidget {
  String mobileNumber;
  bool companyLogin;
  OTP_Screen(this.mobileNumber,{ required this.companyLogin});
  final authProvider = locator<AuthProvider>();
  @override
  OTP_ScreenState createState() => OTP_ScreenState();
}

class OTP_ScreenState extends State<OTP_Screen> {
  TextEditingController otpController = new TextEditingController();
  var onTapRecognizer;
  final orgProvider = locator<OrgProvider>();
  final authProvider = locator<AuthProvider>();
  String? _deviceId;

  Future<void> initPlatformState() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    if (!mounted) return;
    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }

  TextEditingController textEditingController = TextEditingController();
  String otp = "";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var _current = 0;
  List<ImageCarousel> carouselImages = [
    ImageCarousel('assets/images/man_01.png','assets/images/truck_01.png',"Grow your business","Multiply you business by getting vehicles at\n the right price at the right time.Also, do'nt loose any\n business which is not in your regular route of operations."),
    ImageCarousel('assets/images/man_01.png','assets/images/truck_01.png',"Grow your own business","Multiply you business by getting vehicles at\n the right price at the right time.Also, do'nt loose any\n business which is not in your regular route of operations."),
    ImageCarousel('assets/images/man_01.png','assets/images/truck_01.png',"Grow your tkd business","Multiply you business by getting vehicles at\n the right price at the right time.Also, do'nt loose any\n business which is not in your regular route of operations."), ];


  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
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
                      child: SideBar(),
                    ),

                  /// Main Body Part
                  Expanded(
                    flex: 4,
                    child: Container(
                      //width: MediaQuery.of(context).size.width-1000,
                      alignment: Alignment.center,
                      child: getCard(model),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
  getCard(AuthProvider model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 32,
                width: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorResources.TEXTFEILD_COLOR,
                    shape: BoxShape.circle
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_outlined)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("Enter OTP",
                      style: Style.loginHeading
                  ),
                ),
                /*Text("03 out of 03 attempts left",
                    style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    )
                ),*/
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        // animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 6 || v.isEmpty) {
                            return "*Please fill up all the cells properly";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: ResponsiveWidget.isMobile(context)?40:40,
                          fieldWidth: ResponsiveWidget.isMobile(context)?35:40,
                          //activeFillColor:
                        //  hasError ? Colors.white : Colors.white,
                        ),
                        cursorColor: Colors.black,
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                          )
                        ],
                        onCompleted: (v) {
                          setState(() {
                            currentText = v;
                          });
                        },

                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      )),
                ),
               /* CustomTextField(
                  hintText: "Enter Otp",
                  controller: otpController,
                  textInputType: TextInputType.number,

                ),*/
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Resend OTP",
                        style: TextStyle(
                          fontFamily: 'RobotoSlab',
                          color: Color(0xffea6935),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.underline,
                        )
                    ),
                    Text("00:39",
                        style: TextStyle(
                          fontFamily: 'RobotoSlab',
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        )
                    ),
                  ],
                ),*/
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  child: Consumer<OrgProvider>(
                    builder: (context, model, child) => CustomButton(
                        onTap:() async {
                          print(currentText);
                          Organization result =  await orgProvider.verifyOtpByOrgId(widget.mobileNumber, currentText, _deviceId!);
                          print("result : "+result.id.toString());
                          if(result != null)
                          {
                            model.setCompanyVisitingFlag(true);
                           /* print(result);
                            print(result[0].id);*/
                            model.setCompanyOrgId(3/*result.id!*/);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>CompanyMenuPage(result)));
                          }else
                            print(result);
                        },
                        buttonText: 'LOGIN'),
                  )


                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  int index = -1;
  getDetails(){
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 500.0,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: carouselImages.map((i){
              index++;
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                        height: MediaQuery.of(context).size.height*0.30,
                        width: MediaQuery.of(context).size.width,
                        child: index < 3?Stack(
                            children: [
                              Container(
                                  height: 500,
                                  width: MediaQuery.of(context).size.width / 4,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20.0),
                                    child: Image.asset(
                                      carouselImages[index].image2,
                                      height: 72,
                                      width: 222,
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      carouselImages[index].image1,
                                      height: 234,
                                      width: 120,
                                    ),
                                    Text(carouselImages[index].title,
                                        style: Style.splashheading),
                                    new Text(
                                      carouselImages[index].subTitle,
                                      style: Style.splashContent,textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ]):getWidget()
                    );
                  }
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselImages.map((i) {
                int index = carouselImages.indexOf(i);
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? ColorResources.PRIMARY_COLOR
                        : ColorResources.DOT_COLOR,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );

  }

  getWidget() {
    index=0;
    return SizedBox.shrink();
  }


 /* getDetails() {
    return Container(
      height: 500,
      width:  MediaQuery.of(context).size.width/3.5,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
      child: Stack(
        children: [
          Container(
              height: 500,
              width:  MediaQuery.of(context).size.width/4,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset('assets/images/truck_01.png',height: 72,width: 222,),
              )
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/man_01.png',height: 234,width: 120,),
                Text("Grow your business",
                    style: Style.splashheading,textAlign: TextAlign.center,
                ),
                new Text("Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui.",
                    style: Style.splashContent,textAlign: TextAlign.center,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
*/
}

