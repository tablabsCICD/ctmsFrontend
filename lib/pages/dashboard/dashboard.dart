import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/search_emp_response.dart';
import 'package:flutter_hr_management/pages/report/customer_model.dart';
import 'package:flutter_hr_management/pages/report/pdf_service.dart';
import 'package:flutter_hr_management/pages/report/saveFile.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/emp_report_model.dart';
import 'package:flutter_hr_management/model/response/employeelist.dart';
import 'package:flutter_hr_management/pages/empdetails/activity/customer_grpah.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/textviewone.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/calender_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';
import 'widget/profile_card_widget.dart';
import 'widget/recruitment_data_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;


class Dashboard extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  Dashboard(this.scaffoldKey);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<int> video = [];
  List<EmployeeData> finalEmpData = [];
  List<EmployeeData> emData = [];

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData('', selectedPageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderWidget(
            scaffoldKey: widget.scaffoldKey,
            isSearchVisible: true,
            onSearchTap: (value) {
              filterSearchResults(value);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(33),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Textview(
                              TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontFamily: GoogleFonts.poppins()
                                    .fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                              title: 'Employee Lead Report'),
                          filterIcon(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 300.w,
                          margin:
                          EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin:
                            EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      getPrevPage(
                                          selectedPageNumber);
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
                                      fontFamily:
                                      GoogleFonts.poppins()
                                          .fontFamily),
                                ),
                                InkWell(
                                    onTap: () {
                                      getNextPage(
                                          selectedPageNumber);
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
                    isLoad
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
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.all(20),

                      child: finalEmpData.isEmpty
                          ? Container(
                              height: MediaQuery.of(context)
                                  .size
                                  .height -
                                  400,
                              child: Center(
                                  child: TextView(
                                      title: "No Record Found",
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.w900)))
                          : Table(
                        columnWidths: {
                          0: FlexColumnWidth(70),
                          1: FlexColumnWidth(50),
                          2: FlexColumnWidth(70),
                          3: FlexColumnWidth(50),
                          4: FlexColumnWidth(50),
                          5: FlexColumnWidth(50),
                        },
                        defaultVerticalAlignment:
                        TableCellVerticalAlignment.middle,
                        children: [
                          /// Table Header
                          TableRow(
                            children: [
                              tableHeader("Name"),
                              tableHeader("Designation"),
                              tableHeader("Gmail"),
                              tableHeader("Contact"),
                              tableHeader("Report"),
                              tableHeader("Chart Report"),
                            ],
                          ),
                          for (int i = 0;
                          i < finalEmpData.length;
                          i++)
                            tableRow(
                              context,
                              name:
                              "${finalEmpData[i].firstName} ${finalEmpData[i].lastName}",
                              color: Colors.blue,
                              image: finalEmpData[i].image,
                              designation:
                              finalEmpData[i].designation,
                              contact:
                              finalEmpData[i].contact,
                              gmail: finalEmpData[i].emailId,
                              status: finalEmpData[i].status,
                              isSelected:
                              finalEmpData[i].isSelected,
                              index: i,
                            ),
                        ],
                      ),
                    ),
                    //  getEmpTable(),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  Future<void> ApiEmpSearchData(String URL, int pNo,String query) async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    if(query=='') {
      ApiGetData('', selectedPageNumber);}
    isLoad = true;
    setState(() {});
    Dio dio = Dio();
    finalEmpData.clear();
    final response = await dio.get(
        ApiConstant.SEARCH_EMP + "?keyword=${query}",
        options: Options(headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      SearchEmpResponse searchEmpResponse =
      SearchEmpResponse.fromJson(jsonDecode(response.data));
      searchEmpResponse.data!.forEach((element) {
        finalEmpData.add(element.employeeDetails!);
      });
      isLoad = false;
      setState(() {});
    }
  }
  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total leads : ${emData.length}');
    finalEmpData.clear();
    debugPrint('Total leads : ${emData.length}');
    ApiEmpSearchData('',selectedPageNumber,query);
    /*emData.forEach((element) {
      if (element.firstName!.contains(query) ||
          element.mobileNumber!.contains(query) ||
          element.lastName!.contains(query)) {
        finalEmpData.add(element);
      }
    });*/
    debugPrint('Final Leads : ${finalEmpData.length}');
    setState(() {});
  }

  TableRow tableRow(context,
      {name,
      image,
      designation,
      status,
      color,
      contact,
      gmail,
      isSelected,
      required int index}) {
    return TableRow(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            getImage(image, height: 30.h, width: 30.w),
            SizedBox(
              width: 10,
            ),
            Text(
              name??"-",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      Text(
        designation??"-",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        gmail??"-",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        contact??"-",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w300,
        ),
      ),
      Container(
        width: 10.w,
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return Dialog(
                  alignment: Alignment.center,
                  backgroundColor: Colors.transparent,
                  insetAnimationDuration: Duration(milliseconds: 200),
                  insetAnimationCurve: Curves.easeOutExpo,
                  // <-- SEE HERE
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter setState) {
                    return _showDateWiseDialog(context, setState,index);
                  }),
                );
              },
            );
          },
         // child: Icon(Icons.download_for_offline,size: 20,color: Colors.blue,),
          child: Text(
            "View Report",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
              decoration: TextDecoration.underline

            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return Dialog(
                alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                insetAnimationDuration: Duration(milliseconds: 200),
                insetAnimationCurve: Curves.easeOutExpo,
                // <-- SEE HERE
                child: StatefulBuilder(builder:
                    (BuildContext context, StateSetter setState) {
                  return Container(
                    width: 450.w,
                    // height: 650.h,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 450.w,
                          padding: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.topRight,child: InkWell(
                          child: Icon(Icons.close,size: 20,),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),),
                        Align(alignment: Alignment.center,
                            child: CustomerGrpah(id: emData[index].id!,)),
                      ],
                    ),
                  );
                }),
              );
            },
          );
        },
        child: Text(
          "Chart Report",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w300,
              decoration: TextDecoration.underline
          ),
        ),
      ),
      /*Container(
        height: 27.h,
        width: 83.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected! ? Colors.amber.shade50 : Colors.blue.shade50),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            *//* Icon(Icons.download,size: 15,color: isSelected!?Colors.amber :Colors.blue),
                SizedBox(width: 10.w,),*//*

          ],
        ),
      )*/
    ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColor.black,
            fontSize: 15.sp),
      ),
    );
  }

  bool isLoad = false;
  Future<void> ApiGetData(String URL, int selectedPage) async {
    EasyLoading.show(status: "Loading");
    isLoad = true;
    setState(() {

    });
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    print("Token:" + token);
    LoginDeatils loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    var req = await http.get(
        Uri.parse(ApiConstant.GET_ALL_EMPLOYEE +
            "?organisationId=${loginDeatils.data!.organisationId}&page=${selectedPageNumber}&size=10"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        });
    var response = json.decode(req.body);
    /* final dio = Dio();
    final response = await dio.get(ApiConstant.BASE_URL+"/Employee/getAll",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${ApiConstant.token}',}));*/
    print(response);
    EasyLoading.dismiss();
    isLoad= false;
    if (req.statusCode == 200) {
      emData.clear();
      finalEmpData.clear();
      EmployeeListResponse employeeList =
          EmployeeListResponse.fromJson(jsonDecode(req.body));
      emData.addAll(employeeList.data!.content!);
      finalEmpData.addAll(employeeList.data!.content!);
      print('this is ${emData.length}');
      totalPages = employeeList.data!.totalPages!;
      totalElements = employeeList.data!.totalElements!;
      debugPrint("TotalPages:: ${totalPages}\n TotalRecord:: ${totalElements}");
      setState(() {});
    }
  }

  getHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Textview(
                  TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                  title: 'Pending Recruitment'),
              //  filterIcon(),
            ],
          ),
          SizedBox(
            height: 27.5.h,
          ),
        ],
      ),
    );
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
          color: Colors.black,
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        if (id == 0) {
          finalEmpData.sort((b, a) => b.firstName!.compareTo(a.firstName!));
          print('Sort by Name: ' + finalEmpData.toString());
          setState(() {});
        } else {
          finalEmpData.sort((a, b) => b.firstName!.compareTo(a.firstName!));
          print('Sort by Name: ' + finalEmpData.toString());
          setState(() {});
        }
      },
    );
  }

  int selectedPageNumber = 0;
  int totalPages = 0;
  int totalElements = 0;

  void getPrevPage(selectedPageNumer) {
    if (selectedPageNumber == 0) {
      ApiGetData("", selectedPageNumber);
    } else if (selectedPageNumber > 0) {
      selectedPageNumber--;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }

  void getNextPage(selectedPageNumer) {
    if (selectedPageNumber < totalPages - 1) {
      selectedPageNumber++;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }

  Future<void> getReportApiResponse(int index) async {
    EasyLoading.show(status: "Loading");
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    print("Token:" + token);
    String url = ApiConstant.DATEWISE_EMP_REPORT +
        "?organisationId=${loginDeatils.data!.organisationId}&startDate=${selectedFromDate}1&endDate=${selectedToDate}&employeeId=${emData[index].id}";
    print("MyUrl:"+url);
    var req = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        });

    EasyLoading.dismiss();
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      print(response);

      EmpReportModel empReportModel =
      EmpReportModel.fromJson(jsonDecode(req.body));

      Uint8List bytes = base64.decode(empReportModel.data!.report!);

      final blob = html.Blob([bytes],'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);



      await launchUrl(Uri.parse(url));



     /* EmpReportModel empReportModel =
          EmpReportModel.fromJson(jsonDecode(req.body));

      print('base 64 code : ${empReportModel.data!.report!}');

      //PdfService().downloadPdfReport(customersList);

      PdfDocument document =
          PdfDocument.fromBase64String(empReportModel.data!.report!.toString());

      List<int> byte = await document.save();
      AnchorElement(
          href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(byte)}")
        ..setAttribute("download", "report.pdf")
        ..click();

      //Dispose the document
      document.dispose();*/

      /*var base64 =empReportModel.data!.report!;
        var bytes = base64Decode(base64);
        final output = await getTemporaryDirectory();
      debugPrint("${output.path}/example.pdf");
        final file = File("${output.path}/example.pdf");
        await file.writeAsBytes(bytes.buffer.asUint8List());
        debugPrint("${output.path}/example.pdf");
        await OpenFilex.open("${output.path}/example.pdf");*/
    }

    setState(() {});
  }

  String selectedFromDate = '';
  String selectedToDate = '';

  Widget _buildText(
      BuildContext context, String label, String label1, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Text(
              label1,
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 52.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showDateWiseDialog(BuildContext context, StateSetter stateSetter, int index) {
    return Container(
      width: 350.w,
      height: 350.h,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close_rounded,size: 20,),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  child: _buildText(context, selectedFromDate, "Select From Date",
                      () async {
                    selectedFromDate =
                        await DateTimePickerDialog().pickBeforeDateDialog(context);
                    if (selectedFromDate == null) {
                      selectedFromDate = "Select From Date";
                    }
                    stateSetter(() {});
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 200.w,
                  child:
                      _buildText(context, selectedToDate, "Select To Date", () async {
                    selectedToDate =
                        await DateTimePickerDialog().pickDateDialog(context);
                    if (selectedToDate == null) {
                      selectedToDate = "Select To Date";
                    }
                    stateSetter(() {});
                  }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ThemeColor.red,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      getReportApiResponse(index);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
