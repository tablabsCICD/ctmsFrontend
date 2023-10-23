import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/widget/editText_email.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../constant/constants.dart';

class HeaderWidget extends StatefulWidget {
  final String title;


   HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 111.h,
        child: Row(
            children: [
            if (!AppResponsive.isDesktop(context))
    IconButton(
      icon: Icon(
        Icons.menu,
        color: AppColor.black,
      ),
      onPressed: () {

      },
    )
    ,
    // Text(
    //   widget.title,
    //   style: TextStyle(
    //     fontSize: 30.sp,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    searchBar(),
    if (!AppResponsive.isMobile(context)) ...{
    Spacer(),
    Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    // navigationIcon(icon: Icons.search),
    // navigationIcon(icon: Icons.send),
    //navigationIcon(icon: Icons.notifications_none_rounded),

      Container(
          width: 50.w,
          height: 50.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Images.notification,color: Colors.black,height: 30.h,width: 30.w,),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:ThemeColor.baground)),
      SizedBox(width: 27.w,),
      Container(
          width: 50.w,
          height: 50.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.settings,color: Colors.black,size: 30.h),
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:ThemeColor.baground)),
      SizedBox(width: 27.w,),
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: getImage("",height: 50.h,width: 50.w),
      ),
      SizedBox(width: 18.w,),
      Text('${Constants.LOGIN_NAME}', style: TextStyle(
          fontSize: 20.sp,
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontFamily: GoogleFonts.poppins().fontFamily)),
      SizedBox(width: 20.w,)




    ],
    )
    }
    ]
    ,
    )
    ,
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }


  searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 121.w, top: 23.h, bottom: 25.h),
      width: 414.w,
      height: 63.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(43),
          color: Color(0xfff6f6f6)),
      child: edittext(),
    );
  }


  edittext() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: 414.w,
        height: 62.h,
        child: TextField(
          controller: TextEditingController(),
          onChanged: (value) {

          },

          decoration: InputDecoration(
              hintText: "Search",


              border: InputBorder.none,

              suffixIcon: Icon(CupertinoIcons.search, color: Color(0xff7F7E7E))
              ,
              hintStyle: TextStyle(
                color: Color(0x662C363F),
                fontSize: 18.sp,
                fontFamily: GoogleFonts
                    .poppins()
                    .fontFamily,
                fontWeight: FontWeight.w400,


              )
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: GoogleFonts
                .poppins()
                .fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
  //LoginDeatils? details;
  void getLoginDetails() async{
  // details = await LocalSharePreferences().getLoginData();
  // Constants.LOGIN_NAME=details!.data!.firstName!+" "+details!.data!.lastName!;
  // setState(() {
  //
  // });
    Constants.LOGIN_NAME="Parag"+" "+"Kumbhar";

  }
}
