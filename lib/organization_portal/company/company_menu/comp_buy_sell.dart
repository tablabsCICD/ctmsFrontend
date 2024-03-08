import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/company/buy_sell_list.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/share_dialog_box.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/open_whatsapp.dart';
import 'package:flutter_hr_management/organization_portal/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/job_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/share_data.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/util/date_converter.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

import 'package:universal_html/html.dart' as html;

class CompBuySell extends StatefulWidget {
  final buySellProvider = locator<OrgProvider>();
  Organization organization;
  CompBuySell(this.organization,{Key? key}) : super(key: key) {
    buySellProvider.getBuyVehicles(organization.id!);
  }



  @override
  _CompBuySellState createState() => _CompBuySellState();
}

class _CompBuySellState extends State<CompBuySell> {
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
                        isSearchVisible: false,
                        onSearchTap: () {},
                      ),
                      SizedBox(height: 16.h,),
                      Expanded(child: BuySellList(widget.organization)),
                    ],
                  ),
                ),
              ],
            ),
            if (ResponsiveWidget.isDesktop(context)) Positioned(
              top: 105.h,
              left: 265.w,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                child: SvgPicture.asset(
                  "assets/back_button.svg",
                  height: 80.h,
                  width: 80.w,
                ),
              ),
            ) else SizedBox.shrink(),
          ],
        ));
  }

  var selectedTab = 'Buy Vehicles';

  getCircularContainer(String title, bool isSelected) {
    return InkWell(
      onTap: (){
        setState(() {
          selectedTab = title;
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
    );
  }
}

