import 'dart:convert';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization_portal/company/createt_ctms_organization.dart';
import 'package:flutter_hr_management/organization_portal/company/load_list.dart';
import 'package:flutter_hr_management/organization_portal/company/general_post_list.dart';
import 'package:flutter_hr_management/organization_portal/company/org_list_screen.dart';
import 'package:flutter_hr_management/organization_portal/provider/Create_Org_Provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/general_post_provider.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:flutter_hr_management/organization_portal/get_city_list.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/share_dialog_box.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/multi_select.dart';
import 'package:flutter_hr_management/organization_portal/open_whatsapp.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/share_data.dart';

import 'package:flutter_hr_management/organization_portal/util/dynamic_translation.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/cutom_city_textfield.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/date_converter.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';


class CreateOrgMenu extends StatelessWidget {

  final createOrgProvider = locator<CreateOrgProvider>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    createOrgProvider.getOrganizationList();
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
                      ),
                      SizedBox(height: 16.h,),
                      Expanded(child: CtmsOrgListScreen()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
