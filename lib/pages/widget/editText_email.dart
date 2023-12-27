

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class EditTextEmail extends StatefulWidget {
  final double width;
  final double height;
  final String hint ;
  final bool? isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextEditingController controller;
  TextInputType? keybordType=TextInputType.text;
  //Function(String val) onChange =(val){};

  EditTextEmail({this.keybordType ,required this.width, required this.height, required this.hint, required this.controller,this.prefixIcon,this.suffixIcon,this.isPassword} );

  @override
  State<EditTextEmail> createState() => _EditTextEmailState();
}

class _EditTextEmailState extends State<EditTextEmail> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        onChanged: (value){
        //  widget.onChange(value);
        },
        obscureText: widget.isPassword==true?passwordVisible:false,
        keyboardType: widget.keybordType,
        decoration: InputDecoration(
            hintText: widget.hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent.shade100),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            prefixIcon: Icon(widget.prefixIcon,color: Color(0xff7F7E7E),),
            suffixIcon: widget.suffixIcon==null?null:IconButton(
              icon: Icon(passwordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,color: Colors.grey,),
              onPressed: () {
                setState(
                      () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
           // Icon(suffixIcon,color: Color(0xff7F7E7E)),
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