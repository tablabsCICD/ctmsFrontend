import 'dart:convert';
import 'dart:ui';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/organization_portal/company/more/more_screen.dart';
import 'package:flutter_hr_management/organization_portal/model/tkd_emp_list_response.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/constant/constant.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import '../../pages/widget/toast.dart';
import '../model/userdata.dart';
import 'company_provider/all_users_provider.dart';

class AllUsersList extends StatefulWidget {
  final Organization organization;
  final userProvider = locator<OrgUserProvider>();

  AllUsersList(this.organization, {Key? key}) : super(key: key) {
    userProvider.getUsersByCompanyId(organization.id!);
  }

  @override
  State<AllUsersList> createState() => _AllUsersListState();
}

class _AllUsersListState extends State<AllUsersList> {
  // Providers
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgUserProvider>();

  // Controllers
  final otpController = TextEditingController();

  // UI States
  String selectedTab = "All Users";
  bool _isInitialFetchDone = false;

  // Employee Search Data
  List<String> foundEmp = [];
  List<String> EmpList = [];
  List<ConnectUser> EmployeeList = [];
  bool isLoad = false;
  TKDEmployeeListResponse? employeeListResponse;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // ✅ Prevent crash if organization is null
    if (widget.organization == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Organization data not available.",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<OrgUserProvider>(
        builder: (context, model, child) => Column(
          children: [
            // Header Row with Filters and Add Button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
              child: Row(
                children: [
                  // Tab Filters
                  Container(
                    height: 40,
                    margin:
                    EdgeInsets.symmetric(horizontal: 33.h, vertical: 20.h),
                    child: Row(
                      children: [
                        getCircularContainer("All Users", 0),
                        SizedBox(width: 10.w),
                        getCircularContainer("Approved", 1),
                        SizedBox(width: 10.w),
                        getCircularContainer("Rejected", 2),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Filter + Add Employee
                  Row(
                    children: [
                      filterIcon(model),
                      SizedBox(width: 27.w),
                      if (orgProvider.loginDeatils?.data?.isAdmin == true)
                        SizedBox(
                          height: 58.h,
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: _showAlertDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColor.theme_blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle, size: 18),
                                SizedBox(width: 6.w),
                                TextView(
                                  title: "Add Employee",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(width: 27.w),
                    ],
                  ),
                ],
              ),
            ),

            if (model.userList.isEmpty && !model.isLoading)
              Container(
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: screenSize.height - 600,
                child: Center(
                  child: Text("No Record Found", style: Style.heading),
                ),
              )
            else
              Expanded(
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 33.w, vertical: 31.h),
                  child: StaggeredGridView.countBuilder(
                    physics: ScrollPhysics(),
                    crossAxisCount: ResponsiveWidget.isDesktop(context) ? 2 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: model.userList.length,
                    itemBuilder: (context, index) {
                      final user = model.userList[index];

                      // ✅ Ensure fields are not null before using them
                      final String firstName = user.firstName ?? "Unknown";
                      final String lastName = user.lastName ?? "";
                      final bool isApproved =
                          (user.isUserVerifiedByCompany ?? 0) == 1;

                      return InkWell(
                        onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => MoreScreen(user),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: getImage(user.profilePicture ?? ""),
                                  title: Row(
                                    children: [
                                      TextView(
                                        title: "$firstName $lastName",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 5.w),
                                      if (isApproved)
                                        Tooltip(
                                          message:
                                          "This user is verified by '${user.companyName ?? "Company"}'",
                                          child: SvgPicture.asset(
                                            'assets/org/sheild.svg',
                                            width: 5,
                                            height: 15,
                                          ),
                                        ),
                                    ],
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: StarDisplay(value: 5),
                                  ),
                                  trailing: isApproved
                                      ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10.r,
                                          color: Colors.green),
                                      SizedBox(width: 5.w),
                                      TextView(
                                        title: 'Approved',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.green,
                                      ),
                                    ],
                                  )
                                      : null,
                                ),

                                // ✅ Use empty string if null
                                getUserDetails('Email Id', user.emailId ?? ""),
                                getUserDetails(
                                    'Phone', user.mobileNumber.toString() ?? ""),
                                getUserDetails(
                                    'Address',
                                    "${user.city ?? ""}, ${user.state ?? ""}"),
                                getUserDetails(
                                    'Company Name', user.companyName ?? ""),
                                getUserDetails('Company Address',
                                    user.companyAddress ?? ""),
                                SizedBox(height: 10.h),

                                if (orgProvider.loginDeatils?.data?.isAdmin ==
                                    true)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (isApproved)
                                        OutlinedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) => MoreScreen(user),
                                              ),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                            ThemeColor.theme_blue,
                                          ),
                                          child: Text(
                                            "View Details",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      // Reject button
                                      OutlinedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text('Reject User'),
                                              content: Text(
                                                  'Are you sure you want to reject this user?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                   await orgProvider.updateUserStatus(context,user.id!,0);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: ThemeColor.red,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: ThemeColor.red,
                                        ),
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),

                                      if (!isApproved)
                                        OutlinedButton(
                                          onPressed: () async {
                                            await orgProvider.sendOtp(
                                                user.mobileNumber.toString() ?? "", context);
                                            setState(() {
                                              user.isSendOtp = true;
                                            });
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                            ThemeColor.theme_blue,
                                          ),
                                          child: Text(
                                            user.isSendOtp == true
                                                ? "Resend Otp"
                                                : "Send Otp",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                      if (user.isSendOtp == true && !isApproved)
                                        OutlinedButton(
                                          onPressed: () async {
                                            final otpController =
                                            TextEditingController();

                                            await showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                title:
                                                const Text('OTP Verification'),
                                                content: TextField(
                                                  controller: otpController,
                                                  decoration: InputDecoration(
                                                    labelText: "Enter OTP",
                                                    border:
                                                    OutlineInputBorder(),
                                                  ),
                                                  keyboardType:
                                                  TextInputType.number,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (otpController
                                                          .text.isNotEmpty) {
                                                        await orgProvider
                                                            .verifyOtp(
                                                          context,
                                                          user.mobileNumber.toString() ??
                                                              "",
                                                          otpController.text,
                                                          user,
                                                          widget.organization,
                                                        );
                                                        setState(() {
                                                          user.isSendOtp = false;
                                                        });
                                                        await orgProvider.updateUserStatus(context,user.id!,1);
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Verify Otp"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                            ThemeColor.theme_blue,
                                          ),
                                          child: Text(
                                            "Verify & Approve",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }



  Widget filterIcon(OrgUserProvider model) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupMenuButton<int>(
              position: PopupMenuPosition.under,
              icon: SvgPicture.asset(
                Images.filter,
                height: 19.h,
                width: 20.w,
              ),
              onSelected: (value) {
                if (value == 0) {
                  model.userList
                      .sort((a, b) => a.firstName!.compareTo(b.firstName!));
                } else {
                  model.userList
                      .sort((a, b) => b.firstName!.compareTo(a.firstName!));
                }
                // Ensure rebuild after sorting
                if (model is ChangeNotifier) {
                  model.notifyListeners();
                }
              },
              itemBuilder: (ctx) => [
                _buildPopupMenu("Sort By Name A to Z", 0),
                _buildPopupMenu("Sort By Name Z to A", 1),
              ],
            ),
            SizedBox(width: 8.w),
            Text(
              "Filter",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenu(String title, int id) {
    return PopupMenuItem<int>(
      value: id,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }


  Future<void> _showAlertDialog() async {
    _isInitialFetchDone = false; // Reset when dialog is opened
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.centerRight,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
              // Call API on first build only
              if (!_isInitialFetchDone) {
                getEmployeeName('', stateSetter);
                _isInitialFetchDone = true;
              }

              return addemp(stateSetter);
            },
          ),
        );
      },
    );
  }

  List<String> uniqueFoundEmp = [];


  getEmployeeName(String char, StateSetter stateSetter) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    isLoad = true;
    stateSetter(() {}); // Use dialog's state

    Dio dio = Dio();
    String myUrl = AppConstants.GET_ALL_USER_SEARCH + "$char&page=0&size=10000";
    print("Get All Emp : " + myUrl);

    final response = await dio.get(
      myUrl,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      employeeListResponse =
          TKDEmployeeListResponse.fromJson(jsonDecode(response.data));

      EmployeeList.clear();
      EmpList.clear();

      EmployeeList.addAll(employeeListResponse!.data!);
      employeeListResponse!.data!.forEach((element) {
        EmpList.add("${element.firstName} ${element.lastName}");
      });

      foundEmp = EmpList.toSet().toList();

      stateSetter(() {}); // Notify dialog to update list
    }

    isLoad = false;
    stateSetter(() {});
  }

  void _runFilter(String enteredKeyword, StateSetter stateSetter) {
    if (enteredKeyword.isEmpty) {
      foundEmp = [];
      stateSetter(() {}); // Clear list in dialog
    } else {
      getEmployeeName(enteredKeyword, stateSetter); // Pass dialog's setState
    }
  }

  addemp(StateSetter stateSetter) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          TextField(
            onChanged: (value) => _runFilter(value, stateSetter),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: isLoad
                ? Center(
              child: CircularProgressIndicator(), // Or your custom loader
            )
                : foundEmp.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: foundEmp.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  EmployeeList.forEach((element) {
                    if (foundEmp[index] == "${element.firstName} ${element.lastName}") {
                      showAddEmployeeDialog(context, element, index);
                    }
                  });
                },
                title: Text(foundEmp[index]),
              ),
            )

                : const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show OTP verification dialog
  Future<bool> showOtpDialog(BuildContext context, ConnectUser element) async {
    TextEditingController otpController = TextEditingController();

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // force user to verify/cancel
      builder: (_) => AlertDialog(
        title: Text(
          'OTP Verification',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        content: TextField(
          controller: otpController,
          decoration: InputDecoration(
            labelText: "Enter OTP",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (otpController.text.isEmpty) return;
              bool otpVerified = await orgProvider.verifyOtp(
                context,
                element.mobileNumber.toString(),
                otpController.text,
                element,widget.organization
              );

              if (otpVerified) {
                Navigator.pop(context, true); // OTP verified
              } else {
                ToastMessage.show(context, "OTP verification failed!");
              }
            },
            child: Text("Verify OTP"),
          ),
        ],
      ),
    ) ?? false;
  }

// Function to show Add Employee dialog
  void showAddEmployeeDialog(BuildContext context, ConnectUser element, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Add Employee"),
        content: Text("You want to add employee.. First we need to send OTP"),
        actions: [
          TextButton(
            child: Text("Send OTP", style: TextStyle(color: Colors.green)),
            onPressed: () async {
              // 1. Send OTP
              bool otpReady = await orgProvider.sendOtp(
                element.mobileNumber.toString(),
                context,
              );

              if (!otpReady) {
                ToastMessage.show(context, "Failed to send OTP!");
                return;
              }

              element.isSendOtp = true;

              // 2. Show OTP dialog and wait for verification
              bool verified = await showOtpDialog(context, element);

              // 3. If verified, add to CTMS
              if (verified) {
                Navigator.of(context).pop();
                ToastMessage.show(context, "Employee added successfully!");
              }

              // 4. Close Add Employee dialog
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

   Widget getCircularContainer(String title, int i) {
    return Consumer<OrgUserProvider>(
      builder: (context, model, child) {
        final bool isSelected = selectedTab == title;

        return InkWell(
          onTap: () {
            if (!isSelected) {
              setState(() {
                selectedTab = title;
              });
              model.getUserList(title);
            }
          },
          child: Container(
            width: 200.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: isSelected ? const Color(0xffC3262C) : Colors.white,
              border: Border.all(
                color:
                isSelected ? const Color(0xffC3262C) : Colors.grey.shade300,
                width: 1,
              ),
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
        );
      },
    );
  }

  Widget getUserDetails(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.w,
            child: TextView(
              title: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
              color: const Color(0xff000000),
            ),
          ),
          SizedBox(
            width: 10.w,
            child: TextView(
              title: ':',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff000000),
            ),
          ),
          Expanded(
            child: TextView(
              title: value,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}
