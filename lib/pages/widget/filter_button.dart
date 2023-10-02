import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/images.dart';

filterIconButton() {
  return Container(
      width: 101.w,
      height: 43.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(
              Images.filter,
              height: 19.h,
              width: 20.w,
            ),
            SizedBox(width: 8.w,),
            Text(
              "Filter",
              style:TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ));
}