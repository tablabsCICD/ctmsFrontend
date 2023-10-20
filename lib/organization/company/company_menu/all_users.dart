

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization/company/all_user_list.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';


class AllUsers extends StatefulWidget {
  Organization organization;
  final orgProvider = locator<OrgProvider>();
  AllUsers(this.organization,{Key? key}) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization.id!);
  }

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();
  String selectedTab = "All Users";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) =>
              Row(
                children: [
                  if (AppResponsive.isDesktop(context))
                    Expanded(
                      child: CompanySideBar(),
                    ),

                  /// Main Body Part
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        HeaderWidget(),
                        Expanded(child: AllUsersList(widget.organization)),
                      ],
                    ),
                  ),

                ],
              )

      ),
    );
  }

  getCircularContainer(String title, bool isSelected,int i) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) =>InkWell(
        onTap: (){
          setState(() {
            selectedTab = title;
            model.getUserList(title);
          });

        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 2.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
            child: CustomText(title,style: Style.filterHeading,textAlign: TextAlign.center,),
            decoration: BoxDecoration(
              color: isSelected? Colors.white :Color(0xffe6e0d7),
              border: isSelected? null : Border.all(color: Color(0xffd1ccc4)),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}