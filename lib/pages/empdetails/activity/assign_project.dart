import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/model/response/lead_assign.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/response/lead_activity.dart';

class AddProduct extends StatefulWidget{

  AddProduct({Key? key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AssignProject();
  }

}
class _AssignProject extends State<AddProduct>{

  List<LeadAssignedData>listLeadActivityData=[];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _inStockController = TextEditingController();
  TextEditingController _costPriceController = TextEditingController();
  TextEditingController _sellingPriceController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _vendorController = TextEditingController();
  TextEditingController _lowStockController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 450.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
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
          Center(
            child: Text(
              "Product Detail",
              style: TextStyle(
                fontFamily:
                GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
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
              _buildTextField('Low stock warning','100', _lowStockController),
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
    );
  }

  listTile(context,index){

    return Container(
      width: 1362.w,
      height: 125.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),

      child: Center(
        child: ListTile(

          leading: getImage('${listLeadActivityData[index].addLogo}',height: 30.h,width: 30.w),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listLeadActivityData[index].companyName!}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily:  GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  "${listLeadActivityData[index].emailId!}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontFamily:  GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
             ],
            ),
          ),

          trailing:  Text(
            "${listLeadActivityData[index].date}",
            style: TextStyle(
              color: Color(0xFF858585),
              fontSize: 16.sp,
              fontFamily:  GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),


        ),
      ),
    );
  }




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


}