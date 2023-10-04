import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/pages/widget/textviewone.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant/images.dart';

class ProfileCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: getProfile(),
      // child: Column(
      //   children: [
      //     Row(
      //       children: [
      //         ClipRRect(
      //           borderRadius: BorderRadius.circular(1000),
      //           child: Image.asset(
      //             "assets/user1.jpg",
      //             height: 60,
      //             width: 60,
      //           ),
      //         ),
      //         SizedBox(width: 10),
      //         Column(
      //           children: [
      //             Text(
      //               "Penny ",
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //             Text("HR Manager"),
      //           ],
      //         )
      //       ],
      //     ),
      //     Divider(
      //       thickness: 0.5,
      //       color: Colors.grey,
      //     ),
      //     profileListTile("Joined Date", "18-Apr-2021"),
      //     profileListTile("Projects", "32 Active"),
      //     profileListTile("Accomplishment", "125"),
      //   ],
      // ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
          ),
        ],
      ),
    );
  }


  getProfile() {
    return Container(
      height:380.h,
      width: 317.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
          radius: 65.r,
          backgroundImage: NetworkImage('assets/user1.jpg')),
          SizedBox(height: 19.h,),
          Text(
             'Mridula V',
            style:TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h,),
          Text(
             'HR Manager',
            style:TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
             'Joined Date : ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                '18 April 2021',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                     'Projects',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height:1.h),
                  Text(
                     '32',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 32.w,),
              Container(color: Colors.red,width: 3.w,height: 58.h,),
              SizedBox(width: 32.w,),
              Column(
                children: [
                  Text(
                'Accomplishment',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height:1.h),
                  Text(
                     '125',
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
