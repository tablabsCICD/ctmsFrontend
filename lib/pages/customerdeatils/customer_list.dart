import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/post_lead.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_info.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
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
  @override
  _LeadDashboard createState() => _LeadDashboard();
}

class _LeadDashboard extends State<CustomerList> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _sourceofleadController = TextEditingController();
  TextEditingController _coordinatorController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  TextEditingController _typeOfBusinessController = TextEditingController();

  List<CustomerData> finalCustomerList = [];
  List<CustomerData> customerList = [];
  bool isLoad = false;
  late EmpData empData = EmpData();

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text(''),
          content: SingleChildScrollView(
            child: SizedBox(height: 1024.h, width: 408.w, child: addLead()),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData("",selectedPageNumber);
    getAllEmployee();
    super.initState();
  }

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total customer : ${customerList.length}');
    finalCustomerList.clear();
    debugPrint('Total leads : ${customerList.length}');
    customerList.forEach((element) {
      if(element.companyName!.contains(query) || element.mobileNumber!.contains(query)){
        finalCustomerList.add(element);
      }
    });
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
          HeaderWidget(onSearchTap: (value){filterSearchResults(value);},),
          Container(
            margin: EdgeInsets.all(33),
            child: Row(
              children: [
                Text(
                  'Customer Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
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
                    Visibility(
                      visible:false,
                      child: SizedBox(
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
                                  title: "Add Customer",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
                child: /* Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          // CountLeadWidget(),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          //LeadListData(title: 'All Leads',),
                          leadList(),
                          if (AppResponsive.isMobile(context)) ...{
                           // AddLead(),
                            addLead(),
                            SizedBox(
                              height: 20,
                            ),
                          },

                        ],
                      ),
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                          // AddLead(),
                            addLead(),
                            SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),
                    ),
                ],
              ),*/
                    leadList()),
          ),
        ],
      ),
    );
  }

  addLead() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  )),
              SizedBox(
                width: 5.w,
              ),
              Text(
                "Back",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "Add Customer",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Center(
              child: SvgPicture.asset('assets/upload_profile.svg',
                  height: 202.h, width: 202.w)),
          SizedBox(height: 16.h),
          _buildTextField(
              'First Name', 'Please enter your first name', _nameController),
          SizedBox(height: 16.h),
          _buildTextField(
              'Last Name', 'Please enter your last name', _nameController),
          SizedBox(height: 16.h),
          _buildTextField(
              'Email', 'Please enter your email ID', _emailController),
          SizedBox(height: 16.h),
          _buildTextField(
              'Phone', 'Please enter your phone number', _phoneController),
          SizedBox(height: 16.h),
          // _buildTextField('Name Coordinator', _coordinatorController),
          //   _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16.h),
          _buildTextField(
              'Project Name', 'Please select', _sourceofleadController),

          SizedBox(height: 16.h),

          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
          InkWell(
            onTap: _submitForm,
            child: Container(
              decoration: BoxDecoration(
                  color: ThemeColor.theme_blue,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label,
            hintText: hint,
            labelStyle: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w300),
            hintStyle: TextStyle(
                color: Color(0xffcccccc),
                fontSize: 13.sp,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    LoginDeatils loginDeatils =
        await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    SaveLeadRequest saveEmploye = SaveLeadRequest();
    saveEmploye.companyName = name;
    saveEmploye.coordinator = _coordinatorController.text;
    saveEmploye.emailId = email;
    saveEmploye.mobileNumber = phone;
    saveEmploye.address = _addressController.text;
    saveEmploye.sourceOfLead = _sourceofleadController.text;
    saveEmploye.typeOfBusiness = _typeOfBusinessController.text;
    saveEmploye.leadAssignedTo = empData.id;
    saveEmploye.leadAddedBy = loginDeatils.data!.id;
    EasyLoading.show(status: "Loading");
    Dio dio = Dio();
    //try{
    var response = await dio.post(ApiConstant.SAVE_LEAD,
        data: jsonEncode(saveEmploye.toJson()),options: Options(headers:{ "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',}));
    print('the body ${response.data}');
    if (response.statusCode == 200) {
      PostLead postLead = PostLead.fromJson(jsonDecode(response.data));
      Map<String, dynamic> parameter = {
        "date": GetDateFormat.getCurrentDate(),
        "lead": postLead.data!.id,
        "nextFollowUpBy": empData.id,
        "potential": "10",
        "status": "Pending",
        "updatedByUser": loginDeatils.data!.id,
        "description": " Lead Created "
      };
      var para = jsonEncode(parameter);
      var leadResponse =
          await dio.post(ApiConstant.SAVE_LEAD_UPDATe, data: para,options: Options(headers:{ "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',}));
      if (leadResponse.statusCode == 200) {
        print('done is done ');
      }
      ApiGetData("",selectedPageNumber);
    } else {
      ToastMessage.show(context, "Please try Again");
    }
    EasyLoading.dismiss();
    // }catch(e){
    //   EasyLoading.dismiss();
    // }
  }

  leadList() {
    return isLoad
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            /*decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20)),*/
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 15.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      title: "Customer",
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                      fontSize: 30.sp,
                    ),
                    Container(
                      width: 250.w,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){
                              getPrevPage(selectedPageNumber);
                            },
                                icon: Icon(Icons.arrow_back_ios,size: 16,)),
                            Text("Showing ${selectedPageNumber+1}-10 out of ${totalElements} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
                            GoogleFonts.poppins().fontFamily),),
                            IconButton(onPressed: (){
                              getNextPage(selectedPageNumber);
                            },
                                icon: Icon(Icons.arrow_forward_ios,size: 16,))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                /*  Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),*/
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(20),
                  child: finalCustomerList.isEmpty
                      ? Expanded(
                      child: Container(
                          height:
                          MediaQuery.of(context).size.height - 400,
                          child: Center(
                              child: TextView(
                                  title: "No Record Found",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900))))
                      :  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      /// Table Header
                      TableRow(
                        /*decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                  ),*/
                        children: [
                          tableHeader("Company Name"),
                          tableHeader("Type Of Business"),
                          tableHeader("Email"),
                          tableHeader("Contact"),
                          tableHeader(""),
                          /*if (!AppResponsive.isMobile(context))
                      tableHeader("Email"),
                    tableHeader("Assign to"),
                    if (!AppResponsive.isMobile(context)) tableHeader(""),*/
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
      {name, image, client, project, status, color, index, String? contact}) {
    return TableRow(
        decoration: BoxDecoration(
            /* border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),*/
            ),
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
                      title: name,
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300)
                ],
              ),
            ),
          ),

          TextView(
              title: client,
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: project,
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: contact.toString(),
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          InkWell(
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
    final response = await dio.get(ApiConstant.GET_ALL_CUSTMER+"?page=${pno}&size=10&sortBy=id&sortDir=asc",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    if (response.statusCode == 200) {
      CustomerListResponse employeeList =
          CustomerListResponse.fromJson(jsonDecode(response.data));
      customerList.clear();
      finalCustomerList.clear();
      customerList.addAll(employeeList.data!.content!);
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
      ToastMessage.show(context, "Please try Again");
    }
  }

  Widget _buildText(String label) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Employee'),
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
          child: Container(
            //margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), Icon(Icons.arrow_drop_down_outlined)],
            ),
          ),
        ),
      ),
    );
  }

  filterIcon() {
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
      String title, int? id,
      ) {
    return PopupMenuItem(
      child: Text(title),
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

  getAllEmployee() async {
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    Dio dio = Dio();
    final response = await dio.get(ApiConstant.BASE_URL + "api/Employee/getAll",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    if (response.statusCode == 200) {
      EmployeeListResponse employeeList =
          EmployeeListResponse.fromJson(jsonDecode(response.data));
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeList.data!.content!);
    }
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Constants.allEmployee.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // selectRole=dataRole[index].id!;
              // selectedRole=dataRole[index].name!;
              empData = Constants.allEmployee[index];
              Navigator.pop(context);
              setState(() {});
            },
            child: ListTile(
              title: Text(Constants.allEmployee[index].firstName! +
                  " " +
                  Constants.allEmployee[index].lastName!),
            ),
          );
        },
      ),
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
