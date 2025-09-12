import 'dart:convert';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/jwt_login_data.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/widget/app_bar.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/app_colors.dart';
import '../../constant/images.dart';
import '../../utils/colors.dart';
import '../../utils/validation.dart';
import '../widget/button.dart';
import '../widget/editText_email.dart';
import '../widget/employee_dialog.dart';
import '../widget/textviewone.dart';
import '../widget/toast.dart';

class Onboarding {
  String? img, title, description;

  Onboarding(this.img, this.title, this.description);
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final PageController _pageController = PageController();

  List<Onboarding> imageList = [
    Onboarding("assets/images/img1.svg", 'Welcome Back!',
        'Welcome back to the best. We are\nalways here, waiting for you!'),
    Onboarding("assets/images/img3.svg", 'Safe Eligible Logistics Solutions',
        'Road transportation has a crucial role.\nCoordinated transportation in the countries\nof origin destination makes all the difference.'),
    Onboarding("assets/images/img2.svg", 'Efficient Cargo Delivery Services',
        'We operate all India, connecting major cities and remote\nlocations alike. No matter where your cargo needs to go,\nwe have the infrastructure to deliver it efficiently.')
  ];
  int _current = 0;
  bool isSignIn = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  _buildPage(context) {
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: ThemeColor.theme_blue,
            borderRadius: BorderRadius.circular(20.r)),
        margin: EdgeInsets.all(27),
        child: AppResponsive.isMobile(context)?getRightWidget():Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: getTopWidget(),
            ),
            Positioned(
              bottom: 200.h,
              left: 79.w,
              child: getImageSilder(),
            ),
            Positioned(
              bottom: 73.h,
              right: 79.w,
              child: getRightWidget(),
            ),
            Positioned(bottom: -25.h, left: -100.w, child: getBottomWidget()),
          ],
        ),
      ),
    );
  }

  socialLogin() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.fb_logo,
            height: 32.h,
            width: 32.w,
          ),
          SizedBox(
            width: 28.w,
          ),
          SvgPicture.asset(
            Images.gmail_logo,
            height: 32.h,
            width: 32.w,
          ),
          SizedBox(
            width: 28.w,
          ),
          SvgPicture.asset(
            Images.fb_logo,
            height: 32.h,
            width: 32.w,
          ),
        ],
      ),
    );
  }

  getLoginWidget() {
    return Container(
      width: 463.w,
      height: 708.h,
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Textview(
              TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              title: "Sign In"),
          SizedBox(
            height: 28.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Email"),
              EditTextEmail(
                width: AppResponsive.isMobile(context)?327:327.w,
                height: 52.h,
                keybordType: TextInputType.emailAddress,
                hint: "Please enter your email ID",
                prefixIcon: Icons.mail_outline,
                controller: _emailController,
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Password"),
              EditTextEmail(
                width: AppResponsive.isMobile(context)?327:327.w,
                height: 52.h,
                isPassword: true,
                keybordType: TextInputType.visiblePassword,
                hint: "Please enter your password",
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_outlined,
                controller: _passwordController,
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Button(
                width: MediaQuery.of(context).size.width,
                height: 52.h,
                title: "Sign In",
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                onClick: () async {
                   _submitForm();
                }),
          ),
          Tooltip(
            richMessage: TextSpan(
              text: 'For forgot password, Please contact to ',
              style: TextStyle(color: Colors.white),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Admin (+91) 8123006888 r/ (+91) 8123004666 ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            child: Textview(
                TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
                title: "Forgot Password?"),
          ),
        ],
      ),
    );
  }

  getSignUpWidget() {
    return Container(
      width: 463.w,
      height: 708.h,
      padding: EdgeInsets.symmetric(horizontal: 60.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Textview(
              TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
              title: "Sign In"),
          SizedBox(
            height: 28.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Full Name"),
              EditTextEmail(
                width: 327.w,
                height: 52.h,
                hint: "Please enter your full name",
                prefixIcon: Icons.account_circle_outlined,
                controller: TextEditingController(),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Email"),
              EditTextEmail(
                width: 327.w,
                height: 52.h,
                keybordType: TextInputType.emailAddress,
                hint: "Please enter your email ID",
                prefixIcon: Icons.mail_outline,
                controller: TextEditingController(),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Password"),
              EditTextEmail(
                width: 327.w,
                height: 52.h,
                isPassword: true,
                keybordType: TextInputType.visiblePassword,
                hint: "Please enter your password",
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_outlined,
                controller: TextEditingController(),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Button(
                width: MediaQuery.of(context).size.width,
                height: 75.h,
                title: "Sign Up",
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                onClick: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }),
          ),
          Row(
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Already have an Account? "),
              InkWell(
                onTap: () {
                  setState(() {
                    isSignIn = true;
                  });
                },
                child: Textview(
                    TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: ThemeColor.theme_blue),
                    title: "Sign In"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getImageSilder() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      "${imageList[index].img}",
                      width: 540.73.w,
                      height: 379.h,
                    ),
                    SizedBox(height: 16.h),
                    Textview(
                        TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        title: imageList[index].title ?? ""),
                    Textview(
                        TextStyle(
                          color: Color(0xffCBCBCB),
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                        title: imageList[index].description ?? ""),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          SmoothPageIndicator(
            controller: _pageController,
            count: imageList.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.white,
              dotColor: Colors.white24,
              dotHeight: 12,
              dotWidth: 12,
              spacing: 8,
              expansionFactor: 4,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }

  getBottomWidget() {
    return SizedBox(
      width: 585.w,
      height: 135.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/bottomContainer.svg",
            width: 700.w,
            height: 135.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 100.0.w),
                child: SvgPicture.asset(
                  "assets/images/logo_black.svg",
                  width: 70.w,
                  height: 50.h,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textview(
                      TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                      title: 'TKD Digitrans Solution'),
                  Textview(
                      TextStyle(
                        color: Colors.black54,
                        fontSize: 11.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                      ),
                      title: 'Connecting logistics, Empowering growth'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  getTopWidget() {
    return Container(
      height: 110,
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10,
      ),
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Images.logo,
                  height: 66.h,
                  width: 114.w,
                ),
                Textview(
                    TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    title: 'TKD Connect'),
              ],
            ),
          ]),
    );
  }

  getRightWidget() {
    return isSignIn ? getLoginWidget() : getSignUpWidget();
  }


  void _submitForm() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (Validation().isValidEmail(email) && password.isNotEmpty) {
      String myUrl = ApiConstant.BASE_URL +
          "api/Login/emailId/jwt?emailId=${email}&password=${password}";
      debugPrint("Login Url:" + myUrl);
      EasyLoading.show(status: "Loading");
      Dio dio = Dio();
      try {
        final req = await http.post(Uri.parse(myUrl));
        print('the body is ${req.body}');
        if (req.statusCode == 200) {
          var jwtResponse = json.decode(req.body);
          print('the response is ${jwtResponse}');
          JWTLoginData jwtLoginData =
          JWTLoginData.fromJson(jwtResponse);
          if (jwtLoginData.data == '') {
            showCustomToast(
                context, jwtLoginData.message!, Icons.clear, Colors.red);
            EasyLoading.dismiss();
          } else {
            String token = jwtLoginData.data!;
            LocalSharePreferences()
                .setString(SharedPreferencesConstant.AuthToken, token);
            String finalToken = await LocalSharePreferences()
                .getString(SharedPreferencesConstant.AuthToken);
            print("Final Token ::" + finalToken);
          }

          String loginUrl = ApiConstant.BASE_URL + "api/getCurrentLoggedInJwt";
          debugPrint("Get Current User Url:" + loginUrl);

          String token = await LocalSharePreferences()
              .getString(SharedPreferencesConstant.AuthToken);
          print("Token : "+token);
          final loginResponse = await http.get(Uri.parse(loginUrl),headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
          });
           /* await dio.get(loginUrl,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer ${token}',
                }));*/
            print(loginResponse.statusCode);
          EasyLoading.dismiss();
          if (loginResponse.statusCode == 200) {
            LoginDeatils loginDeatils = LoginDeatils.fromJson(
                jsonDecode(loginResponse.body));
            print(loginResponse.body);
            EasyLoading.dismiss();
            if (loginDeatils.data != null) {
              String response = jsonEncode(loginDeatils);
              LocalSharePreferences()
                  .setString(SharedPreferencesConstant.LoginKey, response);
              LocalSharePreferences()
                  .setBool(SharedPreferencesConstant.LoginKeyBool, true);

              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else {
              EasyLoading.dismiss();
              //ToastMessage.show(context, loginDeatils.message!);
              showCustomToast(
                  context, loginDeatils.message!, Icons.clear, Colors.red);
            }
          } else {
            EasyLoading.dismiss();
            //  ToastMessage.show(context, "Try Again");
          /*  showCustomToast(
                context, "Something went wrong! Please Try Again(${loginResponse.statusCode})", Icons.clear,
                Colors.red);*/
            showCustomToast(
                context, "Something went wrong! Please Try Again", Icons.clear,
                Colors.red);
          }

        } else {
          // ToastMessage.show(context, "Try Again");
          EasyLoading.dismiss();
          showCustomToast(
              context, "Something went wrong! Please Try Again", Icons.clear,
              Colors.red);
        }
      } on Exception catch (_) {
        EasyLoading.dismiss();
        showCustomToast(
            context, "Something went wrong! Please Try Again and check your internet connection...", Icons.clear,
            Colors.red);
        throw Exception();
      }
    } else {
     // ToastMessage.show(context, "Please fill correct email and password");
      showCustomToast(context, "Please fill correct email and password", Icons.clear, Colors.red);
    }
  }
}
