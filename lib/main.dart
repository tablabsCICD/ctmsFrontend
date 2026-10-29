import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/firebase_api.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/all_users_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/more_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/news_provider.dart';
import 'package:flutter_hr_management/organization_portal/model/job_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/Create_Org_Provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/general_post_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/job_list_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/localization_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/plan_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/route_provider.dart';
import 'package:flutter_hr_management/pages/widget/custom_scroll_behavior.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // running on the web!
  } else {
    // NOT running on the web! You can check for additional platforms here.
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAY2xu3o1I0Ody0D3KTkMXHfpk6wpFAe-k",
            authDomain: "tkd-crm.firebaseapp.com",
            projectId: "tkd-crm",
            storageBucket: "tkd-crm.appspot.com",
            messagingSenderId: "906632873854",
            appId: "1:906632873854:web:0f4fc50be1f8de4de0952f",
            measurementId: "G-HT44YEF6PL"));
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  await setupLocator();

  runZonedGuarded(() async {
    runApp(OverlaySupport.global(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<MenuProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => locator<OrgUserProvider>()),
        ChangeNotifierProvider(create: (_) => locator<MoreProvider>()),
        ChangeNotifierProvider(create: (_) => locator<RouteProvider>()),
        ChangeNotifierProvider(create: (_) => locator<OrgProvider>()),
        ChangeNotifierProvider(create: (_) => locator<LocalizationProvider>()),
        ChangeNotifierProvider(create: (_) => locator<JobListProvider>()),
        ChangeNotifierProvider(create: (_) => locator<GeneralPostProvider>()),
        ChangeNotifierProvider(create: (_) => locator<AdvProvider>()),
        ChangeNotifierProvider(create: (_) => locator<NewsProvider>()),
        ChangeNotifierProvider(create: (_) => locator<CompanyBidProvider>()),
        ChangeNotifierProvider(create: (_) => locator<CompBuySellProvider>()),
      ],
      child: MyApp(),
    )));
  }, (error, stackTrace) {
    debugPrint("🔴 Caught in release: $error\n$stackTrace");
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CheckUserLogin();
  }

  CheckUserLogin() {
    return ScreenUtilInit(
      designSize: const Size(1440, 1020),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'TKD CRM',
          debugShowCheckedModeBanner: false,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: GoogleFonts.poppins().fontFamily),
          initialRoute: AppRoutes.entry,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
