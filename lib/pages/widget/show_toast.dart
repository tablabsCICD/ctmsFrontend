import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

showCustomToast(
    BuildContext context, String msg, IconData icon, MaterialColor color) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          msg,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
  fToast.showToast(
    child: toast,
    toastDuration: const Duration(seconds: 5),
    gravity: ToastGravity.TOP
  );
}
