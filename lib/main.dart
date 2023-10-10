import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/controllers/menu_controller.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/group/groupChatProvider.dart';
import 'package:flutter_hr_management/organization/provider/group/groupListProvider.dart';
import 'package:flutter_hr_management/organization/provider/localization_provider.dart';
import 'package:flutter_hr_management/organization/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization/provider/more_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/provider/plan_provider.dart';
import 'package:flutter_hr_management/organization/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization/provider/route_provider.dart';
import 'package:flutter_hr_management/pages/empdetails/employee_details.dart';

import 'package:flutter_hr_management/pages/empdetails/employee_list_dashboard.dart';
import 'package:flutter_hr_management/pages/widget/custom_scroll_behavior.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<MenuProvider>()),
          ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
        //  ChangeNotifierProvider(create: (_) => locator<DashboardProvider>()),
        //  ChangeNotifierProvider(create: (_) => locator<TransportProvider>()),
        //  ChangeNotifierProvider(create: (_) => locator<JobProvider>()),
          //ChangeNotifierProvider(create: (_) => locator<GalleryProvider>()),
      //    ChangeNotifierProvider(create: (_) => locator<BuySellProvider>()),
          ChangeNotifierProvider(create: (_) => locator<PoolPurchaseProvider>()),
          ChangeNotifierProvider(create: (_) => locator<MoreProvider>()),
          ChangeNotifierProvider(create: (_) => locator<RouteProvider>()),
        //  ChangeNotifierProvider(create: (_) => locator<BidProvider>()),
          ChangeNotifierProvider(create: (_) => locator<OrgProvider>()),
       //   ChangeNotifierProvider(create: (_) => locator<FleetProvider>()),
          ChangeNotifierProvider(create: (_) => locator<LocalizationProvider>()),
          ChangeNotifierProvider(create: (_) => locator<PlanProvider>()),
     //     ChangeNotifierProvider(create: (_) => locator<RepeatProvider>()),
          ChangeNotifierProvider(create: (_) => locator<GroupListProvider>()),
          ChangeNotifierProvider(create: (_) => locator<GroupChatProvider>()),
        ],
        child: MyApp(),
      )));
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