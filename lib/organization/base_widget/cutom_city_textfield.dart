import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';


class CustomCityTextField extends StatelessWidget {
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

  CustomCityTextField({
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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
        alignment: Alignment.center,
      //  height: 47,
        child: TextFormField(
          controller: TextEditingController(text: controller),
          enabled: false,
          readOnly: true,
          style: Style.dropdownValue,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down_outlined,size: 26,color: Colors.black54,),
            hintText: hintText,
            filled: true,
            errorStyle: TextStyle(color: Colors.red),
            fillColor: ColorResources.TEXTFEILD_COLOR,
            hintStyle: Style.searchHint,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}






