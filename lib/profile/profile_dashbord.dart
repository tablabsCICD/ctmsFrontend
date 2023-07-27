
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/profile/profile_screen.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../pages/widget/side_bar_menu.dart';

class ProfileDashbord extends StatefulWidget {
  @override
  _ProfileDashbord createState() => _ProfileDashbord();
}

class _ProfileDashbord extends State<ProfileDashbord> {
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
              child: ProfileInfo(),
            ),
          ],
        ),
      ),
    );
  }
}