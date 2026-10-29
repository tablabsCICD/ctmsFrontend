import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/advertise_portal/advertise_home_page.dart';
import 'package:flutter_hr_management/advertise_portal/edit_adv.dart';
import 'package:flutter_hr_management/advertise_portal/my_advertise_page.dart';
import 'package:flutter_hr_management/advertise_portal/save_advertise_page.dart';
import 'package:flutter_hr_management/entry_screen.dart';
import 'package:flutter_hr_management/pages/customerdeatils/customer_dashboard.dart';
import 'package:flutter_hr_management/pages/home_page.dart';
import 'package:flutter_hr_management/pages/leaddeatils/short_lead_dashboard.dart';
import 'package:flutter_hr_management/pages/meeting/meetingdashbord.dart';
import 'package:flutter_hr_management/pages/orgnaization_page/home_orgnization.dart';
import 'package:flutter_hr_management/pages/report/emp_report.dart';
import 'package:flutter_hr_management/profile/profile_screen.dart';
import '../pages/aut/login.dart';
import '../pages/empdetails/employee_list_dashboard.dart';
import '../pages/leaddeatils/lead_dashboard.dart';
import '../pages/report/report_dashbord.dart';
import '../pages/start/start_home.dart';
import '../pages/widget/employee_dialog.dart';
import '../profile/profile_dashbord.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(HomeOrganizationScreen(), settings: settings);

      case AppRoutes.crm:
        return buildRoute(HomePage(), settings: settings);

      case AppRoutes.advertise:
        return buildRoute(AdvertiseHomePage(), settings: settings);

      case AppRoutes.advertise_home:
        return buildRoute(AdvertiseHomePage(), settings: settings);

      case AppRoutes.org_advertise:
        return buildRoute(AdvertiseHomePage(), settings: settings);

      case AppRoutes.my_advertise:
        return buildRoute(MyAdvertisePage(), settings: settings);

      case AppRoutes.save_advertise:
        return buildRoute(SaveAdvertisePage(), settings: settings);


     ;

      case AppRoutes.login:
        return buildRoute(LoginScreen(), settings: settings);

      case AppRoutes.entry:
        return buildRoute(EntryScreen(), settings: settings);

      case AppRoutes.employee_dashbord:
        return buildRoute(EmloyeeListScreen(), settings: settings);

      case AppRoutes.lead_dashbord:
        return buildRoute(LeadDashboardScreen(), settings: settings);

      case AppRoutes.shortLead_dashbord:
        return buildRoute(ShortLeadDashboardScreen(), settings: settings);

      case AppRoutes.empReport:
        return buildRoute(EmployeeReport(), settings: settings);

      case AppRoutes.report:
        return buildRoute(ReportDashboard(), settings: settings);

      case AppRoutes.customer:
        return buildRoute(CustomerDashboard(), settings: settings);

      case AppRoutes.profile:
        return buildRoute(ProfileDashbord(), settings: settings);

      case AppRoutes.meeting:
        return buildRoute(CreateMeetingDashbord(), settings: settings);

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
