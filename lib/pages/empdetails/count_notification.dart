import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';

import '../../common/app_responsive.dart';

class CountCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.yellow, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,


        children: [

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("1007",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
              Text("Total",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,),),
            ],


          ),

          SizedBox(width: 40,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("0999",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
              Text("Active",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,),),
            ],),
          SizedBox(width: 40,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("0099",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
                  Text("Inactive",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,),),
                ],),
          SizedBox(width: 40,),

          if (!AppResponsive.isMobile(context)) ...{
            Spacer(),
            Image.asset(
              "assets/employess.png",
              height: 160,
            )
          }
        ],
      ),
    );
  }
}
