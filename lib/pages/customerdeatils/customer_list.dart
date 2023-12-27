import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/customer_model.dart';
import 'package:flutter_hr_management/model/employee_model.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/post_lead.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_info.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/constants.dart';
import '../../model/request/save_lead.dart';
import '../../model/response/custmer_list.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/lead_list.dart';
import '../../utils/constant.dart';
import '../../utils/sharepreferences.dart';
import '../dashboard/widget/header_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerList extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  CustomerList(this.scaffoldKey);

  @override
  _CustomerDashboard createState() => _CustomerDashboard();
}

class _CustomerDashboard extends State<CustomerList> {

  List<Customer> finalCustomerList = [];
  List<Customer> customerList = [];
  bool isLoad = false;
  late EmployeeData empData = EmployeeData();

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetail();
    ApiGetData("",selectedPageNumber);
    super.initState();
  }

  LoginDeatils? loginDeatils;
  Future<void> getLoginDetail() async {
    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
  }

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total customer : ${customerList.length}');
    finalCustomerList.clear();
    debugPrint('Total leads : ${customerList.length}');
    ApiCustomerSearchData('', selectedPageNumber, query);
    debugPrint('Final Customer : ${finalCustomerList.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.baground,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          /// Header Part
          HeaderWidget(scaffoldKey:widget.scaffoldKey,isSearchVisible:true,onSearchTap: (value){filterSearchResults(value);},),
          Container(
            margin: EdgeInsets.only(top:33,left: 33,right: 33,bottom: 10),
            child: Row(
              children: [
                Text(
                  'Customer Data',
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

                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
                child:
                    leadList()),
          ),
        ],
      ),
    );
  }



  leadList() {
    return Container(
            /*decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20)),*/
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 15.w,right: 15.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Container(
                      width: 300.w,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(onTap: (){
                              getPrevPage(selectedPageNumber);
                            },
                                child: Icon(Icons.arrow_back_ios,size: 16,)),
                            Text("Showing ${selectedPageNumber+1}-10 out of ${totalElements} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
                            GoogleFonts.poppins().fontFamily),),
                            InkWell(onTap: (){
                              getNextPage(selectedPageNumber);
                            },
                                child: Icon(Icons.arrow_forward_ios,size: 16,))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25.h,
                ),
                isLoad
                    ? Container(
                  margin: EdgeInsets.only(left: 15.w,right: 15.w),
                  height: MediaQuery.of(context).size.height - 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    :  Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  child: finalCustomerList.isEmpty
                      ? Container(
                          height:
                          MediaQuery.of(context).size.height - 400,
                          child: Center(
                              child: TextView(
                                  title: "No Record Found",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)))
                      :  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(

                        children: [
                          tableHeader("Company Name"),
                          tableHeader("Type Of Business"),
                          tableHeader("Email"),
                          tableHeader("Contact"),
                          tableHeader("Date"),
                          loginDeatils!.data!.isAdmin==true?tableHeader(""):SizedBox.shrink(),

                        ],
                      ),

                      /// Table Data

                      for (int i = 0; i < finalCustomerList.length; i++)
                        tableRow(context,
                            name: finalCustomerList[i].companyName,
                            color: Colors.blue,
                            image: "assets/user1.jpg",
                            client: finalCustomerList[i].typeOfBusiness,
                            project: finalCustomerList[i].emailId,
                            contact: finalCustomerList[i].mobileNumber,
                            date:finalCustomerList[i].date,
                            // status: emData[i].lead!.leadAssignedTo!.firstName!+" "+emData[i].lead!.leadAssignedTo!.lastName!,
                            status: finalCustomerList[i].leadconvertedByEmployee,
                            index: i),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  TableRow tableRow(context,
      {name, image, client, project, status, color, index, String? contact,String? date}) {
    return TableRow(

        children: [
          //Full Name
          InkWell(
            onTap: () {
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerInfo(leadData: emData[index],)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  getImage('',height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10,
                  ),
                  TextView(
                      title: name??"-",
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300)
                ],
              ),
            ),
          ),

          TextView(
              title: client??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: project??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: contact.toString()??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: date.toString()??"-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          loginDeatils!.data!.isAdmin==false?SizedBox.shrink():InkWell(
              onTap: () {
                callDelete(index);
              },
              child: Icon(Icons.delete, color: Colors.red)),
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(
          title: text,
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w900),
    );
  }

  Future<void> ApiGetData(String URL,int pno) async {
    isLoad = true;
    setState(() {});
    final dio = Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    final response = await dio.get(ApiConstant.GET_ALL_CUSTMER+"?organisationId=${loginDeatils!.data!.organisationId}&page=${pno}&size=10&sortBy=id&sortDir=asc",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    isLoad = false;
    setState(() {

    });
    customerList.clear();
    finalCustomerList.clear();
    if (response.statusCode == 200) {
      if(response.data["data"]!=""){
        CustomerListResponse employeeList =
        CustomerListResponse.fromJson(jsonDecode(response.data));
        customerList.addAll(employeeList.data!.content!);
        finalCustomerList.addAll(employeeList.data!.content!);
        print('this is ${finalCustomerList.length}');
        totalPages = employeeList.data!.totalPages!;
        totalElements = employeeList.data!.totalElements!;
        debugPrint("TotalPages:: ${totalPages}\n TotalRecord:: ${totalElements}");
      }else{
     }

    }
    setState(() {});

  }

  Future<void> ApiCustomerSearchData(String URL,int pno,String query) async {
    if(query=='') {ApiGetData('', selectedPageNumber);}
    isLoad = true;
    setState(() {});
    final dio = Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    final response = await dio.get(ApiConstant.SEARCH_CUSTMER+"?page=${pno}&size=10&sortBy=id&searchByKeyword=${query}&sortDir=asc",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    if (response.statusCode == 200) {
      CustomerListResponse employeeList =
      CustomerListResponse.fromJson(jsonDecode(response.data));
      finalCustomerList.clear();
      finalCustomerList.addAll(employeeList.data!.content!);
      print('this is ${finalCustomerList.length}');
      totalPages = employeeList.data!.totalPages!;
      totalElements = employeeList.data!.totalElements!;
      debugPrint("TotalPages:: ${totalPages}\n TotalRecord:: ${totalElements}");
      isLoad = false;
      setState(() {});
    }
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
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    Dio dio = Dio();
    var response = await dio.delete(ApiConstant.LEAD_DELTEB,
        queryParameters: {"id": finalCustomerList[index].id},options: Options(headers:{ "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',}));
    if (response.statusCode == 200) {
      finalCustomerList.removeAt(index);
      setState(() {});
    } else {
    //  ToastMessage.show(context, "Please try Again");
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
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
                icon:  SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {

                },
                itemBuilder: (ctx) => [
                  _buildPopupMenu('Sort By Name A to Z',0),
                  _buildPopupMenu('Sort By Name Z to A',1),
                ],
              ),
              Text(
                "Filter",
                style:TextStyle(
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
      String title, int? id,
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: (){
        if(id==0) {
          finalCustomerList.sort((b, a) => b.companyName!.compareTo(a.companyName!));
          setState(() {});
        }else{
          finalCustomerList.sort((a, b) => b.companyName!.compareTo(a.companyName!));
          setState(() {});
        }
      },
    );
  }



  leadCountCard(
    String title,
    String count,
    String img,
    bool isSelected,
    Color bgColor,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = true;
        });
      },
      child: Container(
        width: 243.w,
        height: 166.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: isSelected ? Color(0xFFC3262C) : Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 89.w,
              height: 89.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: CircleBorder(),
              ),
              child: SvgPicture.asset(
                Images.emp_tot,
                height: 50.h,
                width: 50.w,
              ),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                    title: count,
                    fontSize: 35.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600),
                TextView(
                    title: title,
                    fontSize: 20.sp,
                    color: Color(0xff6C6C6C),
                    fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }

  int selectedPageNumber = 0;
  int totalPages = 0;
  int totalElements = 0;
  void getPrevPage(selectedPageNumer) {
    if(selectedPageNumber==0){
      ApiGetData("", selectedPageNumber);
    }else
    if(selectedPageNumber>0) {
      selectedPageNumber--;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }
  void getNextPage(selectedPageNumer) {
    if(selectedPageNumber<totalPages-1) {
      selectedPageNumber++;
      ApiGetData("", selectedPageNumber);
      setState(() {});
    }
  }

}
