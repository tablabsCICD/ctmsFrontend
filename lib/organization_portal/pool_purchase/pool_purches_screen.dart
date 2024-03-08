import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization_portal/pool_purchase/multi_select_menu.dart';
import 'package:flutter_hr_management/organization_portal/pool_purchase/pool_purchase_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hr_management/organization_portal/open_whatsapp.dart';
import 'package:flutter_hr_management/organization_portal/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization_portal/share_data.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:universal_html/html.dart' as html;

class PoolPurchesScreen extends StatefulWidget {
  final poolPurchaseProvider = locator<PoolPurchaseProvider>();

  PoolPurchesScreen({Key? key}) : super(key: key) {
    poolPurchaseProvider.getCard();
  }

  @override
  _PoolPurchesScreenState createState() => _PoolPurchesScreenState();
}

class _PoolPurchesScreenState extends State<PoolPurchesScreen> {
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
  final poolPurchaseProvider = locator<PoolPurchaseProvider>();
  int selectedPageNumber = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        poolPurchaseProvider.getCard(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      body: Consumer<PoolPurchaseProvider>(
        builder: (context, model, child) =>
            Container(
         // padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: ColorResources.HOME_APPBAR,
                child: Padding(
                  padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35,vertical: 15):EdgeInsets.symmetric(horizontal: 0,vertical: 15),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
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
              model.poolPurchaseList.isEmpty && model.isLoading == false

                  ? Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                      margin: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
                      child: Center(child: Text(getTranslated('no_post', context)!,style: Style.heading,))))
                  : model.poolPurchaseList.isEmpty && model.isLoading ? SizedBox(height: MediaQuery.of(context).size.height/2.5,)
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
                        itemCount: model.poolPurchaseList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          PoolPurchaseDetailsScreen(model.poolPurchaseList[index])));
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
                                          model.poolPurchaseList[index].purchaseItem
                                              .toString(),
                                          style: Style.title),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, bottom: 10, right: 10),
                                      child: CustomText(
                                        model.poolPurchaseList[index].description
                                            .toString(),
                                        style: Style.subtitle,
                                      ),
                                    ),
                                    Divider(
                                      height: 1.5,
                                      thickness: 1.5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              var shareData = {
                                                "title": model
                                                    .poolPurchaseList[index]
                                                    .agentName,
                                                "text": model
                                                    .poolPurchaseList[index]
                                                    .mobileNumber,
                                                "url": 'link',
                                              };
                                              try {
                                                await html.window.navigator
                                                    .share(shareData);
                                              } catch (e) {
                                                print(e);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/share.png',
                                                  color: ColorResources.PRIMARY_COLOR,
                                                  height: 14,
                                                  width: 14,
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
                                          ),
                                          InkWell(
                                            onTap: () {
                                              openwhatsapp(
                                                  context,
                                                  model.poolPurchaseList[index]
                                                      .mobileNumber
                                                      .toString(),
                                                  'Type : ${model.poolPurchaseList[index].type}, \nPurchase Item : ${model.poolPurchaseList[index].purchaseItem}, \nSubject : ${model.poolPurchaseList[index].description}');
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/chat.png',
                                                  color: ColorResources.PRIMARY_COLOR,
                                                  height: 14,
                                                  width: 14,
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
                                                            'Contact Number : ${model.poolPurchaseList[index].mobileNumber}',
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
                                                              child: Text(
                                                                  getTranslated(
                                                                      'ok',
                                                                      context)!,
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
                                                  height: 14,
                                                  width: 14,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                CustomText(
                                                    "Call",
                                                    style: Style.bottomHeading)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
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
    return Consumer<PoolPurchaseProvider>(
        builder: (context, model, child) =>InkWell(
      onTap: (){
        setState(() {
          selectedTab = title;
          model.vehicles = false;
          model.tyres = false;
          model.other = false;
          model.finance = false;
          model.insurance = false;
          model.body_building = false;
          if(selectedTab == 'Vehicles'){
            model.vehicles = true;
          }
          if(selectedTab == 'Tyres'){
            model.tyres = true;
          }
          if(selectedTab == 'Other'){
            model.other = true;
          }
          if(selectedTab == 'Body Building'){
            model.body_building = true;
          }
          if(selectedTab == 'Finance'){
            model.finance = true;
          }
          if(selectedTab == 'Insurance'){
            model.insurance = true;
          }
        });
        model.getFilteredData();
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

