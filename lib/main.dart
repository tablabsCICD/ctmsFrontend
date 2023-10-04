import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/controllers/menu_controller.dart';
import 'package:flutter_hr_management/pages/empdetails/employee_details.dart';

import 'package:flutter_hr_management/pages/empdetails/employee_list_dashboard.dart';
import 'package:flutter_hr_management/pages/widget/custom_scroll_behavior.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CheckUserLogin();

  }

  CheckUserLogin() {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   initialRoute: AppRoutes.home,
    //   onGenerateRoute: RouteGenerator.generateRoute,
    // );


   return ScreenUtilInit(
      designSize: const Size(1440, 1020),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
              title: 'TKD CRM',
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: GoogleFonts.poppins().fontFamily
              ),
              initialRoute: AppRoutes.entry,
              onGenerateRoute: RouteGenerator.generateRoute,
          builder: EasyLoading.init(),
            );
      },
    );
  }


}