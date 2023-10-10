import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';


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
       // height: 30,
        width: 120,

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
            contentPadding: EdgeInsets.only(bottom: 10,left: 0,right: 0),
              suffixIcon: Icon(Icons.arrow_drop_down_outlined,size: 25,color: Colors.black,),
              hintText: hintText,
              hintStyle: Style.dashboardSearchHint,
              border:OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}






