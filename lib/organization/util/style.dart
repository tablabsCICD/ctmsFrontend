import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
class Style{
 static TextStyle searchHint = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',fontWeight:FontWeight.normal,color: Color(0xffb19f88));
 static TextStyle dashboardSearchHint = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',color: Color(0xff000000));
 static TextStyle leadingName = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff000000),);
 static TextStyle companyName = TextStyle(fontSize: 10,fontFamily: 'RobotoSlabRegular',color: Color(0xff888888));
 static TextStyle languageHeading = TextStyle(fontSize: 10,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));
 static TextStyle menuHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xff525252));
 static TextStyle selectedMenuHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold,color: Color(0xff010101));
 static TextStyle menuArrowHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff525252));
 static TextStyle selectedArrowMenuHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlab-Bold',fontWeight: FontWeight.bold,color: Color(0xff010101));
 static TextStyle sponsered = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xffffffff));

 static TextStyle splashheading = TextStyle(fontSize: 30,fontFamily: 'RobotoSlabRegular',fontWeight: FontWeight.bold,color: Color(0xff010101));
 static TextStyle splashContent = TextStyle(fontSize: 16,fontFamily: 'RobotoSlabLight',color: Color(0xff010101));
 static TextStyle loginHeading = TextStyle(fontSize: 20,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));
 static TextStyle newheading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabLight',color: Color(0xff010101));
 static TextStyle aleaready = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xffea6935),decoration: TextDecoration.underline,);
 static TextStyle newheadingappbar = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xffea6935),decoration: TextDecoration.underline,);
 static TextStyle creategroup= TextStyle(fontSize: 20,fontFamily: 'RobotoSlabRegular',color: Color(0xffea6935));
 static TextStyle addUser= TextStyle(fontSize: 18,fontFamily: 'RobotoSlabRegular',color: Color(0xffea6935),);

 static TextStyle appbarheading = TextStyle(fontSize: 22,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold,color: Color(0xffffffff));
 static TextStyle heading = TextStyle(fontSize: 20,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle headingBack = TextStyle(fontSize: 20,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold,color: Color(0xff555555));

 static TextStyle heading1 = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));
 static TextStyle appheading = TextStyle(fontSize: 18,fontFamily: 'RobotoSlabBold',color: Color(0xff010101),fontWeight: FontWeight.bold);
 static TextStyle appsubtitle = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);

 static TextStyle okButton = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xff6ea106));
 static TextStyle cancelButton = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xffea6935));

 static TextStyle dropdownValue = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle filtterHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle filtterContent = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));
 static TextStyle loadHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoMedium',color: Colors.white);
 static TextStyle title = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',color: Color(0xff000000));
 static TextStyle subtitle = TextStyle(fontSize: 10,fontFamily: 'RobotoSlabRegular',color: Color(0xff888888));
 static TextStyle date = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xffababab));
 static TextStyle content = TextStyle(fontSize: 12,fontFamily: 'RobotoRegular',color: Color(0xff555555));
 static TextStyle contentHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle cityHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoRegular',color: Color(0xff000000));
 static TextStyle bottomHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular',decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR);
 static TextStyle callHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Colors.black);

 static TextStyle transportSearchHeading = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabRegular');
 static TextStyle vehicleLable = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle vehicleData = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));
 static TextStyle tabHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold,color: Color(0xff010101));
 static TextStyle insuranceHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold);
 static TextStyle insuranceSubHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xff010101));

 static TextStyle button = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',color: Color(0xffffffff));
 static TextStyle buttonType2 = TextStyle(fontSize: 14,fontFamily: 'RobotoSlabBold',color: Color(0xff000000));
 static TextStyle boardButton = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabBold',color: Color(0xffffffff));
 static TextStyle boardButton1= TextStyle(fontSize: 8,fontFamily: 'RobotoSlabBold',color: Color(0xffffffff));

 static TextStyle planTitle = TextStyle(fontSize: 16,fontFamily: 'RobotoSlabBold',fontWeight: FontWeight.bold,color: Color(0xffffffff));
 static TextStyle planSubtitle = TextStyle(fontSize: 12,fontFamily: 'RobotoSlabRegular',color: Color(0xfff3f0f0));
 static TextStyle price = TextStyle(fontSize: 24,fontFamily: 'PingFangSC-Regular',fontWeight: FontWeight.bold,color: Color(0xffffffff));

 static TextStyle filterHeading = TextStyle(fontSize: 12,fontFamily: 'RobotoBold',fontWeight: FontWeight.bold,color: Color(0xff262626));

 static TextStyle tabText = TextStyle(fontSize: 12,fontFamily: 'RobotoRegular',color: Color(0xff000000));

 static TextStyle groupNameEdit= TextStyle(fontSize: 24,fontFamily: 'PingFangSC-Regular',fontWeight: FontWeight.bold,color: Colors.black);

}