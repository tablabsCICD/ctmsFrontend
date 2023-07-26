

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../dashboard/dashboard.dart';
import 'employee_details.dart';

class EmloyeeListScreen extends StatefulWidget {
  @override
  _EmloyeeListScreen createState() => _EmloyeeListScreen();
}

class _EmloyeeListScreen extends State<EmloyeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      backgroundColor: AppColor.bgSideMenu,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Side Navigation Menu
            /// Only show in desktop
            if (AppResponsive.isDesktop(context))
              Expanded(
                child: SideBar(),
              ),

            /// Main Body Part
            Expanded(
              flex: 4,
              child: EmpDashboard(),
            ),
          ],
        ),
      ),
    );
  }
}