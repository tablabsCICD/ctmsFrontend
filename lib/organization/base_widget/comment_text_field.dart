import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class CommentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final int maxLine;
  final TextCapitalization capitalization;
  final IconData? iconData;
  final bool? obsecure;
  final bool? readOnly;
  final String? validatorMsg;
  Function? onTap;
  Function? onValueChange;
  final bool? isFocused;

  CommentTextField(
      {required this.controller,
      required this.hintText,
      required this.textInputType,
      this.maxLine = 1,
      this.validatorMsg,
      this.capitalization = TextCapitalization.none,
      this.iconData,
      this.obsecure,
      this.readOnly,
      this.onTap,
      this.onValueChange,
      this.isFocused});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 1),
      alignment: Alignment.center,
      // height: 45,
      child: TextFormField(
        onTap: () {
          onTap!();
        },
        onChanged: (vale) {
          onValueChange;
        },
        controller: controller,
        style: Style.dropdownValue,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: isFocused == true
                ? Colors.white
                : ColorResources.TEXTFEILD_COLOR,
            hintStyle: Style.searchHint,
            focusColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: ColorResources.COMMENT_BORDER,width: 1,style:BorderStyle.solid),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: isFocused == true
                    ? BorderSide(color: ColorResources.COMMENT_BORDER,width: 1,style:BorderStyle.solid)
                    : BorderSide.none),
            suffixIcon: GestureDetector(
                onTap: () {
                  onValueChange!();
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: isFocused == true
                      ? SvgPicture.asset("assets/images/send_red.svg")
                      : SvgPicture.asset("assets/images/send.svg"),
                )),
            suffixIconConstraints: BoxConstraints(minHeight: 15, minWidth: 15)),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
