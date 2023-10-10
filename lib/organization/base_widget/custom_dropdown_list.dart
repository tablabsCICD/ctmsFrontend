import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';

class CustomDropdownList extends StatelessWidget {
  //final String controller;
  final String hintText;
  String selectedType;
  List<String> items;
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
  Function onChange;

  CustomDropdownList(
      {
      required this.hintText,
      required this.selectedType,
      required this.items,
      this.textInputType,
      this.maxLine = 1,
      this.validatorMsg,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.capitalization = TextCapitalization.none,
      this.iconData,
      this.obsecure,
      this.readOnly,
      this.onTap,
      required this.onChange}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
          // height: 47,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
          ),
          child: FormBuilderDropdown(
              name: hintText,
             // initialValue: selectedType??'',
              //allowClear: true,
              isDense: false ,
              decoration: InputDecoration.collapsed(
                hintText: '',
                filled: true,
                fillColor: ColorResources.TEXTFEILD_COLOR,
                border:OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                    borderSide: BorderSide.none
                ),
              ),

              items: items
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Container(  
                         // height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                          child: Text(
                            '$value',
                            style: Style.dropdownValue,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (String? value) {
                onChange(value);
              })),
    );
  }
}
