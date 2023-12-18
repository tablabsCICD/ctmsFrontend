

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../model/response/employeelist.dart';
import '../dashboard/dashboard.dart';
import '../widget/progress_dialog.dart';
import 'meeting_page.dart';



class CreateMeetingDashbord extends StatefulWidget {
  @override
  _CreateMeetingDashbord createState() => _CreateMeetingDashbord();
}

class _CreateMeetingDashbord extends State<CreateMeetingDashbord> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ThemeColor.baground,
      drawer: SideBar(),
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
              child: MeetingPageScreen(_scaffoldKey),
            ),
          ],
        ),
      ),
    );
  }

}