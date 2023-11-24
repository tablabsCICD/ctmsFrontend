import 'dart:convert';
import 'dart:ui';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization/model/auth_api.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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

class AllUsersList extends StatefulWidget {
  Organization organization;
  final orgProvider = locator<OrgProvider>();

  AllUsersList(this.organization, {Key? key}) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization.id!);
  }

  @override
  _AllUsersListState createState() => _AllUsersListState();
}

class _AllUsersListState extends State<AllUsersList> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();
  String selectedTab = "All Users";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) => Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        child: Padding(
                          padding: ResponsiveWidget.isDesktop(context)
                              ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
                              : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              getCircularContainer(
                                  "All Users", (selectedTab == "All Users"), 0),
                              getCircularContainer(
                                  "Approved", (selectedTab == "Approved"), 1),
                              getCircularContainer(
                                  "Rejected", (selectedTab == "Rejected"), 2),
                              //  getCircularContainer("Pending",(selectedTab == "Pending"),3),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          filterIcon(model),
                          SizedBox(
                            width: 27.w,
                          ),
                          SizedBox(
                            height: 58.h,
                            width: 180.w,
                            child: ElevatedButton(
                                onPressed: () {
                                  _showAlertDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: ThemeColor.theme_blue,
                                    onPrimary: Colors.white),
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
                                      title: "Add Employee",
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
                    ],
                  ),
                  model.userList.isEmpty && model.isLoading == false
                      ? Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              child: Center(
                                  child: Text(
                                "No Record Found",
                                style: Style.heading,
                              ))))
                      : Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 39.w, vertical: 31.h),
                            child: StaggeredGridView.countBuilder(
                              physics: ScrollPhysics(),
                              crossAxisCount:
                                  ResponsiveWidget.isDesktop(context)
                                      ? 2
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: TextView(
                                              title: "${model.userList[index].firstName} ${model.userList[index].lastName}",
                                              fontSize:15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff000000),
                                            ),
                                            subtitle: model.userList[index]
                                                        .isUserVerifiedByCompany ==
                                                    1
                                                ? Tooltip(
                                                    message:
                                                        "This user is verified by '${model.userList[index].companyName}'",
                                                    child: Image.asset(
                                                      'assets/menu_report.png',
                                                      width: 5,
                                                      height: 15,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            /*leading: Stack(
                                              children: [
                                                getImage(model.userList[index]
                                                    .profilePicture
                                                    .toString()),
                                              ],
                                            ),*/
                                            trailing: model.userList[index].isUserVerifiedByCompany==1?Container(
                                              width: 100,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 7.r,
                                                    color: Colors.green,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  TextView(
                                                   title: 'Approved',
                                                    fontSize:12.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xff000000),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox.shrink(),
                                          ),
                                          SizedBox(height: 10.h,),
                                          getUserDetails('Email Id','${model.userList[index].emailId}'),
                                          getUserDetails('Phone','${model.userList[index].mobileNumber}'),
                                          getUserDetails('Address','${model.userList[index].city}, ${model.userList[index].state}'),
                                          getUserDetails('Company Name','${model.userList[index].companyName}'),
                                          getUserDetails('Company Address','${model.userList[index].companyAddress}'),
                                          getUserDetails('Status','${model.userList[index].state}'),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w, vertical: 10.h),
                                            child: StarDisplay(value:int.parse('${/*model.userList[index].ratings.toString()*/5}')),
                                          ),
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
                //  getLoader(model.isLoading)
                ],
              )),
    );
  }

  filterIcon(OrgProvider model) {
    return Container(
        width: 101.w,
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
                  fontSize: 20.sp,
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
      int? id, OrgProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: () {
        if (id == 0) {
          model.userList.sort(
                  (b, a) => b.firstName!.compareTo(a.firstName!));
          setState(() {});
        } else {
          model.userList.sort(
                  (a, b) => b.firstName!.compareTo(a.firstName!));
          setState(() {});
        }
      },
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.centerRight,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          // <-- SEE HERE
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return addemp(setState);
              }),
        );
      },
    );
  }

  List<dynamic> foundEmp = [];
  List<dynamic> uniqueFoundEmp = [];
  List<dynamic> EmployeeList = [];

  bool isLoad=false;
  getEmployeeName() async {

    isLoad = true;
    String myUrl = AppConstants.GET_ALL_USER;
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoad = false;
    var response = json.decode(req.body);
    print(response);
    var type = AuthApi.fromJson(response);
    type.content!.forEach((element) {
      EmployeeList.add(element.firstName.toString()+" "+element.lastName.toString());
    });
    foundEmp = EmployeeList.toSet().toList();


    setState(() {

    });
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, StateSetter stateSetter) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = EmployeeList;
    } else {
      results = EmployeeList
          .where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    stateSetter(() {
      foundEmp = results.toSet().toList();
    });
  }

  addemp(StateSetter stateSetter) {
    return  Container(
      width: 350.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          TextField(
            onChanged: (value) => _runFilter(value,stateSetter),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 500,
            width: 300,
            child: foundEmp.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: foundEmp.length,
              itemBuilder: (context, index) =>
                  Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context,[foundEmp[index].toString(),foundEmp[index].toString()]);
                        },
                        title: Text(foundEmp[index]),
                      ),
                    ],
                  ),

            )
                : const Text(
              'No results found',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  getCircularContainer(String title, bool isSelected, int i) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) => InkWell(
        onTap: () {
          setState(() {
            selectedTab = title;
            model.getUserList(title);
          });
        },
        child: Container(
          width: 200.w,
          height: 150.h,
          child: Stack(
            children: <Widget>[
              SvgPicture.asset(
                Images.red_arrow,
                alignment: Alignment.center,
                width: 250.w,
                height: 100.h,
                color: isSelected ? Color(0xffC3262C) : Colors.white,
              ),

              Container(
                transform: Matrix4.translationValues(-30.w, 0, 0.0),
                height: 100.h,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 20.sp,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getUserDetails(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 150.w,
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
          TextView(
            title: value,
            fontSize:12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        ]

      ),
    );
  }
}
