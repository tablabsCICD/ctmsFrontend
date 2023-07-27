import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';

import '../dashboard/widget/calender_widget.dart';
import '../dashboard/widget/header_widget.dart';
import '../dashboard/widget/notification_card_widget.dart';
import '../dashboard/widget/profile_card_widget.dart';
import '../dashboard/widget/recruitment_data_widget.dart';

import 'add_lead.dart';
import 'count_lead.dart';

class LeadDashboard extends StatefulWidget {
  @override
  _LeadDashboard createState() => _LeadDashboard();
}

class _LeadDashboard extends State<LeadDashboard> {
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
          HeaderWidget(title: "Lead Data",),
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
                          CountLeadWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          RecruitmentDataWidget(title: 'All Leads',),
                          if (AppResponsive.isMobile(context)) ...{
                            AddLead(),
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
                           AddLead(),
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