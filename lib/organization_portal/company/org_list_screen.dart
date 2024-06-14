import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/ctms_organization.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/company/createt_ctms_organization.dart';
import 'package:flutter_hr_management/organization_portal/company/org_edit_screen.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/Create_Org_Provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CtmsOrgListScreen extends StatefulWidget {

  @override
  _CtmsOrgListScreenState createState() => _CtmsOrgListScreenState();
}

class _CtmsOrgListScreenState extends State<CtmsOrgListScreen> {

  int counter = 0;
  var selectedPageNumber = 1;
  final createOrgProvider = locator<CreateOrgProvider>();
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    getLoginDetails();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        createOrgProvider.getOrganizationList(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<CreateOrgProvider>(
      builder: (context, model, child) => Container(
          margin: EdgeInsets.symmetric(horizontal: 35,),
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    filterIcon(model),
                    SizedBox(
                      width: 27.w,
                    ),
                    SizedBox(
                      height: 58.h,
                      width: 200.w,
                      child: ElevatedButton(
                          onPressed: () {
                            _showAlertDialog();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColor.theme_blue,
                              foregroundColor: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 18,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              TextView(
                                title: "Add Company",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                model.ctmsOrgList.isEmpty
                    ? Expanded(
                    child: Container(height:MediaQuery.of(context).size.height-200,child: Center(child: Text("No Data Found"))))
                    : Expanded(
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
                      itemCount: model.ctmsOrgList.length,
                      itemBuilder: (context, index) {
                        return orgCard(model,index,model.ctmsOrgList[index]);
                      }),
                ),
                model.ctmsOrgList.isEmpty
                    ? SizedBox.shrink()
                    : getLoader(model.isLoading)
              ])),
    );
  }

  filterIcon(CreateOrgProvider model) {
    return Container(
        width: 130.w,
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {},
                itemBuilder: (ctx) => [
                  _buildPopupMenu('Sort By Name A to Z', 0,model),
                  _buildPopupMenu('Sort By Name Z to A', 1,model),
                ],
              ),
              Text(
                "Filter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  PopupMenuItem _buildPopupMenu(
      String title,
      int? id, CreateOrgProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 14.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: () {
        if (id == 0) {
          model.ctmsOrgList.sort(
                  (b, a) => b.orgName!.compareTo(a.orgName!));
          setState(() {});
        } else {
          model.ctmsOrgList.sort(
                  (a, b) => b.orgName!.compareTo(a.orgName!));
          setState(() {});
        }
      },
    );
  }

  Future<void> _showAlertDialog() async {
    return   showDialog(
        context: context,
        builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      insetPadding: ResponsiveWidget.isMobile(context)?EdgeInsets.symmetric(vertical: 50,horizontal: 10):ResponsiveWidget.isTablet(context)?EdgeInsets.symmetric(vertical: 50,horizontal: 50):EdgeInsets.symmetric(vertical: 50,horizontal: 50),
      backgroundColor: Colors.white,
      child: Container(
        width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:ResponsiveWidget.isDesktop(context)?500:400,
        child: Stack(
          children: [
            CreateOrgScreen(),
            Positioned(
              top: 7,
              right: 7,
              child: IconButton(
                icon: Icon(Icons.close,size: 18,),
                onPressed: (){
Navigator.of(context).pop();
},
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _showEditDialog(CtmsOrganization ctmsOrganization) async {
    createOrgProvider.setData(ctmsOrganization);
    return   showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          insetPadding: ResponsiveWidget.isMobile(context)?EdgeInsets.symmetric(vertical: 50,horizontal: 10):ResponsiveWidget.isTablet(context)?EdgeInsets.symmetric(vertical: 50,horizontal: 50):EdgeInsets.symmetric(vertical: 50,horizontal: 50),
          backgroundColor: Colors.white,
          child:  StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return  Container(
              width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:ResponsiveWidget.isDesktop(context)?500:400,
              child: Stack(
                children: [
                  EditOrgScreen(ctmsOrganization),
                  Positioned(
                    top: 7,
                    right: 7,
                    child: IconButton(
                      icon: Icon(Icons.close,size: 18,),
                      onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            );
          })
        ));
  }


  getUserDetails(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      child: Row(
          children: [
            SizedBox(
              width: 120.w,
              child: TextView(
                title: title,
                fontSize:12.sp,
                fontWeight: FontWeight.w300,
                color: Color(0xff000000),
              ),

            ),
            SizedBox(
              width: 50.w,
              child: TextView(
                title: ':',
                fontSize:12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),

            ),
            Expanded(
              child: TextView(
                title: value,
                fontSize:12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000),
              ),
            ),
          ]
      ),
    );
  }

  Organization? organization;
  orgCard(CreateOrgProvider model, int index, CtmsOrganization ctmsOrgList){
    return InkWell(
      onTap: () {},
      child: Card(
          color:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r)
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Row(
                    children: [
                      TextView(
                        title: "${model.ctmsOrgList[index].orgName}",
                        fontSize:15.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                      SizedBox(width: 5.w,),
                      model.ctmsOrgList[index]
                          .isVerified ==
                          1
                          ? Tooltip(
                        message:
                        "This organization is verified'",
                        child: SvgPicture.asset(
                          'assets/org/sheild.svg',
                          width: 5,
                          height: 15,
                        ),
                      )
                          : SizedBox.shrink()
                    ],
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.w, vertical: 10.h),
                    child: StarDisplay(value:int.parse('${/*model.userList[index].ratings.toString()*/5}')),
                  ),
                  leading: getImage(model.ctmsOrgList[index]
                      .logo
                      .toString()),

                ),
                SizedBox(height: 10.h,),
                getUserDetails('Email Id','${model.ctmsOrgList[index].emailId}'),
                getUserDetails('Phone','${model.ctmsOrgList[index].orgMobileNumber}'),
                getUserDetails('Address','${model.ctmsOrgList[index].city}, ${model.ctmsOrgList[index].state}'),
                getUserDetails('Registration Type','${model.ctmsOrgList[index].typeOfRegistration}'),
                getUserDetails('Website','${model.ctmsOrgList[index].website}'),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return ThemeColor
                                    .white; //<-- SEE HERE
                              return ThemeColor
                                  .white; // Defer to the widget's default.
                            },
                          ),
                          backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return ThemeColor.theme_blue; //<-- SEE HERE
                              return ThemeColor
                                  .theme_blue; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Company',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),),
                                content: Text('Are you sure you want to edit this company?',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('No',style: TextStyle(color: ThemeColor.theme_blue, fontSize: 12.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _showEditDialog(model.ctmsOrgList[index]);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.green, fontSize: 12.sp,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.w600,),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Edit',
                          style:TextStyle(
                            fontSize: 12.sp,
                            fontFamily:
                            GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(16.0),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return ThemeColor
                                    .white; //<-- SEE HERE
                              return ThemeColor
                                  .white; // Defer to the widget's default.
                            },
                          ),
                          backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return ThemeColor.red; //<-- SEE HERE
                              return ThemeColor
                                  .red; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () async {
                          organization = await createOrgProvider.getConnectOrganization(ctmsOrgList.connectOrgId!);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Company',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),),
                                content: Text('Are you sure you want to delete this company?',style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('No',style: TextStyle(color: ThemeColor.theme_blue, fontSize: 12.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,),),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await model.deleteCtms(context, model.ctmsOrgList[index]);
                                      await model.deleteTkdOrganization(context, organization!);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.green, fontSize: 12.sp,
                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.w600,),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Delete',
                          style:TextStyle(
                            fontSize: 12.sp,
                            fontFamily:
                            GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
