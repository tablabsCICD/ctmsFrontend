
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../dashboard/dashboard.dart';
import 'customer_list.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _LeadListScreen createState() => _LeadListScreen();
}

class _LeadListScreen extends State<CustomerDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              child: CustomerList(_scaffoldKey),
            ),
          ],
        ),
      ),
    );
  }
}