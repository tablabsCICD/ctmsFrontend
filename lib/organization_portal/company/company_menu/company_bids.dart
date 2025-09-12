import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/company/all_bids.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CompanyBidsScreen extends StatefulWidget {
  final bidProvider = locator<OrgProvider>();


  Organization? organization;
  CompanyBidsScreen(this.organization,{Key? key}) ;

  @override
  _CompanyBidsScreenState createState() => _CompanyBidsScreenState();
}

class _CompanyBidsScreenState extends State<CompanyBidsScreen> {
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
                      Expanded(child: BidList(widget.organization!)),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ));
  }
}
