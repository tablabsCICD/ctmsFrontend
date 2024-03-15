import 'dart:convert';
import 'dart:ui';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization_portal/company/all_bids.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/bid_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/multi_select.dart';
import 'package:flutter_hr_management/organization_portal/open_whatsapp.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';

import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
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


class CompanyBidsScreen extends StatefulWidget {
  final bidProvider = locator<OrgProvider>();


  Organization organization;
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
                      Expanded(child: BidList(widget.organization)),
                    ],
                  ),
                ),
              ],
            ),
           /*if (ResponsiveWidget.isDesktop(context)) Positioned(
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
            ) else SizedBox.shrink(),*/
          ],
        ));
  }
}

/*class WebScreenForBid extends StatefulWidget {
  @override
  _WebScreenForBidState createState() => _WebScreenForBidState();
}

class _WebScreenForBidState extends State<WebScreenForBid> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<OrgProvider>(
        builder: (context, model, child) => Container(
          margin: EdgeInsets.symmetric(
              horizontal: 35,vertical: 10
          ),
          child: model.orgBigingList.isEmpty && model.isLoading == false
              ? Expanded(
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height - 200,
                  child: Center(child: Text(getTranslated('no_post', context)!,style: Style.heading,))))
              :Column(
            children: [
             *//* Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: ResponsiveWidget.isDesktop(context)
                      ? 3
                      : ResponsiveWidget.isMobile(context)
                      ? 1
                      : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: model.orgBigingList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (builder)=> RequirementDetails(widget.loadTypeList[index])));
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
                                        color: model.orgBigingList[index].mainTag ==
                                            "Full load required"
                                            ? ColorResources
                                            .FULL_LOAD_REQUIRED
                                            : model.orgBigingList[index].mainTag ==
                                            "Part load required"
                                            ? ColorResources
                                            .PART_LOAD_REQUIRED
                                            : model.orgBigingList[index].mainTag ==
                                            "Full load available"
                                            ? ColorResources
                                            .FULL_LOAD_AVAILABLE
                                            : ColorResources
                                            .PART_LOAD_AVAILABLE,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomRight:
                                            Radius.circular(10))),
                                    child: CustomText(model.orgBigingList[index].mainTag.toString(),
                                        style: TextStyle(fontSize: 12,fontFamily: 'RobotoMedium',color: model
                                            .orgBigingList[
                                        index]
                                            .mainTag ==
                                            "Full load required"
                                            ? ColorResources
                                            .FLR_TEXT
                                            : model
                                            .orgBigingList[
                                        index]
                                            .mainTag ==
                                            "Part load required"
                                            ? ColorResources
                                            .PLR_TEXT
                                            : model
                                            .orgBigingList[
                                        index]
                                            .mainTag ==
                                            "Full load available"
                                            ? ColorResources
                                            .FLA_TEXT
                                            : ColorResources
                                            .PLA_TEXT)),
                                  ),
                                  *//**//*Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8.0),
                                              child: ConvertStringToDate(
                                                  model.truckLoadTypeList[index].postingTime.toString()),
                                            ),*//**//*
                                ],
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                horizontalTitleGap: 5,
                                minVerticalPadding: 0,
                                leading: getImage(''),
                                // model.truckLoadTypeList[index].companyLogo.toString()),
                                title: CustomText(model.orgBigingList[index].nameOfPerson.toString() == ''?
                                model.orgBigingList[index].type.toString():model.orgBigingList[index].nameOfPerson.toString(),
                                    style: titleTextStyle),
                                subtitle: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomText(model.orgBigingList[index].mobileNumber.toString(),
                                        style: subTitleTextStyle),
                                    StarDisplay(
                                        value:
                                        model.orgBigingList[index].ratings!.toInt()),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 10),
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
                                      model.orgBigingList[index].source.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontFamily: 'RobotoSlab',
                                          fontWeight: FontWeight.bold),
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
                                      model.orgBigingList[index].destination.toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontFamily: 'RobotoSlab',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 7),
                                child: CustomText(
                                    model.orgBigingList[index].topicName.toString(),
                                    style: titilliumSemiBold),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 7),
                                child: Row(
                                  children: [
                                    CustomText('Your Bid : ',
                                        style: TextStyle(
                                            color: ColorResources
                                                .PRIMARY_COLOR,
                                            fontWeight: FontWeight.bold)),
                                    CustomText(
                                        model.orgBigingList[index].amount
                                            .toString(),
                                        style: TextStyle(
                                            color: ColorResources
                                                .PRIMARY_COLOR,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 10, right: 10),
                                child: CustomText(
                                  model.orgBigingList[index].description
                                      .toString(),
                                  style: regularTextStyle,
                                ),
                              ),
                              Divider(
                                height: 1.5,
                                thickness: 1.5,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                        new CupertinoAlertDialog(
                                          title: CustomText(
                                              'Are you sure want to deleted your job?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                  getTranslated(
                                                      'yes',
                                                      context)!,
                                                  style: TextStyle(
                                                      color:
                                                      ColorResources
                                                          .RED)),
                                              onPressed: () {
                                                model
                                                    .deleteBid(model
                                                    .orgBigingList[
                                                index])
                                                    .then(
                                                        (value) => {
                                                      showAnimatedDialog(
                                                          context,
                                                          MyDialog(
                                                            icon: Icons.check,
                                                            title: 'Bid Delete',
                                                            description: 'Your bid deleted successfully',
                                                            isFailed: false,
                                                          ),
                                                          dismissible: false,
                                                          isFlip: false)
                                                    });
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                getTranslated(
                                                    'no', context)!,
                                                style: TextStyle(
                                                    color:
                                                    ColorResources
                                                        .GREEN),
                                              ),
                                              onPressed: () {
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                            ),
                                          ],
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[200],
                                    foregroundColor: Colors.white,
                                    elevation: 3,
                                  ),
                                  child: Text(getTranslated('delete', context)!,style: Style.button,),
                                ),
                              ),
                              *//**//*Center(
                                          child: CustomButton(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        new CupertinoAlertDialog(
                                                          title: Text(
                                                              'Are you sure want to deleted your job?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                  getTranslated(
                                                                      'yes',
                                                                      context)!,
                                                                  style: TextStyle(
                                                                      color:
                                                                          ColorResources
                                                                              .RED)),
                                                              onPressed: () {
                                                                model
                                                                    .deleteBid(model
                                                                            .allBidingList[
                                                                        index])
                                                                    .then(
                                                                        (value) => {
                                                                              showAnimatedDialog(
                                                                                  context,
                                                                                  MyDialog(
                                                                                    icon: Icons.check,
                                                                                    title: 'Bid Delete',
                                                                                    description: 'Your bid deleted successfully',
                                                                                    isFailed: false,
                                                                                  ),
                                                                                  dismissible: false,
                                                                                  isFlip: false)
                                                                            });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                getTranslated(
                                                                    'no', context)!,
                                                                style: TextStyle(
                                                                    color:
                                                                        ColorResources
                                                                            .GREEN),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                              },
                                              buttonText: getTranslated(
                                                  'delete', context)!),
                                        )*//**//*
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.fit(1),
                )*//*

            ],
          ),
        )
    );
  }
}*/
