

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
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
                        Container(
                          height: 60,
                          color: Color(0xffede8e0),
                          child: Padding(
                            padding: ResponsiveWidget.isDesktop(context)?EdgeInsets.symmetric(horizontal: 35,vertical: 10):EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              children: [
                                getCircularContainer("All Users",(selectedTab == "All Users"),0),
                                getCircularContainer("Approved",(selectedTab == "Approved"),1),
                                getCircularContainer("Rejected",(selectedTab == "Rejected"),2),
                                //  getCircularContainer("Pending",(selectedTab == "Pending"),3),
                              ],
                            ),
                          ),
                        ),
                        model.userList.isEmpty && model.isLoading == false
                            ? Expanded(
                            child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height - 200,
                                child: Center(child: Text(
                                  "No Record Found", style: Style.heading,))))
                            : Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: StaggeredGridView.countBuilder(
                              physics: ScrollPhysics(),
                              crossAxisCount: ResponsiveWidget.isDesktop(context)
                                  ? 3
                                  : ResponsiveWidget.isMobile(context)
                                  ? 1
                                  : 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                              itemCount: model.userList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              model.userList[index].isPaid != null
                                                  ?Container(
                                                width: 140,
                                                height: 20,
                                                alignment: Alignment.center,
                                                decoration: new BoxDecoration(
                                                    color: Color(0xff6ea106),
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(10),
                                                        bottomRight:
                                                        Radius.circular(15))),
                                                child: CustomText('Verified'
                                                  ,
                                                  style:Style.sponsered,),

                                              ):SizedBox.shrink(),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                                                child: StarDisplay(
                                                    value:model.userList[index].ratings!
                                                        .toInt()),
                                              ),

                                            ],),
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: ListTile(
                                              minLeadingWidth: 0,
                                              title: Row(
                                                children: [
                                                  Text(
                                                      "${model.userList[index]
                                                          .firstName} ${model
                                                          .userList[index].lastName}",
                                                      style: Style.title),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  model.userList[index].verified ==
                                                      1
                                                      ? Tooltip(
                                                    message: "This user is verified by TKDost team",
                                                    child: Image.asset(
                                                      'assets/images/membership.png',
                                                      width: 15,
                                                      height: 15,
                                                    ),
                                                  )
                                                      : SizedBox.shrink()
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    "${model.userList[index]
                                                        .mobileNumber}",
                                                    style: Style.subtitle,),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  model.userList[index].isUserVerifiedByCompany ==
                                                      1
                                                      ? Tooltip(
                                                    message: "This user is verified by '${model.userList[index].companyName}'",
                                                    child: Image.asset(
                                                      'assets/images/shield.png',
                                                      width: 15,
                                                      height: 15,
                                                    ),
                                                  )
                                                      : SizedBox.shrink()
                                                ],
                                              ),
                                              leading: Stack(
                                                children: [
                                                  getImage(model.userList[index]
                                                      .profilePicture.toString()),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: Image.asset(
                                                      model.userList[index].isPaid ==
                                                          30
                                                          ? 'assets/images/diamond.png'
                                                          : model.userList[index]
                                                          .isPaid ==
                                                          20
                                                          ? 'assets/images/gold_badge.png'
                                                          : 'assets/images/ruby_badge.png',
                                                      width: 15,
                                                      height: 20,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              /*trailing: Container(
                                          width: 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            children: [
                                              StarDisplay(
                                                  value: model.userList[index]
                                                      .ratings!
                                                      .toInt()),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              ElevatedButton(
                                                child: Text(
                                                  model.userList[index]
                                                      .isPaid !=
                                                      null
                                                      ? 'Sponsered'
                                                      : 'Not Sponsered',
                                                  style: Style.sponsered,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  onPrimary: Colors.white,
                                                  side: BorderSide(
                                                      color: Colors.lightGreen,
                                                      width: 2),
                                                ),
                                                onPressed: () {
                                                  print('Pressed');
                                                },
                                              )
                                            ],
                                          ),
                                        ),*/
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                              'Email Id : ${model.userList[index]
                                                  .emailId}',
                                              style: Style.vehicleData,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Address : ${model.userList[index]
                                                    .city}, ${model.userList[index]
                                                    .state}',
                                                style: Style.vehicleData
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Company Name : ${model
                                                    .userList[index].companyName}',
                                                style: Style.vehicleData
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Company Address : ${model
                                                    .userList[index].companyAddress}',
                                                style: Style.vehicleData
                                            ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment: model
                                                    .userList[index]
                                                    .isUserVerifiedByCompany == 1 ?
                                                MainAxisAlignment.end :
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  model.userList[index]
                                                      .isUserVerifiedByCompany == 0
                                                      ? ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(context: context,
                                                          builder: (_) =>
                                                          new CupertinoAlertDialog(
                                                            title: Text(
                                                              'Are you sure want to verify this user?',
                                                              style: Style.heading,),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Yes',
                                                                    style: Style
                                                                        .okButton),
                                                                onPressed: () {
                                                                  authProvider
                                                                      .updateUser(
                                                                      aadharCard: model
                                                                          .userList[index]
                                                                          .aadharCard,
                                                                      alternativeNumber: model
                                                                          .userList[index]
                                                                          .alternativeNumber,
                                                                      city: model
                                                                          .userList[index]
                                                                          .city,
                                                                      companyAddress: model
                                                                          .userList[index]
                                                                          .companyAddress,
                                                                      companyId: model
                                                                          .userList[index]
                                                                          .companyId,
                                                                      companyLogo: model
                                                                          .userList[index]
                                                                          .companyLogo,
                                                                      companyName: model
                                                                          .userList[index]
                                                                          .companyName,
                                                                      country: model
                                                                          .userList[index]
                                                                          .country,
                                                                      deviceId: '',
                                                                      emailId: model
                                                                          .userList[index]
                                                                          .emailId,
                                                                      firstName: model
                                                                          .userList[index]
                                                                          .firstName,
                                                                      id: model
                                                                          .userList[index]
                                                                          .id,
                                                                      idOfMainBranch: model
                                                                          .userList[index]
                                                                          .idOfMainBranch,
                                                                      isPaid: model
                                                                          .userList[index]
                                                                          .isPaid,
                                                                      isUserVerifiedByCompany: 1,
                                                                      landlineNumber: model
                                                                          .userList[index]
                                                                          .landlineNumber,
                                                                      lastName: model
                                                                          .userList[index]
                                                                          .lastName,
                                                                      loggedTime: '',
                                                                      loggedUserName: model
                                                                          .userList[index]
                                                                          .loggedUserName,
                                                                      mainBranch: model
                                                                          .userList[index]
                                                                          .mainBranch,
                                                                      mobileNumber: model
                                                                          .userList[index]
                                                                          .mobileNumber,
                                                                      numberOfTimesRating: model
                                                                          .userList[index]
                                                                          .numberOfTimesRating,
                                                                      os: '',
                                                                      otp: '',
                                                                      paidStartDate: model
                                                                          .userList[index]
                                                                          .paidStartDate,
                                                                      password: model
                                                                          .userList[index]
                                                                          .password,
                                                                      preferredRouresEntered: model
                                                                          .userList[index]
                                                                          .preferredRouresEntered,
                                                                      profilePicture: model
                                                                          .userList[index]
                                                                          .profilePicture,
                                                                      rating: model
                                                                          .userList[index]
                                                                          .ratings,
                                                                      transporterOrAgent: model
                                                                          .userList[index]
                                                                          .transporterOrAgent,
                                                                      verified: model
                                                                          .userList[index]
                                                                          .verified,
                                                                      state: model
                                                                          .userList[index]
                                                                          .state,
                                                                      userName: model
                                                                          .userList[index]
                                                                          .userName,
                                                                      validTill: '',
                                                                      website: model
                                                                          .userList[index]
                                                                          .website)
                                                                      .then((value) =>
                                                                  {
                                                                    showAnimatedDialog(
                                                                        context,
                                                                        MyDialog(
                                                                          icon: Icons
                                                                              .check,
                                                                          title: 'User Verification',
                                                                          description: 'User verified by company successfully',
                                                                          isFailed: false,
                                                                        ),
                                                                        dismissible: false,
                                                                        isFlip: true)
                                                                  });
                                                                  Navigator.of(
                                                                      context).pop();
                                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>AllUsers(widget.organization)));
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text('no',
                                                                    style: Style
                                                                        .cancelButton),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.green[100],
                                                      onPrimary: Colors.white,
                                                      elevation: 3,
                                                      shape: const BeveledRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(5))),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      child: Text('Verify User',
                                                          style: Style.okButton),
                                                    ),
                                                  )
                                                  // : SizedBox.shrink(),
                                                      :ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(context: context,
                                                          builder: (_) =>
                                                          new CupertinoAlertDialog(
                                                            title: Text(
                                                              'Are you sure want to reject this user?',
                                                              style: Style.heading,),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                    'Yes',
                                                                    style: Style
                                                                        .okButton),
                                                                onPressed: () {
                                                                  authProvider
                                                                      .updateUser(
                                                                      aadharCard: model
                                                                          .userList[index]
                                                                          .aadharCard,
                                                                      alternativeNumber: model
                                                                          .userList[index]
                                                                          .alternativeNumber,
                                                                      city: model
                                                                          .userList[index]
                                                                          .city,
                                                                      companyAddress: model
                                                                          .userList[index]
                                                                          .companyAddress,
                                                                      companyId: model
                                                                          .userList[index]
                                                                          .companyId,
                                                                      companyLogo: model
                                                                          .userList[index]
                                                                          .companyLogo,
                                                                      companyName: model
                                                                          .userList[index]
                                                                          .companyName,
                                                                      country: model
                                                                          .userList[index]
                                                                          .country,
                                                                      deviceId: '',
                                                                      emailId: model
                                                                          .userList[index]
                                                                          .emailId,
                                                                      firstName: model
                                                                          .userList[index]
                                                                          .firstName,
                                                                      id: model
                                                                          .userList[index]
                                                                          .id,
                                                                      idOfMainBranch: model
                                                                          .userList[index]
                                                                          .idOfMainBranch,
                                                                      isPaid: model
                                                                          .userList[index]
                                                                          .isPaid,
                                                                      isUserVerifiedByCompany: 0,
                                                                      landlineNumber: model
                                                                          .userList[index]
                                                                          .landlineNumber,
                                                                      lastName: model
                                                                          .userList[index]
                                                                          .lastName,
                                                                      loggedTime: '',
                                                                      loggedUserName: model
                                                                          .userList[index]
                                                                          .loggedUserName,
                                                                      mainBranch: model
                                                                          .userList[index]
                                                                          .mainBranch,
                                                                      mobileNumber: model
                                                                          .userList[index]
                                                                          .mobileNumber,
                                                                      numberOfTimesRating: model
                                                                          .userList[index]
                                                                          .numberOfTimesRating,
                                                                      os: '',
                                                                      otp: '',
                                                                      paidStartDate: model
                                                                          .userList[index]
                                                                          .paidStartDate,
                                                                      password: model
                                                                          .userList[index]
                                                                          .password,
                                                                      preferredRouresEntered: model
                                                                          .userList[index]
                                                                          .preferredRouresEntered,
                                                                      profilePicture: model
                                                                          .userList[index]
                                                                          .profilePicture,
                                                                      rating: model
                                                                          .userList[index]
                                                                          .ratings,
                                                                      transporterOrAgent: model
                                                                          .userList[index]
                                                                          .transporterOrAgent,
                                                                      verified: model
                                                                          .userList[index]
                                                                          .verified,
                                                                      state: model
                                                                          .userList[index]
                                                                          .state,
                                                                      userName: model
                                                                          .userList[index]
                                                                          .userName,
                                                                      validTill: '',
                                                                      website: model
                                                                          .userList[index]
                                                                          .website)
                                                                      .then((value) =>
                                                                  {
                                                                    showAnimatedDialog(
                                                                        context,
                                                                        MyDialog(
                                                                          icon: Icons
                                                                              .check,
                                                                          title: 'User Rejection',
                                                                          description: 'User rejected by company successfully',
                                                                          isFailed: false,
                                                                        ),
                                                                        dismissible: false,
                                                                        isFlip: true)
                                                                  });
                                                                  Navigator.of(
                                                                      context).pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text('no',
                                                                    style: Style
                                                                        .cancelButton),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          ));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.red[100],
                                                      onPrimary: Colors.white,
                                                      elevation: 3,
                                                      // side: BorderSide(color: Colors.black, width: 2),
                                                      shape: const BeveledRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(5))),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      child: Text('Reject',
                                                          style: Style.cancelButton),
                                                    ),
                                                  )

                                                ],
                                              )),
                                        ],
                                      )),
                                );
                              },
                              shrinkWrap: true,
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                            ),
                          ),
                        ),
                        getLoader(model.isLoading)

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