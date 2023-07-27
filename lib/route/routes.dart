import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/home_page.dart';
import 'package:flutter_hr_management/profile/profile_screen.dart';
import '../pages/empdetails/employee_list_dashboard.dart';

import '../pages/leaddeatils/add_lead.dart';
import '../pages/leaddeatils/lead_dashboard.dart';
import '../pages/report/report_dashbord.dart';
import '../profile/profile_dashbord.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(HomePage(), settings: settings);

      case AppRoutes.employee_dashbord:
        return buildRoute(EmloyeeListScreen(), settings: settings);

     case AppRoutes.lead_dashbord:
        return buildRoute(LeadListScreen(), settings: settings);
  case AppRoutes.report:
        return buildRoute(ReportDashboard(), settings: settings);
 case AppRoutes.profile:
        return buildRoute(ProfileDashbord(), settings: settings);

        default:
        return _errorRoute();


    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 450.0,
                  width: 450.0,
                  //child: Lottie.asset('assets/lottie/error.json'),
                ),
                 Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}