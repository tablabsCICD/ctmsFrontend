import 'dart:convert';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization/company/discussion_list.dart';
import 'package:flutter_hr_management/organization/company/load_list.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:http/http.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:flutter_hr_management/organization/get_city_list.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/share_dialog_box.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/multi_select.dart';
import 'package:flutter_hr_management/organization/open_whatsapp.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/share_data.dart';

import 'package:flutter_hr_management/organization/util/dynamic_translation.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/cutom_city_textfield.dart';
import 'package:flutter_hr_management/organization/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';

import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/date_converter.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';

class CompDiscussionScreen extends StatefulWidget {
  final dashboardProvider = locator<OrgProvider>();
  Organization organization;
  final orgProvider = locator<OrgProvider>();
  CompDiscussionScreen(this.organization,{Key? key}) : super(key: key) {
    dashboardProvider.getOrgFullLoadList(organization.id!);
  }



  @override
  _CompDiscussionScreenState createState() => _CompDiscussionScreenState();
}

class _CompDiscussionScreenState extends State<CompDiscussionScreen> {
  final bidProvider = locator<BidProvider>();
  final authProvider = locator<AuthProvider>();
  int counter = 0;
  var selectedPageNumber = 1;
  final dashboardProvider = locator<DashboardProvider>();
  ScrollController _scrollController = ScrollController();
  String? selectedFromCity = '',selectedToCity = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        dashboardProvider.getFullLoadTruckList(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<OrgProvider>(
        builder: (context, model, child) =>  Row(
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
                  HeaderWidget(isSearchVisible:true,),
                  Expanded(child: DiscussionList(widget.organization,index: 1,)),

                ],
              ),
            ),

          ],
        )

    );
  }

  Set<int>? selectedValues = [1, 2, 3, 4, 5].toSet();

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'All Requirements'),
      MultiSelectDialogItem(2, 'Required - Full load vehicle'),
      MultiSelectDialogItem(3, 'Required - Part load vehicle'),
      MultiSelectDialogItem(4, 'Available - Full load vehicle'),
      MultiSelectDialogItem(5, 'Available - Part load vehicle'),
    ];

    selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selectedValues,
        );
      },
    );
    print(selectedValues!.length);
    print(selectedValues);
  }

  String getText(Set<int>? selectedValues) {
    int count = selectedValues!.length;
    String message = getTranslated('all_requirements', context)!;
    if (count == 5)
      return message;
    else
      return '${count} ' + getTranslated('requirements_selected', context)!;
  }

  var selectedTab = 'All Loads';
  late List<int> selectedValuesList = <int>[];

  getCircularContainer(String title, bool isSelected,int i) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) =>InkWell(
        onTap: (){
          setState(() {
            selectedTab = title;
            model.getFilterFullLoadList(title);
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
