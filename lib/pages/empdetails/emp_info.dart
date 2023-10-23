import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/lead_list.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_activities/list_meeting.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../dashboard/widget/header_widget.dart';
import 'activity/assign_project.dart';
import 'activity/customer_grpah.dart';
import 'activity/emp_meeting.dart';

class EmpInfo extends StatefulWidget {
  EmpData empData;

  EmpInfo({Key? key, required this.empData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EmpInfo();
  }
}

class _EmpInfo extends State<EmpInfo> {
  bool isStock = true;
  bool isReorder = false;
  bool isCreateMail = false;
  bool isMeeting = false;

  Widget _buildTextField(String label, String hint,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(label,style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w300,),),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w500,),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xffcccccc),fontSize: 13.sp,fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _inStockController = TextEditingController();
  TextEditingController _costPriceController = TextEditingController();
  TextEditingController _sellingPriceController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _vendorController = TextEditingController();
  TextEditingController _lowStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: ThemeColor.baground,
          child: Column(
            children: [
              HeaderWidget(title: "Product Info"),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 10.h, top: 20.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Images.back_arrow,
                        height: 21.h,
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.sp,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30.w, bottom: 40.h),
                child: Text(
                  'About Product',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.r),
                width: 1362.w,
                height: 400.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 100.r,
                            backgroundImage: AssetImage('assets/azi1.jpeg',)),
                        SizedBox(
                          width: 32.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Azithromycin 250 mg",
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text("Azithromycin is used to treat certain bacterial infections.",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Row(
                              children: [
                                Text("Expiry Date: ",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                                Text(" 23/01/2024",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w300,
                                        fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        SizedBox(
                          height: 58.h,
                          width: 180.w,
                          child: ElevatedButton(
                              onPressed: (){
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      content:  Container(
                                        width: 450.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                                        //padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Icon(Icons.arrow_back_ios,size: 16,)),
                                                SizedBox(width: 5.w,
                                                ),
                                                Text(
                                                  "Back",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.black,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h),
                                            Center(
                                              child: CircleAvatar(
                                                  radius: 100.r,
                                                  backgroundImage: AssetImage('assets/azi2.jpeg',)),
                                            ),
                                            SizedBox(height: 16.h,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                _buildTextField('Name','', _nameController),
                                                SizedBox(height: 16.h),
                                                _buildTextField('Quantity In stock','1200', _inStockController),
                                                SizedBox(height: 16.h),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(width:200.w,child: _buildTextField('Low stock warning','100', _lowStockController),),
                                                    SizedBox(width:200.w,child: _buildTextField('Expiry Date','10/10/2025', _lowStockController),),

                                                  ],
                                                ),

                                                SizedBox(height: 16.h),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(width:200.w,child: _buildTextField('Cost Price(1 item)','1134', _costPriceController)),
                                                    SizedBox(width:200.w,child: _buildTextField('Selling Price(1 item)','1250', _sellingPriceController)),

                                                  ],
                                                ),
                                                SizedBox(height: 16.h),
                                                _buildTextField('Preferred Vendor', 'Please select',_vendorController),

                                                SizedBox(height: 16.h),
                                                _buildTextField('Notes',"Enter additional notes" ,_notesController),
                                                /* ElevatedButton(
                onPressed: _submitForm,
                child: Center(child: Text('Submit')),
              ),*/
                                                SizedBox(height: 16.h),
                                                InkWell(
                                                  // onTap: _submitForm,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: ThemeColor.red,
                                                        borderRadius: BorderRadius.circular(5)),
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20,
                                                    ),
                                                    margin: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Add Product",
                                                        style: TextStyle(fontSize: 20.sp,fontFamily:
                                                        GoogleFonts.poppins().fontFamily,
                                                            fontWeight: FontWeight.w500, color: AppColor.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      //title: Text("Add Product"),
                                     /* onPositiveClick: () {
                                        Navigator.of(context).pop();
                                      },
                                      onNegativeClick: () {
                                        Navigator.of(context).pop();
                                      },*/
                                    );
                                  },
                                  animationType: DialogTransitionType.slideFromRight,

                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: ThemeColor.red,
                                  onPrimary: Colors.white
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_circle,size:18,),
                                  SizedBox(width: 6.w,),
                                  TextView(
                                    title: "Add Quantity",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400, color: Colors.white,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Unit of Measure",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text("Box/Boxes",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Text("Drug Type",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text("Specific Drug",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration:
                                BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Text("Physical Form",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily)),
                            Text("Tablets",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        Container(
                            width: 6.w,
                            height: 100.h,
                            decoration:
                            BoxDecoration(color: Color(0xffc3262c))),
                        Column(
                          children: [
                            Text("Dosage",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:
                                    GoogleFonts.poppins().fontFamily)),
                            Text("As per doctor",
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                    GoogleFonts.poppins().fontFamily))
                          ],
                        ),
                        // Container(
                        //     width: 6.w,
                        //     height: 100.h,
                        //     decoration:
                        //         BoxDecoration(color: Color(0xffc3262c))
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          isStock = true;
                          isReorder = false;
                          isCreateMail = false;
                          isMeeting = false;
                          setState(() {});
                        },
                        child: tab(isStock, "Stock Report")),
                    Container(
                      transform: Matrix4.translationValues(-80.w, 0, 0.0),
                      child: InkWell(
                          onTap: () {
                            isStock = false;
                            isReorder = true;
                            isCreateMail = false;
                            ;
                            isMeeting = false;
                            setState(() {});
                          },
                          child: tab(isReorder, "Re-Order")),
                    ),

                  ],
                ),
              ),
              Visibility(
                  visible: isStock,
                  child: EmpMeeting()),
              Visibility(
                  visible: isReorder,
                  child: AddProduct()),
            ],
          ),
        ),
      ),
    );
  }

  tab(bool isSelect, String title) {
    return Container(
      width: 450.w,
      height: 90.h,
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            Images.red_arrow,
            alignment: Alignment.center,
            width: 450.w,
            height: 90.h,
            color: isSelect ? Color(0xffC3262C) : Colors.white,
          ),
          // Container(
          //     transform: Matrix4.translationValues(-24.w, 0, 0.0),
          //     child: SvgPicture.asset("assets/back_arrow.svg")),
          Container(
            transform: Matrix4.translationValues(-30.w, 0, 0.0),
            height: 78.h,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelect ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  icons(String  Image){
    return Container(
      width: 54.w,
      height: 48.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50),
          borderRadius: BorderRadius.circular(10),
        ),
        
      ),
      child: Container(
          width: 30.w,
          height: 30.h,
          child: Padding(
            padding:  EdgeInsets.all(7),
            child: SvgPicture.asset(Image),
          )),
    );
  }
}
