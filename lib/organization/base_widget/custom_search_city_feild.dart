import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomSearchCityTextField extends StatelessWidget {
  final String controller;
  final String hintText;
  final TextInputType? textInputType;
  final int maxLine;
  final bool isPhoneNumber;
  final bool isValidator;
  final TextCapitalization capitalization;
  final IconData? iconData;
  final bool? obsecure;
  final bool? readOnly;
  final String? validatorMsg;
  Function? onTap;

  CustomSearchCityTextField({
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.maxLine = 1,
    this.validatorMsg,
    this.isPhoneNumber = false,
    this.isValidator = false,
    this.capitalization = TextCapitalization.none,
    this.iconData,
    this.obsecure,
    this.readOnly,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        height: 52.h,
        width: 275.w,

        child: TextFormField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: controller),
          enabled: false,
          style: Style.dropdownValue,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorMsg;
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.only(bottom: 10,left: 0,right: 0),
            prefixIcon: Icon(Icons.location_on_outlined,size: 15,color: Color(0xff292929)),
              suffixIcon: controller.isEmpty?Icon(Icons.keyboard_arrow_down,size: 20,color: Color(0xff292929)):Icon(Icons.close,size: 20,color: Color(0xffC3262C)),
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xff292929),
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts.poppins().fontFamily
              ),
              border:OutlineInputBorder(
                borderRadius: new BorderRadius.circular(8.0.r),
                ),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}






