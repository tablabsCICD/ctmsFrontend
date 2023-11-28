import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textview1 extends StatelessWidget {
 final String title;
  TextStyle style= TextStyle(
   color: Colors.white,
   fontSize: 8,
   fontFamily: 'Poppins',
   fontWeight: FontWeight.w600,
 );

   Textview1(this.style,{key, required this.title});

  @override
  Widget build(BuildContext context) {
    return
      Text(
        title,
        style: style,
      );
  }


}