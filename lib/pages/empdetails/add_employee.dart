import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/request/save_emp.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../model/request/update_emp.dart';

class EditEmployee extends StatefulWidget {
  final EmployeeData empData;

  const EditEmployee({Key? key, required this.empData}) : super(key: key);

  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addLeadController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  setData(){
    _nameController.text=widget.empData.firstName!;
    _lastnameController.text=widget.empData.lastName!;
    _emailController.text=widget.empData.emailId!;
    _phoneController.text=widget.empData.contact!;
    _addLeadController.text=widget.empData.address!;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Center(child: Text(
            "Edit Employee",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          SizedBox(height: 16),
          _buildTextField('Frist Name', _nameController),
          SizedBox(height: 16),
          _buildTextField('Last Name', _lastnameController),
          SizedBox(height: 16),
          _buildTextField('Email', _emailController),
          SizedBox(height: 16),
          _buildTextField('Phone', _phoneController),
          /*Row(
            children: [
              Expanded(
                child: _buildTextField('Email', _emailController),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Phone', _phoneController),
              ),
            ],
          ),*/
          SizedBox(height: 16),
          _buildTextField('Address', _addLeadController),
          SizedBox(height: 16),
          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
          InkWell(
            onTap: _submitForm,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeColor.theme_blue,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20.sp,fontFamily:
                  GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildTextField(String label, TextEditingController controller) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.black),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //       child: TextField(
  //         controller: controller,
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           labelText: label,
  //           labelStyle: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _submitForm() async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    String addLead = _addLeadController.text.toString();
    String lastName=_lastnameController.text.toString();
    UpdateEMP saveEmploye=UpdateEMP();
    saveEmploye.firstName=name;
    saveEmploye.lastName=lastName;
    saveEmploye.emailId=email;
    saveEmploye.address=addLead;
    saveEmploye.contact=phone;
    saveEmploye.id=widget.empData.id;
    print(saveEmploye.toJson());
    Dio dio=Dio();
    var response=await dio.put(ApiConstant.EDIT_EMP,data: jsonEncode(saveEmploye.toJson()),options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response);
    if(response.statusCode==200){
    //  ToastMessage.show(context, "Emp Edit Success");
      showCustomToast(context, "Emp Details Edit Success", Icons.check, Colors.green);
      Navigator.pop(context);
    }

  }


  Widget _buildTextField(String label,TextEditingController controller) {
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
                hintText: label,
                hintStyle: TextStyle(color: Color(0xffcccccc),fontSize: 13.sp,fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }


}