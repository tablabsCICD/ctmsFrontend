import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class EditTextEmail extends StatelessWidget {
  final double width;
  final double height;
  final String hint ;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  TextInputType? keybordType=TextInputType.text;
  Function(String val)? onChange =(val){};

  EditTextEmail({this.onChange,this.keybordType ,required this.width, required this.height, required this.hint, required this.controller,this.prefixIcon,this.suffixIcon} );



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        onChanged: (value){
          onChange!(value);
        },
        keyboardType: keybordType,
        decoration: InputDecoration(
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent.shade100),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            prefixIcon: Icon(prefixIcon,color: Color(0xff7F7E7E),),
            suffixIcon: Icon(suffixIcon,color: Color(0xff7F7E7E))
            ,
            hintStyle:TextStyle(
              color: Color(0x662C363F),
              fontSize: 15,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,

            )
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


}