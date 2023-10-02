import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/clolor.dart';
import '../widget/textview.dart';

class StartHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _StartHomeState();
  }

}

class _StartHomeState extends State<StartHome>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child:  Padding(
              padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 66.w,),
                      Padding(
                        padding: EdgeInsets.only(top: 56.h),
                        child: Image.asset("assets/logo.png",height: 66.sp,width: 144.sp,),
                      ),
                      
                      SizedBox(width: 30.w,),
                      Padding(
                        padding:  EdgeInsets.only(top: 72.h,left:30.w ),
                        child: TextView(title: 'Home', fontSize: 22.sp,color: Colors.white,fontWeight: FontWeight.w400),

                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 72.h,left:10.w ),
                        child: TextView(title: 'About', fontSize: 22.sp,color: Colors.red,fontWeight: FontWeight.w700,),

                      ),

                      Padding(
                        padding:  EdgeInsets.only(top: 72.h,left:10.w ),
                        child: TextView(title: 'Contact Us', fontSize: 22.spMin,color: Colors.white,fontWeight: FontWeight.w400,),

                      )


                    ],
                    
                  )
                  
                  
                ],
                
                
              ),
                color: AppColors.primary_color,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )
            ),
          ),
          color: AppColors.white,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
   );
  }

}