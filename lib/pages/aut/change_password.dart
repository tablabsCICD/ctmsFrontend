import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import '../../common/app_colors.dart';
import '../../utils/sharepreferences.dart';
import '../widget/toast.dart';
class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  _buildPage(context) {
    return Scaffold(
        backgroundColor: AppColor.bgSideMenu,
        body: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/sidebar_image.png"),
                alignment: Alignment.bottomLeft,
                scale: 4.0
            ),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: null,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                              fontSize: 22,
                            ),
                          )),
                      SizedBox(height: 16),
                      _buildTextField('Enter new Password', _emailController),
                      SizedBox(height: 16),
                      _buildTextField('Renter Password', _passwordController),
                      SizedBox(height: 32),
                      InkWell(
                        onTap: _submitForm,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              color: AppColor.yellow,
                              borderRadius: BorderRadius.circular(100)),
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
  void _submitForm() async{

    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isNotEmpty && password.isNotEmpty){
      var formData = FormData.fromMap({
        'emailId': email,
        'password': password,

      });

      if(email.compareTo(password)==0){
        Dio dio=Dio();
        var response= await dio.post(ApiConstant.LOGIN_DATA+"/emailId",data:formData);
        if(response.statusCode==200){
          print('the body is ${response.data}');
          LoginDeatils loginDeatils=LoginDeatils.fromJson(jsonDecode(response.data));
          if(loginDeatils.data!=null){
            String response=jsonEncode(loginDeatils);
            LocalSharePreferences().setString(SharedPreferencesConstant.LoginKey, response);
            LocalSharePreferences().saveLoginFlag(true);
            Navigator.pushReplacementNamed(context, AppRoutes.home);

          }else{
          //  ToastMessage.show(context, loginDeatils!.message!);
            showCustomToast(context, loginDeatils.message!, Icons.clear, Colors.red);
          }
        }else{
        //  ToastMessage.show(context, "Try Again");
          showCustomToast(context, "Try Again", Icons.clear, Colors.red);
        }

      }else{
       // ToastMessage.show(context, "Password not matched");
        showCustomToast(context, "Password Not Matched", Icons.clear, Colors.red);
      }

    }else{

    }
  }


}