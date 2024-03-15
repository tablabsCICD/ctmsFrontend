import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/jwt_login_data.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';

import 'package:flutter_hr_management/model/response/search_emp_response.dart';
import 'package:flutter_hr_management/model/role_model.dart';
import 'package:flutter_hr_management/organization_portal/model/all_user_model.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/pages/empdetails/add_employee.dart';
import 'package:flutter_hr_management/pages/empdetails/emp_info.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/request/save_emp.dart';
import '../../model/response/employeelist.dart';
import '../../utils/constant.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/filter_button.dart';
import 'package:http/http.dart' as http;

class EmpDashboard extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  EmpDashboard(this.scaffoldKey);

  @override
  _EmpDashboard createState() => _EmpDashboard();
}

class _EmpDashboard extends State<EmpDashboard> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addLeadController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  List<EmployeeData> finalEmData = [];
  List<EmployeeData> empData = [];
  List<EmployeeData> activeEmpData = [];
  List<EmployeeData> inActiveEmpData = [];
  bool isLoad = false;
  List<Role> dataRole = [];
  int selectRole = 0;
  String selectedRole = "Select Role";
  EmployeeData? selectedEmpTOAdd;
  @override
  void initState() {
    // TODO: implement initState
    getLoginDetail();
    ApiGetDataDashbord("", selectedPageNumber);
    getEmployeeName();
    foundEmp = EmployeeList..toSet().toList();
    super.initState();

  }

  LoginDeatils? loginDeatils;
  Future<void> getLoginDetail() async {
    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    getEmpToken(loginDeatils!.data!.id!);
  }
  String? token;

  Future<void> getEmpToken(int empId) async {
    String authToken = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);

    String myUrl = ApiConstant.BASE_URL +
        "api/getTokenByEmployeeId?employeeId=${empId}";
    debugPrint("Get Token Url:" + myUrl);

    EasyLoading.show(status: "Loading");
    final req = await http.get(Uri.parse(myUrl), headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${authToken}',
    });
    EasyLoading.dismiss();
    print('the body is ${req.body}');
    if (req.statusCode == 200) {
      var jwtResponse = json.decode(req.body);
      print('the response is ${jwtResponse}');
      JWTLoginData jwtLoginData =
      JWTLoginData.fromJson(jwtResponse);
      if (jwtLoginData.data != null) {
        token = jwtLoginData.data!;
        print("Final Generated Token ::" + token!);
      } else {
        showCustomToast(
            context, jwtLoginData.message!, Icons.clear, Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.baground,
      child: Column(
        children: [
          HeaderWidget(
            scaffoldKey:widget.scaffoldKey,
            isSearchVisible: true,
            onSearchTap: (value) {
              filterSearchResults(value);
            },

          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Row(
              children: [
                Text(
                  'Employee Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    filterIcon(),
                    SizedBox(
                      width: 27.w,
                    ),
                   loginDeatils!.data!.isAdmin==true? SizedBox(
                      height: 58.h,
                      width: 185.w,
                      child: ElevatedButton(
                          onPressed: () async {
                            final url = Uri.parse(
                                "http://tkd-hrms.s3-website.ap-south-1.amazonaws.com/hrm/employee?token=${token}&empId=${loginDeatils!.data!.id}&orgId=${loginDeatils!.data!.organisationId}&type=AddEmployee");
                            debugPrint("HRMS Url : "+url.toString());
                            if (!await launchUrl(url,)) {
                            throw Exception('Could not launch $url');
                            }
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
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ):SizedBox.shrink()
                  ],
                ),
                SizedBox(
                  width: 18,
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  width: 38.w,
                ),
                empCounts("${totalElements}", "Total Employees", Images.emp_tot,
                    Color(0xFFEAF8F4), true),
                SizedBox(
                  width: 38.w,
                ),
                empCounts("${activeEmpData.length}", "Active Employees",
                    Images.emp_tot, Color(0xFFFFEDF9), false),
                SizedBox(
                  width: 38.w,
                ),
                empCounts("${inActiveEmpData.length}", "Inactive Employees",
                    Images.emp_tot, Color(0xFFFEF0E5), false),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedEmpList == "Total"
                      ? "Employee List"
                      : selectedEmpList == "Active"
                          ? "Active Employees"
                          : "InActive Employees",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                    fontSize: 24.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                Container(
                  width: 300.w,
                  height: 60.h,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              getPrevPage(selectedPageNumber);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                            )),
                        Text(
                          "Showing ${selectedPageNumber + 1}-10 out of ${totalElements} Results",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                        InkWell(
                            onTap: () {
                              getNextPage(selectedPageNumber);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 30, right: 38),
                child: isLoad
                    ? Container(
                  height: MediaQuery.of(context).size.height - 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                      child: Center(
                          child: CircularProgressIndicator(),
                        ),
                    )
                    : Container(
                        // height: 350,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              finalEmData.isEmpty
                                  ? Container(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height -
                                          600,
                                      child: Center(
                                          child: TextView(
                                              title: "No Record Found",
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight:
                                                  FontWeight.w900)))
                                  : Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: loginDeatils!.data!.isAdmin==true?{
                                        0: FlexColumnWidth(50),
                                        1: FlexColumnWidth(40),
                                        2: FlexColumnWidth(50),
                                        3: FlexColumnWidth(30),
                                        4: FlexColumnWidth(20),
                                        5: FlexColumnWidth(20),
                                      }:{
                                        0: FlexColumnWidth(50),
                                        1: FlexColumnWidth(40),
                                        2: FlexColumnWidth(50),
                                        3: FlexColumnWidth(30),
                                        4: FlexColumnWidth(20),
                                        5: FlexColumnWidth(10),
                                      },
                                      children: [
                                        /// Table Header
                                        TableRow(
                                          children: [
                                            tableHeader("Name"),
                                            if (!AppResponsive.isMobile(
                                                context))
                                              tableHeader("Designation"),
                                            if (!AppResponsive.isMobile(
                                                context))
                                              tableHeader("Mail"),
                                            tableHeader("Contact"),
                                            tableHeader("Details"),
                                            loginDeatils!.data!.isAdmin==true?
                                              tableHeader("Action"):SizedBox.shrink(),
                                          ],
                                        ),
                                        for (int i = 0;
                                            i < finalEmData.length;
                                            i++)
                                          tableRow(context,
                                              name: finalEmData[i].firstName! +
                                                  " " +
                                                  finalEmData[i].lastName!,
                                              color: Colors.blue,
                                              image: finalEmData[i].image,
                                              designation:
                                                  finalEmData[i].designation,
                                              contact:
                                                  finalEmData[i].contact,
                                              index: i,
                                              email: finalEmData[i].emailId),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      )),
          ),
        ],
      ),
    );
  }

  Future<void> filterSearchResults(String query) async {
    debugPrint('Query : $query \n Total leads : ${empData.length}');
    finalEmData.clear();
    debugPrint('Total leads : ${empData.length}');

    ApiEmpSearchData('',selectedPageNumber,query);
   /* empData.forEach((element) {
      if (element.firstName!.toLowerCase().contains(query.toLowerCase()) ||
          element.mobileNumber!.contains(query)) {
        finalEmData.add(element);
      }
    });*/
    debugPrint('Final Leads : ${finalEmData.length}');
    setState(() {});
  }

  EmployeeListResponse? employeeListResponse;

  Future<void> ApiGetDataDashbord(String URL, int pNo) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    isLoad = true;
    setState(() {});
    Dio dio = Dio();
    final response = await dio.get(
        ApiConstant.GET_ALL_EMPLOYEE + "?organisationId=${loginDeatils!.data!.organisationId}&page=${pNo}&size=10",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      employeeListResponse =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      finalEmData.clear();
      activeEmpData.clear();
      inActiveEmpData.clear();
      totalPages = employeeListResponse!.data!.totalPages!;
      totalElements = employeeListResponse!.data!.totalElements!;
      debugPrint("TotalPages:: ${totalPages}\n TotalRecord:: ${totalElements}");
      finalEmData.addAll(employeeListResponse!.data!.content!);
      //print('this is ${emData.length}');
      empData.clear();
      empData.addAll(employeeListResponse!.data!.content!);
      empData.forEach((element) {
        if (element.isActive == 1) {
          activeEmpData.add(element);
        } else {
          inActiveEmpData.add(element);
        }
      });
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeListResponse!.data!.content!);
      isLoad = false;
      setState(() {});
    }
  }

  Future<void> ApiEmpSearchData(String URL, int pNo,String query) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    if(query=='') {
      ApiGetDataDashbord('', selectedPageNumber);}
    isLoad = true;
    setState(() {});
    Dio dio = Dio();
    finalEmData.clear();
    final response = await dio.get(
        ApiConstant.SEARCH_EMP + "?organisationId=${loginDeatils!.data!.organisationId}&keyword=${query}",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      SearchEmpResponse searchEmpResponse =
          SearchEmpResponse.fromJson(jsonDecode(response.data));
      searchEmpResponse.data!.forEach((element) {
        finalEmData.add(element.employeeDetails!);
      });
      isLoad = false;
      setState(() {});
    }
  }

  filterIcon() {
    return Container(
        width: 125.w,
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                  _buildPopupMenuItem('Sort By Name A to Z', 0),
                  _buildPopupMenuItem('Sort By Name Z to A', 1),
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

  PopupMenuItem _buildPopupMenuItem(
    String title,
    int? id,
  ) {
    return PopupMenuItem(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColor.black,
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      onTap: () {
        if (id == 0) {
          finalEmData.sort((b, a) => b.firstName!.compareTo(a.firstName!));
          setState(() {});
        } else {
          finalEmData.sort((a, b) => b.firstName!.compareTo(a.firstName!));
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

  getEmployeeName() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    isLoad = true;
    setState(() {});
    Dio dio = Dio();
    final response = await dio.get(
        ApiConstant.GET_ALL_EMPLOYEE + "?organisationId=${loginDeatils!.data!.organisationId}&page=${0}&size=1000",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    if (response.statusCode == 200) {
      employeeListResponse =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      employeeListResponse!.data!.content!.forEach((element) {
        EmployeeList.add(
            element.firstName.toString() + " " + element.lastName.toString());
      });
      foundEmp = EmployeeList.toSet().toList();
    }
    setState(() {});
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, StateSetter stateSetter) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = EmployeeList;
    } else {
      results = EmployeeList.where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    stateSetter(() {
      foundEmp = results.toSet().toList();
    });
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
          Container(
            height: 500,
            width: 300,
            child: foundEmp.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: foundEmp.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          onTap: () {
                            empData.forEach((element) {
                              if (foundEmp[index] ==
                                  "${element.firstName} ${element.lastName}") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Simple Alert"),
                                      content:
                                          Text("This is an alert message."),
                                      actions: [
                                        TextButton(
                                          child: Text("Add"),
                                          onPressed: () {
                                            addToTKDConnect(element, stateSetter);
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            });

                            // Navigator.pop(context,[foundEmp[index].toString(),foundEmp[index].toString()]);
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String label) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Role'),
                content: setupAlertDialoadContainer(),
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(label),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    String addLead = _addLeadController.text.toString();
    String lastName = _lastnameController.text.toString();
    SaveEmploye saveEmploye = SaveEmploye();
    saveEmploye.firstName = name;
    saveEmploye.lastName = lastName;
    saveEmploye.os = "Web";
    saveEmploye.emailId = email;
    saveEmploye.address = addLead;
    saveEmploye.mobileNumber = phone;
    saveEmploye.role = selectRole;
    saveEmploye.password = _passwordController.text;
    Dio dio = Dio();
    var response = await dio.post(ApiConstant.SAVE_EMP,
        data: jsonEncode(saveEmploye.toJson()),
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    if (response.statusCode == 200) {
      setState(() {
        ApiGetDataDashbord("", selectedPageNumber);
      });
    } else {
      //  ToastMessage.show(context, "Not Added Sucessfully");
      showCustomToast(
          context, "Not Added Successfully", Icons.clear, Colors.red);
    }
  }



  TableRow tableRow(context,
      {name, image, designation, contact, color, index, email}) {
    return TableRow(children: [
      //Full Name
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmpInfo(empData: finalEmData[index])));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 35.w,
              ),
              getImage(image??'', height: 30.h, width: 30.w),
              SizedBox(
                width: 10.w,
              ),
              Center(child: Text(name??"-", style: tableRowStyle()))
            ],
          ),
        ),
      ),
      // Designation
      if (!AppResponsive.isMobile(context))
        Center(
            child: Text(
          designation??"-",
          style: tableRowStyle(),
        )),
      if (!AppResponsive.isMobile(context))
        Center(child: Text(email??"-", style: tableRowStyle())),
      Center(child: Text(contact??"-", style: tableRowStyle())),


        Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EmpInfo(empData: finalEmData[index])));
            },
            child: Text(
              "View",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                  height: 0,
                  decoration: TextDecoration.underline),
            ),
          ),
        ),
      // Menu icon
      loginDeatils!.data!.isAdmin==true?Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              editEmp(index);
            },
            child: Icon(
              Icons.edit,
              size: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          InkWell(
            onTap: () {
              showAlertDialog(context, index);
            },
            child: Icon(
              Icons.delete,
              size: 20,
              color: Colors.red,
            ),
          ),
        ],
      ):SizedBox.shrink(),
    ]);
  }

  TextStyle tableRowStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 14.sp,
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontWeight: FontWeight.w300,
      height: 0,
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 18.sp),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        callDelete(index);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete !"),
      content: Text("Do you want to delete this lead ?"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void callDelete(int index) async {
    Dio dio = Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var response = await dio.delete(ApiConstant.EMP_DELTEB,
        queryParameters: {"id": finalEmData[index].id},
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    if (response.statusCode == 200) {
      finalEmData.removeAt(index);
      empData.remove(index);
      setState(() {});
      ApiGetDataDashbord("", selectedPageNumber);
    } else {
      // ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataRole.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              selectRole = dataRole[index].id!;
              selectedRole = dataRole[index].name!;
              Navigator.pop(context);
              setState(() {});
            },
            child: ListTile(
              title: Text(dataRole[index].name!),
            ),
          );
        },
      ),
    );
  }

  String selectedEmpList = "Total";

  empCounts(String totCount, String name, String image, Color color,
      bool isSelected) {
    return InkWell(
      onTap: () {
        if (name == "Active Employees") {
          finalEmData.clear();
          finalEmData.addAll(activeEmpData);
          selectedEmpList = "Active";
        } else if (name == "Inactive Employees") {
          finalEmData.clear();
          finalEmData.addAll(inActiveEmpData);
          selectedEmpList = "InActive";
        } else {
          finalEmData.clear();
          finalEmData.addAll(empData);
          selectedEmpList = "Total";
        }
        setState(() {});
      },
      child: Container(
        width: 329.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFFC3262C)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 108.w,
                height: 110.h,
                decoration: ShapeDecoration(
                  color: color, //Color(0xFFEAF8F4)
                  shape: CircleBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    image,
                    height: 10.h,
                    width: 10.w,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  totCount,
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  editEmp(int index) async {
    await showDialog<void>(
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
            return EditEmployee(empData: finalEmData[index]);
          }),
        );
      },
    );
    ApiGetDataDashbord("", selectedPageNumber);
  }

  int selectedPageNumber = 0;
  int totalPages = 0;
  int totalElements = 0;

  void getPrevPage(selectedPageNumer) {
    if (selectedPageNumber == 0) {
      ApiGetDataDashbord("", selectedPageNumber);
    } else if (selectedPageNumber > 0) {
      selectedPageNumber--;
      ApiGetDataDashbord("", selectedPageNumber);
      setState(() {});
    }
  }

  void getNextPage(selectedPageNumer) {
    if (selectedPageNumber < totalPages - 1) {
      selectedPageNumber++;
      ApiGetDataDashbord("", selectedPageNumber);
      setState(() {});
    }
  }

  Future<void> addToTKDConnect(
      EmployeeData selectedEmp, StateSetter stateSetter) async {
    Map<String, dynamic> requestParameter = {
      "aadharCard": 'string',
      "aadharCardForVerification": "string",
      "alternativeNumber": selectedEmp.contact,
      "city": selectedEmp.address,
      "companyAddress": "pune",
      "companyId": 1,
      "companyLogo": "string",
      "companyName": "string",
      "country": "India",
      "deviceId": "string",
      "emailId": selectedEmp.emailId,
      "firstName": selectedEmp.firstName,
      "idOfMainBranch": 0,
      "isPaid": 0,
      "isUserVerifiedByCompany": 0,
      "landlineNumber": selectedEmp.contact,
      "lastName": selectedEmp.lastName,
      "loggedTime": GetDateFormat.getCurrentDate(),
      "loggedUserName": "string",
      "mainBranch": 0,
      "mobileNumber": selectedEmp.contact,
      "numberOfTimesRating": 3,
      "os": "string",
      "otp": "string",
      "paidStartDate": "string",
      "panCardForVerification": "string",
      "password": "string",
      "preferredRouresEntered": 0,
      "profilePicture": "string",
      "ratings": 0,
      "state": "Maharastra",
      "transporterOrAgent": 0,
      "userName": "string",
      "validTill": "string",
      "verified": 0,
      "website": "string"
    };
    print(requestParameter);
    var reqPara = jsonEncode(requestParameter);
    print(reqPara);
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    print("Add User Url :" + AppConstants.REGISTRATION);
    var response = await dio.post(
      AppConstants.REGISTRATION,
      data: reqPara,
    );
    print('Save User Response is: ${response.data}');
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      showCustomToast(
          context, "Employee added successfully", Icons.check, Colors.green);
      Navigator.of(context).pop();
      // AllUserModel postLead = AllUserModel.fromJson(jsonDecode(response.data));
    } else {
      showCustomToast(
          context, response.statusMessage.toString(), Icons.clear, Colors.red);
      Navigator.of(context).pop();
    }
  }
}
