import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'constant/SharedPreferencesConstant.dart';


class EntryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return EntryState();
  }

}

class EntryState extends State<EntryScreen>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),

      ),

    );
  }

  void checkIsLoggedIn()async {
    bool isLogin =await LocalSharePreferences().getBool(SharedPreferencesConstant.LoginKeyBool);
    if(isLogin==true){
     // getToken();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }else{
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

 /* Future<void> getToken() async {
    String finalToken = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    print('Final Token::::::'+finalToken);
    ApiConstant.token=finalToken;
    setState(() {
    });
  }*/

}