import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';

import '../dashboard/widget/calender_widget.dart';
import '../dashboard/widget/header_widget.dart';
import '../dashboard/widget/notification_card_widget.dart';
import '../dashboard/widget/profile_card_widget.dart';
import '../dashboard/widget/recruitment_data_widget.dart';

import 'add_employee.dart';
import 'count_notification.dart';




class EmpDashboard extends StatefulWidget {
  @override
  _EmpDashboard createState() => _EmpDashboard();
}

class _EmpDashboard extends State<EmpDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          HeaderWidget(title: "Employee Data",),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          CountCardWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          RecruitmentDataWidget(title: 'All Employee',),
                          if (AppResponsive.isMobile(context)) ...{
                            AddEmployee(),
                            SizedBox(
                              height: 20,
                            ),
                          },

                        ],
                      ),
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                           AddEmployee(),
                            SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}