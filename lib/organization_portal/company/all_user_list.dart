import 'dart:convert';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/branch_response_model.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
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
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginDetails();
    getEmployeeName();
  }

  LoginDeatils? loginDeatils;
  getLoginDetails() async {
    loginDeatils =
    await LocalSharePreferences.localSharePreferences.getLoginData();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) => Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.h),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 33.h,vertical: 20.h),
                          child: Row(
                            children: [
                              getCircularContainer(
                                  "All Users", (selectedTab == "All Users"), 0),
                              SizedBox(width: 10.w,),
                              getCircularContainer(
                                  "Approved", (selectedTab == "Approved"), 1),
                              SizedBox(width: 10.w,),
                              getCircularContainer(
                                  "Rejected", (selectedTab == "Rejected"), 2),
                              //  getCircularContainer("Pending",(selectedTab == "Pending"),3),
                            ],
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            filterIcon(model),
                            SizedBox(
                              width: 27.w,
                            ),
                            loginDeatils!.data!.isAdmin==false?SizedBox.shrink():SizedBox(
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
                  ),
                  model.userList.isEmpty && model.isLoading == false
                      ? Container(
                      margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                          height: MediaQuery.of(context).size.height - 600,
                          child: Center(
                              child: Text(
                            "No Record Found",
                            style: Style.heading,
                          )))
                      : Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 33.w, vertical: 31.h),
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
                                                    title: "${model.userList[index].firstName} ${model.userList[index].lastName}",
                                                    fontSize:15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                  ),
                                                  SizedBox(width: 5.w,),
                                                  model.userList[index]
                                                      .isUserVerifiedByCompany ==
                                                      1
                                                      ? Tooltip(
                                                    message:
                                                    "This user is verified by '${model.userList[index].companyName}'",
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
                                              leading: getImage(model.userList[index]
                                                  .profilePicture
                                                  .toString()),
                                              trailing: model.userList[index].isUserVerifiedByCompany==1?Container(
                                                width: 100,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      size: 10.r,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    TextView(
                                                     title: 'Approved',
                                                      fontSize:14.sp,
                                                      fontWeight: FontWeight.w300,
                                                      color: Colors.green,
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
                                            SizedBox(height: 10.h,),
                                            loginDeatils!.data!.isAdmin==false?SizedBox.shrink():Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                model.userList[index].isUserVerifiedByCompany==0?Padding(
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
                                                        await authProvider.updateUser(
                                                          aadharCard: model.userList[index].aadharCard,
                                                          alternativeNumber: model.userList[index].alternativeNumber,
                                                          city: model.userList[index].city,
                                                          companyId: model.userList[index].companyId,
                                                          companyAddress: model.userList[index].companyAddress,
                                                          companyLogo: model.userList[index].companyLogo,
                                                          companyName: model.userList[index].companyName,
                                                          country: model.userList[index].country,
                                                          deviceId: model.userList[index].deviceId,
                                                          emailId: model.userList[index].emailId,
                                                          firstName: model.userList[index].firstName,
                                                          id: model.userList[index].id,
                                                          idOfMainBranch: model.userList[index].idOfMainBranch,
                                                          isPaid: model.userList[index].isPaid,
                                                          isUserVerifiedByCompany: 1,
                                                          landlineNumber: model.userList[index].landlineNumber,
                                                          lastName: model.userList[index].lastName,
                                                          loggedTime: model.userList[index].loggedTime.toString(),
                                                          loggedUserName: model.userList[index].loggedUserName,
                                                          mainBranch: model.userList[index].mainBranch,
                                                          mobileNumber: model.userList[index].mobileNumber,
                                                          numberOfTimesRating: model.userList[index].numberOfTimesRating,
                                                          os: model.userList[index].os,
                                                          otp: model.userList[index].otp,
                                                          paidStartDate: model.userList[index].paidStartDate,
                                                          password: model.userList[index].password,
                                                          preferredRouresEntered: model.userList[index].preferredRouresEntered,
                                                          profilePicture: model.userList[index].profilePicture,
                                                          rating: model.userList[index].ratings,
                                                          state: model.userList[index].state,
                                                          transporterOrAgent: model.userList[index].transporterOrAgent,
                                                          userName: model.userList[index].userName,
                                                          validTill: model.userList[index].validTill,
                                                          website: model.userList[index].website,
                                                          verified: model.userList[index].verified,
                                                        );
                                                        model.selectedTab="All Users";
                                                        selectedTab = "All Users";
                                                        model.getUsersByCompanyId(widget.organization.id!);
                                                        setState(() {});
                                                    },
                                                    child: Text('Approve',
                                                        style:TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily:
                                                          GoogleFonts.poppins().fontFamily,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        ),
                                                  ),
                                                ):

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
                                                      await authProvider.updateUser(
                                                        aadharCard: model.userList[index].aadharCard,
                                                        alternativeNumber: model.userList[index].alternativeNumber,
                                                        city: model.userList[index].city,
                                                        companyId: model.userList[index].companyId,
                                                        companyAddress: model.userList[index].companyAddress,
                                                        companyLogo: model.userList[index].companyLogo,
                                                        companyName: model.userList[index].companyName,
                                                        country: model.userList[index].country,
                                                        deviceId: model.userList[index].deviceId,
                                                        emailId: model.userList[index].emailId,
                                                        firstName: model.userList[index].firstName,
                                                        id: model.userList[index].id,
                                                        idOfMainBranch: model.userList[index].idOfMainBranch,
                                                        isPaid: model.userList[index].isPaid,
                                                        isUserVerifiedByCompany: 0,
                                                        landlineNumber: model.userList[index].landlineNumber,
                                                        lastName: model.userList[index].lastName,
                                                        loggedTime: model.userList[index].loggedTime.toString(),
                                                        loggedUserName: model.userList[index].loggedUserName,
                                                        mainBranch: model.userList[index].mainBranch,
                                                        mobileNumber: model.userList[index].mobileNumber,
                                                        numberOfTimesRating: model.userList[index].numberOfTimesRating,
                                                        os: model.userList[index].os,
                                                        otp: model.userList[index].otp,
                                                        paidStartDate: model.userList[index].paidStartDate,
                                                        password: model.userList[index].password,
                                                        preferredRouresEntered: model.userList[index].preferredRouresEntered,
                                                        profilePicture: model.userList[index].profilePicture,
                                                        rating: model.userList[index].ratings,
                                                        state: model.userList[index].state,
                                                        transporterOrAgent: model.userList[index].transporterOrAgent,
                                                        userName: model.userList[index].userName,
                                                        validTill: model.userList[index].validTill,
                                                        website: model.userList[index].website,
                                                        verified: model.userList[index].verified,
                                                      );
                                                      model.selectedTab="All Users";
                                                      selectedTab = "All Users";
                                                      model.getUsersByCompanyId(widget.organization.id!);
                                                      setState((){});
                                                    },
                                                    child: Text('Reject',
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
      int? id, OrgProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 14.sp,
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

  List<String> foundEmp = [];
  List<String> uniqueFoundEmp = [];
  List<EmployeeData> EmployeeList = [];
  List<String> EmpList = [];
  List<User> allUserList = [];
  bool isLoad=false;

  EmployeeListResponse? employeeListResponse;
  getEmployeeName() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    isLoad = true;
    setState(() {});
    Dio dio = Dio();
    final response = await dio.get(
        ApiConstant.GET_ALL_EMPLOYEE + "?organisationId=${loginDeatils!.data!.organisationId}&page=${0}&size=1000",
        options: Options(
            headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));

   /* isLoad = true;
    String myUrl = AppConstants.GET_ALL_USER;
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoad = false;
    var response = json.decode(req.body);
    print(response);
    var type = AuthApi.fromJson(response);

     allUserList.addAll(response.content as Iterable<User>);
    type.content!.forEach((element) {
      EmployeeList.add(element.firstName.toString()+" "+element.lastName.toString());
    });
    foundEmp = EmployeeList.toSet().toList();
    */

    if (response.statusCode == 200) {
      employeeListResponse =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      EmployeeList.addAll(employeeListResponse!.data!.content!);
      employeeListResponse!.data!.content!.forEach((element) {
        EmpList.add(
            element.firstName.toString() + " " + element.lastName.toString());
      });
      foundEmp = EmpList.toSet().toList();
    }
    isLoad=false;
    setState(() {

    });
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, StateSetter stateSetter) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      results = EmpList;
    } else {
      results = EmpList
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
          Expanded(
            child: foundEmp.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: foundEmp.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    onTap: () {
                      EmployeeList.forEach((element) {
                        if (foundEmp[index] == "${element.firstName} ${element.lastName}") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Add Employee"),
                                content:
                                Text("You want to add employee?"),
                                actions: [
                                  TextButton(
                                    child: Text("Add"),
                                    onPressed: () async {
                                      //  await orgProvider.getBranchById(element.);
                                      addToTKDConnect(element, stateSetter);
                                      Navigator.of(context).pop();
                                    }
                                  ),
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      /*showCustomToast(
                                          context, "", Icons.clear, Colors.red);*/
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                      });
                    //  Navigator.pop(context,[foundEmp[index].toString(),foundEmp[index].toString()]);
                    },
                    title: Text(foundEmp[index]),
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

  Future<void> addToTKDConnect(EmployeeData selectedEmp, StateSetter stateSetter) async {
    Map<String, dynamic> requestParameter = {
      "aadharCard": selectedEmp.boardingDeatails==null?'NA':selectedEmp.boardingDeatails!.aadharCard,
      "aadharCardForVerification": selectedEmp.boardingDeatails==null?'NA':selectedEmp.boardingDeatails!.aadharCard,
      "alternativeNumber": selectedEmp.mobileNumber,
      "branchName": selectedEmp.branch!.branchName,
      "city": selectedEmp.address,
      "companyAddress": widget.organization.companyAddress,
      "companyId": widget.organization.id,
      "companyLogo": widget.organization.companyLogo,
      "companyName": widget.organization.companyName,
      "country": "India",
      "deviceId": "NA",
      "emailId": selectedEmp.emailId,
      "firstName": selectedEmp.firstName,
      "idOfMainBranch": 0,
      "isPaid": 0,
      "isUserVerifiedByCompany": 0,
      "landlineNumber": selectedEmp.contact,
      "lastName": selectedEmp.lastName,
      "loggedTime": GetDateFormat.getCurrentDate(),
      "loggedUserName": "NA",
      "mainBranch": 0,
      "mobileNumber": selectedEmp.contact,
      "numberOfTimesRating": 0,
      "os": "string",
      "otp": "string",
      "paidStartDate": "string",
      "panCardForVerification": selectedEmp.boardingDeatails==null?'NA':selectedEmp.boardingDeatails!.panCard,
      "password": selectedEmp.password,
      "preferredRouresEntered": 0,
      "profilePicture": selectedEmp.image,
      "ratings": 0,
      "state": "Maharastra",
      "transporterOrAgent": 0,
      "userName": "NA",
      "validTill": "string",
      "verified": 0,
      "website": widget.organization.website
    };
    print(requestParameter);
    var reqPara = jsonEncode(requestParameter);
    print(reqPara);
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    print("Add User Url :" + AppConstants.REGISTRATION);
    var response = await http.post(
      Uri.parse(AppConstants.REGISTRATION),body:
      reqPara,
        headers: {
          "Content-Type": "application/json",
        }
    );
    print('Save User Response is: ${response.body}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      print(resData);
      print(resData['errorCode']);
     if(resData['errorCode'].toString()=="500"){
       showCustomToast(
           context, resData['errorMessage'].toString(), Icons.clear, Colors.red);
     }else{
       orgProvider.getUsersByCompanyId(widget.organization.id!);
       showCustomToast(
           context, "Employee added successfully", Icons.check, Colors.green);
       Navigator.of(context).pop();
     }
      // AllUserModel postLead = AllUserModel.fromJson(jsonDecode(response.data));
    } else {
      showCustomToast(
          context, "Something went wrong", Icons.clear, Colors.red);
      Navigator.of(context).pop();
    }
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? Color(0xffC3262C) : Colors.white,
          ),
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
