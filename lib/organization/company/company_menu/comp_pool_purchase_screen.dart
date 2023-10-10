import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization/open_whatsapp.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization/share_data.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization/pool_purchase/create_pool_purchase_post.dart';
import 'package:flutter_hr_management/organization/pool_purchase/multi_select_menu.dart';
import 'package:flutter_hr_management/organization/pool_purchase/pool_purchase_detail_screen.dart';
import 'package:universal_html/html.dart' as html;

class CompanyPoolPurchesScreen extends StatefulWidget {
  final poolPurchaseProvider = locator<OrgProvider>();

  final buySellProvider = locator<OrgProvider>();
  Organization organization;
  CompanyPoolPurchesScreen(this.organization,{Key? key}) : super(key: key) {
    poolPurchaseProvider.getOrgPoolPurchaseList(organization.id!);
  }



  @override
  _CompanyPoolPurchesScreenState createState() => _CompanyPoolPurchesScreenState();
}

class _CompanyPoolPurchesScreenState extends State<CompanyPoolPurchesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: ColorResources.HOME_BG,
        child: ResponsiveWidget(
          desktop: PoolPurchaseCard(),
          mobile: PoolPurchaseCard(),
          tablet: PoolPurchaseCard(),
        ),
      ),
    );
  }
}

class PoolPurchaseCard extends StatefulWidget {
  @override
  _PoolPurchaseCardState createState() => _PoolPurchaseCardState();
}

class _PoolPurchaseCardState extends State<PoolPurchaseCard> {
  final poolPurchaseProvider = locator<OrgProvider>();
  int selectedPageNumber = 1;
  ScrollController _scrollController = ScrollController();

 /* @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        poolPurchaseProvider.getOrgPoolPurchaseList(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      body: Consumer<OrgProvider>(
        builder: (context, model, child) =>
            Container(
              // padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    color: ColorResources.HOME_APPBAR,
                    child: Padding(
                      padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35,vertical: 10):EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        children: [
                          getCircularContainer("All Requirement",(selectedTab == "All Requirement")),
                          getCircularContainer("Vehicles",(selectedTab == "Vehicles")),
                          getCircularContainer("Tyres",(selectedTab == "Tyres")),
                          getCircularContainer("Body Building",(selectedTab == "Body Building")),
                          getCircularContainer("Finance",(selectedTab == "Finance")),
                          getCircularContainer("Insurance",(selectedTab == "Insurance")),
                          getCircularContainer("Other",(selectedTab == "Other")),
                        ],
                      ),
                    ),
                  ),
                  /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    width: screenSize.width / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          _showMultiSelectMenu(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getText(selectedValues),
                                style: Style.filtterHeading),
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: screenSize.width / 8,
                    child: CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      CreatePoolPurchasePost()));
                        },
                        buttonText: getTranslated('post', context)!),
                  ),
                ],
              ),*/
                  SizedBox(height: 10,),
                  model.orgPoolPurchaseList.isEmpty && model.isLoading == false

