import 'dart:convert';



import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/SharedPreferencesConstant.dart';

class LocalSharePreferences{
  static final LocalSharePreferences localSharePreferences = LocalSharePreferences._internal();
  factory LocalSharePreferences() {
    return localSharePreferences;
  }
  LocalSharePreferences._internal();

  setString(String key,String val)async{
   SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key,val);
  }
  setBool(String key,bool val)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key,val);
  }
  Future<String> getString(String key)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key)!;
  }

 Future<bool> getBool(String key)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   bool val =false;
   if(_prefs.getBool(key)!=null){
     val=_prefs.getBool(key)!;
   }
    return val;
  }

  setCompanyVisitingFlag(bool flag) async {
    if (flag == false) {
    }
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("Visited", flag);
  }


  Future<bool?> getCompanyVisitingFlag() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? alreadyVisited = await _prefs.getBool("Visited") ?? false;
    return alreadyVisited;
  }



  Future<LoginDeatils> getLoginData() async{
   String data  = await getString(SharedPreferencesConstant.LoginKey);
   LoginDeatils loginDeatils=LoginDeatils.fromJson(jsonDecode(data));
   return loginDeatils;
  }

  Future<Organization> getOrganizationData() async{
    String data  = await getString(SharedPreferencesConstant.companyKey);
    Organization orgDetails=Organization.fromJson(jsonDecode(data));
    return orgDetails;
  }

  Future<String> getLoginToken() async{
    String token  = await getString(SharedPreferencesConstant.AuthToken);
    return token;
  }

  Future<bool> logOut()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    setBool(SharedPreferencesConstant.LoginKeyBool, false);
    LocalSharePreferences()
        .setString(SharedPreferencesConstant.AuthToken, "null");
    return true;
  }


}