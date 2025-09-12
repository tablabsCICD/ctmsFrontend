import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/company/all_user_list.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';

import '../company_provider/all_users_provider.dart';

class AllUsers extends StatefulWidget {
  Organization? organization;
  final orgProvider = locator<OrgUserProvider>();

  AllUsers(this.organization, {Key? key}) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization!.id!);
  }

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgUserProvider>();
  String selectedTab = "All Users";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        drawer: CompanySideBar(),
        backgroundColor: ThemeColor.baground,
        body: Stack(
          children: [
            Row(
              children: [
                if (AppResponsive.isDesktop(context))
                  Expanded(
                    child: CompanySideBar(),
                  ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      HeaderWidget(
                        scaffoldKey: _scaffoldKey,
                        isSearchVisible: true,
                        onSearchTap: (value) {
                          orgProvider.filterSearchResults(value,"User");
                        },
                      ),
                      SizedBox(height: 16.h,),
                      Expanded(child: AllUsersList(widget.organization!)),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ));
  }



  getCircularContainer(String title, bool isSelected, int i) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) => InkWell(
        onTap: () {
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
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: CustomText(
              title,
              style: Style.filterHeading,
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xffe6e0d7),
              border: isSelected ? null : Border.all(color: Color(0xffd1ccc4)),
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
