import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'constant/SharedPreferencesConstant.dart';

class EntryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EntryState();
}

class EntryState extends State<EntryScreen> {
  final orgProvider = locator<OrgProvider>();
  LoginDeatils? loginDeatils;

  @override
  void initState() {
    super.initState();
    _checkIsLoggedIn(); // call async method safely
  }

  /// Check if user is logged in and navigate accordingly
  Future<void> _checkIsLoggedIn() async {
    bool isLogin = await LocalSharePreferences().isUserLoggedIn() ?? false;

    if (isLogin) {
      String? token =
      await LocalSharePreferences().getString(SharedPreferencesConstant.AuthToken);

      print("Token : $token");

      // You can also save token globally if needed
      // ApiConstant.token = token;

      // Maintain logged-in flag
      await LocalSharePreferences().setBool(SharedPreferencesConstant.LoginKeyBool, true);

      // Navigate to home
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      // Ensure logged-in flag is false
      await LocalSharePreferences().setBool(SharedPreferencesConstant.LoginKeyBool, false);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
