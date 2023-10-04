import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_colors.dart';

class ProfileInfo extends StatefulWidget {
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
    return  SingleChildScrollView(
        child: isload?Center(
          child: CircularProgressIndicator(),

        ):Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWidget(title: "Profile"),
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
                          CircleAvatar(
                              radius: 100.r,
                              backgroundImage: NetworkImage('assets/user1.jpg')),
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
                                  loginDeatils!.data!.role!.name!,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 20.sp,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w300,),
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/images/fb_logo.svg',height: 25.h,width: 25.h,),
                                    SizedBox(width: 25.w,),
                                    SvgPicture.asset('assets/images/gmail_logo.svg',height: 25.h,width: 25.h,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          getIconData('assets/call.svg',onTap:(){

                          }),
                          getIconData('assets/mail.svg',onTap:(){

                          }),
                          getIconData('assets/more_icon.svg',onTap:(){

                          }),
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
                    Text(
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
                              loginDeatils!.data!.address!,
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
                    ),
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
                              "Mobile : ${loginDeatils.data!.mobileNumber!}",
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