                      ? Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          margin: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
                          child: Center(child: Text(getTranslated('no_post', context)!,style: Style.heading,))))
                      : Expanded(
                      child: Container(
                        margin: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
                        child: StaggeredGridView.countBuilder(
                          controller: _scrollController,
                          physics: ScrollPhysics(),
                          crossAxisCount: ResponsiveWidget.isDesktop(context)
                              ? 3
                              : ResponsiveWidget.isMobile(context)
                              ? 1
                              : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          itemCount: model.orgPoolPurchaseList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                              /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            PoolPurchaseDetailsScreen(model.poolPurchaseList[index])));*/
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 7),
                                        child: CustomText(
                                            model.orgPoolPurchaseList[index].purchaseItem
                                                .toString(),
                                            style: Style.title),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, bottom: 10, right: 10),
                                        child: CustomText(
                                          model.orgPoolPurchaseList[index].description
                                              .toString(),
                                          style: Style.subtitle,
                                        ),
                                      ),
                                      Divider(
                                        height: 1.5,
                                        thickness: 1.5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            /*InkWell(
                                              onTap: () async {
                                                *//*showDialog(context: context,
                              builder: (BuildContext context){
                              return ShareDialogBox(
                             // model.orgSellList![index]
                              );
                              }
                              );*//*

                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/share.png',
                                                    color: ColorResources.PRIMARY_COLOR,
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      getTranslated("share", context)!,
                                                      style: Style.bottomHeading)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1.5,
                                              height: 30,
                                              color: Colors.grey,
                                            ),*/
                                            InkWell(
                                              onTap: () {
                                                openwhatsapp(
                                                    context,
                                                    model.orgPoolPurchaseList[index]
                                                        .mobileNumber
                                                        .toString(),
                                                    'Type : ${model.orgPoolPurchaseList[index].type}, \nSubject : ${model.orgPoolPurchaseList[index].description}');
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/chat.png',
                                                    color: ColorResources.PRIMARY_COLOR,
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      getTranslated("chat", context)!,
                                                      style: Style.bottomHeading)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1.5,
                                              height: 30,
                                              color: Colors.grey,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                    new CupertinoAlertDialog(
                                                      title: CustomText(
                                                          'Contact Number : ${model.orgPoolPurchaseList[index].mobileNumber}',
                                                          style: TextStyle(
                                                              color:
                                                              ColorResources
                                                                  .BOTTOM_HEADING,
                                                              fontSize: 18,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                            child: CustomText(
                                                                "Ok",
                                                                style: TextStyle(
                                                                    color:
                                                                    ColorResources
                                                                        .GREEN,
                                                                    fontSize:
                                                                    18)),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    ));
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/call.png',
                                                    color: ColorResources.PRIMARY_COLOR,
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(
                                                      "Call",
                                                      style: Style.bottomHeading)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1.5,
                                              height: 30,
                                              color: Colors.grey,
                                            ),

                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                    new CupertinoAlertDialog(
                                                      title: CustomText(
                                                          'Are you sure want to deleted your post?',
                                                          style: Style.heading),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: CustomText(
                                                              getTranslated(
                                                                  'yes', context)!,
                                                              style: Style.okButton),
                                                          onPressed: () {
                                                            model
                                                                .deletePoolPurchase(model.orgPoolPurchaseList[index])
                                                                .then((value) => {
                                                              showAnimatedDialog(
                                                                  context,
                                                                  MyDialog(
                                                                    icon: Icons
                                                                        .check,
                                                                    title:
                                                                    'Post Delete',
                                                                    description:
                                                                    'Your post deleted successfully',
                                                                    isFailed:
                                                                    false,
                                                                  ),
                                                                  dismissible:
                                                                  false,
                                                                  isFlip: false)
                                                            });
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: CustomText(
                                                            getTranslated(
                                                                'no', context)!,
                                                            style: Style.cancelButton,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    ));
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    color: ColorResources.PRIMARY_COLOR,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(getTranslated('delete', context)!,
                                                      style: Style.bottomHeading)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          //  physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                        ),
                      )),
                  getLoader(model.isLoading)
                ],
              ),
            ),
      ),
    );
  }

  Set<int>? selectedValues = [1, 2, 3, 4, 5, 6, 7].toSet();

  void _showMultiSelectMenu(BuildContext context) async {
    final items = <MultiSelectMenu<int>>[
      MultiSelectMenu(1, getTranslated('all_requirements', context)!),
      MultiSelectMenu(2, getTranslated('vehicles', context)!),
      MultiSelectMenu(3, getTranslated('Tyres', context)!),
      MultiSelectMenu(4, getTranslated('body_building', context)!),
      MultiSelectMenu(5, getTranslated('finance', context)!),
      MultiSelectMenu(6, getTranslated('insurance', context)!),
      MultiSelectMenu(7, getTranslated('other', context)!),
    ];

    selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectMenuDialog(
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
    if (count == 7)
      return message;
    else
      return '${count} ' + getTranslated('requirements_selected', context)!;
  }

  var selectedTab = 'All Requirement';
  getCircularContainer(String title, bool isSelected) {
    return Consumer<OrgProvider>(
        builder: (context, model, child) =>InkWell(
          onTap: (){
            setState(() {
              selectedTab = title;
              model.getFilterPoolPurchaseList(title);
            });
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 5),
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
        ));
  }
}

