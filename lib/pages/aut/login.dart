import 'dart:convert';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../common/app_colors.dart';
import '../../constant/images.dart';
import '../../utils/colors.dart';
import '../../utils/validation.dart';
import '../widget/button.dart';
import '../widget/editText_email.dart';
import '../widget/employee_dialog.dart';
import '../widget/textviewone.dart';
import '../widget/toast.dart';

// class Login extends StatefulWidget {
//   @override
//   _LeadListScreen createState() => _LeadListScreen();
// }
//
// class _LeadListScreen extends State<Login> {
//
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildPage(context);
//   }
//
//   _buildPage(context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgSideMenu,
//
//       body: Column(
//
//         children: [
//
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assets/sidebar_image.png"),
//                   alignment: Alignment.bottomLeft,
//                   scale: 4.0
//               ),
//             ),
//             child: Center(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//
//                 children: [
//
//                   Container(
//                     width: MediaQuery.of(context).size.width / 2,
//                     height: null,
//                     decoration: BoxDecoration(
//                         color: AppColor.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     padding: EdgeInsets.all(10),
//                     child:
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColor.black,
//                                 fontSize: 22,
//                               ),
//                             )),
//                         SizedBox(height: 16),
//
//                         _buildTextField('Email', _emailController),
//                         SizedBox(height: 16),
//                         _buildTextField('Password', _passwordController),
//                         SizedBox(height: 32),
//                         InkWell(
//                           onTap: _submitForm,
//                           child: Container(
//                             width: 300,
//                             decoration: BoxDecoration(
//                                 color: AppColor.yellow,
//                                 borderRadius: BorderRadius.circular(100)),
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: 20,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Submit",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColor.black),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//
//       );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Container(
//       width: 300,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: TextField(
//           controller: controller,
//           obscureText: false,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             labelText: label,
//             labelStyle: TextStyle(color: Colors.black),
//           ),
//         ),
//       ),
//     );
//   }
//   void _submitForm() async{
//
//
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => EmpDialog()),);
//
//     // var list=await showDialog(context: context, builder: (BuildContext context) {
//     //   return EmpDialog();
//     //
//     // });
//    // print('the list is ${list}');
//
//     String email = _emailController.text;
//     String password = _passwordController.text;
//     if(email.isNotEmpty && password.isNotEmpty){
//       var formData = FormData.fromMap({
//         'emailId': email,
//         'password': password,
//
//       });
//       EasyLoading.show(status: "Loading");
//       Dio dio=Dio();
//       var response= await dio.post(ApiConstant.LOGIN_DATA+"/emailId",data:formData);
//       EasyLoading.dismiss();
//       if(response.statusCode==200){
//         print('the body is ${response.data}');
//         LoginDeatils loginDeatils=LoginDeatils.fromJson(jsonDecode(response.data));
//
//         if(loginDeatils.data!=null){
//           String response=jsonEncode(loginDeatils);
//           LocalSharePreferences().setString(SharedPreferencesConstant.LoginKey, response);
//           LocalSharePreferences().setBool(SharedPreferencesConstant.LoginKeyBool, true);
//
//           Navigator.pushReplacementNamed(context, AppRoutes.home);
//
//         }else{
//           ToastMessage.show(context, loginDeatils!.message!);
//         }
//       }else{
//         ToastMessage.show(context, "Try Again");
//       }
//     }else{
//
//     }
//   }
//
//
// }

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
  final CarouselController _controller = CarouselController();
  List<Onboarding> imageList = [
    Onboarding("assets/images/img1.svg", 'Welcome Back!',
        'Welcome back to the best. We are\nalways here, waiting for you!'),
    Onboarding("assets/images/img3.svg", 'Safe eliable Logistics Solutions',
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
                 /*String response = jsonEncode({
                    "message": "Current logged in Employee ",
                    "data": {
                      "id": 1,
                      "employeeId": "TKD-1",
                      "firstName": "Swati",
                      "lastName": "Navale",
                      "emailId": "swati@gmail.com",
                      "mobileNumber": "9809876543",
                      "address": "string",
                      "image":
                          "https://tablabs-images.s3.ap-south-1.amazonaws.com/1697696782526-user.png",
                      "designation": "Devloper",
                      "contact": "7507873525",
                      "employeeLocation": "ONSITE",
                      "departmentId": 1,
                      "boardingDeatails": {
                        "boardingId": 1,
                        "tenthDCertificate":
                            "https://tablabs-images.s3.ap-south-1.amazonaws.com/1697696820464-Final_Resume.pdf",
                        "twelthCertificate": "",
                        "degreeCertificate":
                            "https://tablabs-images.s3.ap-south-1.amazonaws.com/1697696824118-Final_Resume.pdf",
                        "aadharCard":
                            "https://tablabs-images.s3.ap-south-1.amazonaws.com/1697696828499-Final_Resume.pdf",
                        "panCard":
                            "https://tablabs-images.s3.ap-south-1.amazonaws.com/1697696832104-Tabrez_Khaisar_Resume_BE.pdf",
                        "experienceCertificate": null,
                        "active": "true",
                        "otherDocuments": ["string"]
                      },
                      "active": "true",
                      "role": {"id": 1, "name": "Developer", "isActive": 1},
                      "is_admin": null,
                      "isActive": null,
                      "otp": "string",
                      "password": "Tkd@123",
                      "os": "Web",
                      "status": "Selected",
                      "deviceId": "string",
                      "createdDate": "string",
                      "securityQuestion": null,
                      "securityAnswer": null
                    },
                    "success": true
                  });
                  LocalSharePreferences()
                      .setString(SharedPreferencesConstant.LoginKey, response);
                  LocalSharePreferences()
                      .setBool(SharedPreferencesConstant.LoginKeyBool, true);
                  Navigator.pushReplacementNamed(context, AppRoutes.home);*/
                  _submitForm();
                }),
          ),
          Tooltip(
            richMessage: TextSpan(
              text: 'For forgot password, Please contact to ',
              style: TextStyle(color: Colors.white),
              children: <InlineSpan>[
                TextSpan(
                  text: 'Admin +918379939930',
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
          /* Textview(
              TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              title: "OR"),
          SizedBox(
            height: 28.h,
          ),
          socialLogin(),
          SizedBox(
            height: 28.h,
          ),
          Row(
            children: [
              Textview(
                  TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  title: "Don't have an Account? "),
              InkWell(
                onTap: () {
                  setState(() {
                    isSignIn = false;
                  });
                },
                child: Textview(
                    TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: ThemeColor.theme_blue),
                    title: "Sign Up"),
              ),
            ],
          ),*/
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
          CarouselSlider(
            items: <Widget>[
              for (var i = 0; i < imageList.length; i++)
                Column(
                  children: [
                    SvgPicture.asset(
                      "${imageList[i].img}",
                      width: 540.73.w,
                      height: 379.h,
                    ),
                    Textview(
                        TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                        title: imageList[i].title.toString()),
                    Textview(
                        TextStyle(
                          color: Color(0xffCBCBCB),
                          fontSize: 16.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                        title: imageList[i].description.toString()),
                  ],
                )
            ],
            carouselController: _controller,
            options: CarouselOptions(
                height: 550.h,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 12 / 7,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 44.w : 12.0.w,
                  height: 12.0,
                  margin: EdgeInsets.only(top: 8.0.h, left: 4.0.w, right: 4.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // shape: _current == entry.key ?BoxShape.rectangle:BoxShape.circle,
                      color: Colors.white
                          .withOpacity(_current == entry.key ? 1 : 1)),
                ),
              );
            }).toList(),
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
                        fontSize: 12.sp,
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
      final req = await http.post(Uri.parse(myUrl));
      print('the body is ${req.body}');
      if (req.statusCode == 200) {
        var jwtResponse = json.decode(req.body);
        print('the response is ${jwtResponse}');
        JWTLoginData jwtLoginData =
            JWTLoginData.fromJson(jwtResponse);
        if (jwtLoginData.data == '') {
          showCustomToast(context, jwtLoginData.message!, Icons.clear, Colors.red);
         EasyLoading.dismiss();
        } else {
          String token = jwtLoginData.data!;
          LocalSharePreferences()
              .setString(SharedPreferencesConstant.AuthToken, token);
          String finalToken = await LocalSharePreferences()
              .getString(SharedPreferencesConstant.AuthToken);
          print("Final Token ::"+finalToken);
        }

        String loginUrl = ApiConstant.BASE_URL + "api/getCurrentLoggedInJwt";
        debugPrint("Get Current User Url:" + loginUrl);

        String token = await LocalSharePreferences()
            .getString(SharedPreferencesConstant.AuthToken);
        final loginResponse =
            await dio.get(loginUrl,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  'Authorization': 'Bearer ${token}',
                }));
        print(loginResponse.data);
        EasyLoading.dismiss();
        if (loginResponse.statusCode == 200) {
          LoginDeatils loginDeatils = LoginDeatils.fromJson(jsonDecode(loginResponse.data));
          if (loginDeatils.data != null) {
            String response = jsonEncode(loginDeatils);
            LocalSharePreferences()
                .setString(SharedPreferencesConstant.LoginKey, response);
            LocalSharePreferences()
                .setBool(SharedPreferencesConstant.LoginKeyBool, true);

            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else {
            //ToastMessage.show(context, loginDeatils.message!);
            showCustomToast(context, loginDeatils.message!, Icons.clear, Colors.red);
          }
        } else {
        //  ToastMessage.show(context, "Try Again");
          showCustomToast(context, "Something went wrong! Please Try Again", Icons.clear, Colors.red);
        }
      } else {
       // ToastMessage.show(context, "Try Again");
        showCustomToast(context, "Something went wrong! Please Try Again", Icons.clear, Colors.red);
      }
    } else {
     // ToastMessage.show(context, "Please fill correct email and password");
      showCustomToast(context, "Please fill correct email and password", Icons.clear, Colors.red);
    }
  }
}
