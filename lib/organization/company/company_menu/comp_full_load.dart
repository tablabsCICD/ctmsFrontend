import 'dart:convert';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
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

class LoadScreen extends StatefulWidget {
  final dashboardProvider = locator<OrgProvider>();
  final buySellProvider = locator<OrgProvider>();
  Organization organization;
  LoadScreen(this.organization,{Key? key}) : super(key: key) {
    dashboardProvider.getOrgFullLoadList(organization.id!);
  }


  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: ColorResources.HOME_BG,
          child: ResponsiveWidget(
            desktop: CompLoadScreen(widget.organization),
            mobile: CompLoadScreen(widget.organization),
            tablet: CompLoadScreen(widget.organization),
          )),
    );
  }
}

class CompLoadScreen extends StatefulWidget {
  final dashboardProvider = locator<OrgProvider>();
  Organization organization;
  final orgProvider = locator<OrgProvider>();
  CompLoadScreen(this.organization,{Key? key}) : super(key: key) {
    dashboardProvider.getOrgFullLoadList(organization.id!);
  }



  @override
  _CompLoadScreenState createState() => _CompLoadScreenState();
}

class _CompLoadScreenState extends State<CompLoadScreen> {
  final bidProvider = locator<BidProvider>();
  final authProvider = locator<AuthProvider>();
  TextEditingController bidAmtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController filterController = TextEditingController();
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
                HeaderWidget(),
                Expanded(child: LoadList(widget.organization,index: 1,)),
               /* Container(
                    child: Column(
                        children: [
                          Container(
                            height: 60,
                            color: ColorResources.HOME_APPBAR,
                            child: Padding(
                              padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35,vertical: 10):EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
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
                                    width: ResponsiveWidget.isDesktop(context)
                                        ? 350
                                        : screenSize.width / 3.5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          _showMultiSelect(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSearchCityTextField(
                                              hintText: 'From',
                                              controller: selectedFromCity!,
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => GetCityList()))
                                                    .then((value) {
                                                  if (value.toString().isNotEmpty && value != null) {
                                                    selectedFromCity = value[0];
                                                    setState(() {});

                                                  }
                                                });
                                              },
                                            ),
                                            Container(
                                              height: 40,
                                              width: 0.2,
                                              color: Colors.grey[200],
                                            ),
                                            CustomSearchCityTextField(
                                              hintText: 'To',
                                              controller: selectedToCity!,
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => GetCityList()))
                                                    .then((value) {
                                                  if (value.toString().isNotEmpty && value != null) {
                                                    selectedToCity = value[0];
                                                    setState(() {});

                                                  }
                                                });
                                              },
                                            ),
                                            ElevatedButton(
                                              onPressed: (){
                                                model.getSearchByNameList(
                                                    '',
                                                    selectedFromCity!,
                                                    selectedToCity!);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black,
                                                onPrimary: Colors.white,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                                child: CustomText("Search",
                                                    style: Style.button),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //model.isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
                                  Row(
                                    children: [
                                      getCircularContainer("All Loads",(selectedTab == "All Loads"),0),
                                      getCircularContainer("Full Load Required",(selectedTab == "Full Load Required"),1),
                                      getCircularContainer("Full Load Available",(selectedTab == "Full Load Available"),2),
                                      getCircularContainer("Part Load Required",(selectedTab == "Part Load Required"),3),
                                      getCircularContainer("Part Load Available",(selectedTab == "Part Load Available"),4),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          model.orgFullLoadList.isEmpty && model.isLoading == false
                              ? Expanded(
                              child: Container(
                                  height: MediaQuery.of(context).size.height - 200,
                                  child: Center(child: Text(getTranslated('no_post', context)!,style: Style.heading,))))
                              :Expanded(
                            child: Padding(
                              padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35):EdgeInsets.symmetric(horizontal: 10),
                              child: StaggeredGridView.countBuilder(
                                  controller: _scrollController,
                                  physics: ScrollPhysics(),
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.fit(1),
                                  shrinkWrap: true,
                                  crossAxisCount: ResponsiveWidget.isDesktop(context)
                                      ? 3
                                      : ResponsiveWidget.isMobile(context)
                                      ? 1
                                      : 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                  itemCount: model.orgFullLoadList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          *//* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            RequirementDetails(model
                                                .truckLoadTypeList[index])));*//*
                                        },
                                        child: Card(
                                          // elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 0),
                                                    blurRadius: 5,
                                                    color: Color(0xffede8e0),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 140,
                                                      height: 20,
                                                      alignment: Alignment.center,
                                                      decoration: new BoxDecoration(
                                                          color: model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Full load required"
                                                              ? ColorResources
                                                              .FULL_LOAD_REQUIRED
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Part load required"
                                                              ? ColorResources
                                                              .PART_LOAD_REQUIRED
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Full load available"
                                                              ? ColorResources
                                                              .FULL_LOAD_AVAILABLE
                                                              : ColorResources
                                                              .PART_LOAD_AVAILABLE,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft:
                                                              Radius.circular(10),
                                                              bottomRight:
                                                              Radius.circular(15))),
                                                      child: CustomText(model.orgFullLoadList[index].mainTag.toString(),
                                                          style: TextStyle(fontSize: 12,fontFamily: 'RobotoMedium',color: model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Full load required"
                                                              ? ColorResources
                                                              .FLR_TEXT
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Part load required"
                                                              ? ColorResources
                                                              .PLR_TEXT
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .mainTag ==
                                                              "Full load available"
                                                              ? ColorResources
                                                              .FLA_TEXT
                                                              : ColorResources
                                                              .PLA_TEXT)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          ConvertStringToDate(model
                                                              .orgFullLoadList[index]
                                                              .postingTime
                                                              .toString()),
                                                          StarDisplay(
                                                              value: model
                                                                  .orgFullLoadList[
                                                              index]
                                                                  .ratings!
                                                                  .toInt()),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ListTile(
                                                  contentPadding: EdgeInsets.symmetric(
                                                      vertical: 0, horizontal: 5),
                                                  horizontalTitleGap: 5,
                                                  minVerticalPadding: 0,
                                                  leading: Stack(
                                                    children: [
                                                      getImage(model
                                                          .orgFullLoadList[index]
                                                          .companyLogo
                                                          .toString()),
                                                      Positioned(
                                                        bottom: -7,
                                                        right: -5,
                                                        child: Image.asset(
                                                          model.orgFullLoadList[index]
                                                              .isPaid ==
                                                              30
                                                              ? 'assets/images/diamond.png'
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .isPaid ==
                                                              20
                                                              ? 'assets/images/gold_badge.png'
                                                              : model
                                                              .orgFullLoadList[
                                                          index]
                                                              .isPaid ==
                                                              0
                                                              ? 'assets/images/silver.png'
                                                              : 'assets/images/ruby_badge.png',
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      CustomText(
                                                          model.orgFullLoadList[index]
                                                              .nameOfPerson
                                                              .toString(),
                                                          style: Style.title),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      model.orgFullLoadList[index]
                                                          .isVerifiedByCompany ==
                                                          null
                                                          ? SizedBox.shrink()
                                                          : Image.asset(
                                                        'assets/images/membership.png',
                                                        width: 13,
                                                        height: 13,
                                                      )
                                                    ],
                                                  ),
                                                  subtitle: CustomText(
                                                      model.orgFullLoadList[index]
                                                          .companyName
                                                          .toString(),
                                                      style: Style.subtitle),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 45),
                                                  height: 30,
                                                  decoration: new BoxDecoration(
                                                      color: Color(0xfff0f0f0),
                                                      borderRadius:
                                                      BorderRadius.circular(5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      CustomText(
                                                        model.orgFullLoadList[index]
                                                            .source
                                                            .toString(),
                                                        style: Style.cityHeading,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      // CustomText("to", style: Style.content),
                                                      Image.asset(
                                                        'assets/images/right-arrow.png',
                                                        height: 15,
                                                        width: 25,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      CustomText(
                                                        model.orgFullLoadList[index]
                                                            .destination
                                                            .toString(),
                                                        style: Style.cityHeading,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10.0, vertical: 7),
                                                  child: CustomText(
                                                      model.orgFullLoadList[index]
                                                          .topicName
                                                          .toString(),
                                                      style: Style.title),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10.0, bottom: 10, right: 10),
                                                  child: CustomText(
                                                    model.orgFullLoadList[index].content
                                                        .toString(),
                                                    style: Style.content,
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.5,
                                                  thickness: 1.5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 9),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          openwhatsapp(
                                                              context,
                                                              model
                                                                  .orgFullLoadList[
                                                              index]
                                                                  .mobileNumber
                                                                  .toString(),
                                                              'Type : ${model.orgFullLoadList[index].type}, \nSubject : ${model.orgFullLoadList[index].content}, \nSource : ${model.orgFullLoadList[index].source}, \nDestination : ${model.orgFullLoadList[index].destination}'
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/chat.png',
                                                              color: ColorResources
                                                                  .PRIMARY_COLOR,
                                                              height: 15,
                                                              width: 15,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              getTranslated("chat", context)!,
                                                              style:
                                                              Style.bottomHeading,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 1.5,
                                                        height: 30,
                                                        color: Colors.grey,
                                                      ),
                                                      *//* InkWell(
                                              onTap: () async {
                                                *//**//*share_data(
                                                      model.truckLoadTypeList[index]);*//**//*
                                               *//**//* showDialog(context: context,
                                                    builder: (BuildContext context){
                                                      return ShareDialogBox(
                                                          model.orgFullLoadList[index]
                                                      );
                                                    }
                                                );*//**//*

                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/share.png',
                                                    color: ColorResources
                                                        .PRIMARY_COLOR,
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getTranslated("share", context)!,
                                                    style:
                                                    Style.bottomHeading,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 1.5,
                                              height: 30,
                                              color: Colors.grey,
                                            ),*//*
                                                      InkWell(
                                                        onTap: () async {
                                                          //share_data(widget.loadTypeList[index]);
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                              new CupertinoAlertDialog(
                                                                title: CustomText(
                                                                  'Are you sure want to deleted your post?',
                                                                  style: Style.heading,
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        getTranslated(
                                                                            'yes', context)!,
                                                                        style: Style.okButton),
                                                                    onPressed: () {
                                                                      model
                                                                          .deleteFullLoad(
                                                                          model.orgFullLoadList[
                                                                          index])
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
                                                                    child: Text(
                                                                        getTranslated(
                                                                            'no', context)!,
                                                                        style:
                                                                        Style.cancelButton),
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              ));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color: ColorResources.PRIMARY_COLOR,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: ResponsiveWidget.isDesktop(context)? 10 : 5,
                                                            ),
                                                            CustomText(
                                                              "Delete",
                                                              style: Style.bottomHeading,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  }),
                            ),
                          ),
                          getLoader(model.isLoading)
                        ])),*/
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
