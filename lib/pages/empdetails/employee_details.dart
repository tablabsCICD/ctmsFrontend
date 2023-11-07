import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/roles.dart';
import 'package:flutter_hr_management/pages/empdetails/add_employee.dart';
import 'package:flutter_hr_management/pages/empdetails/emp_info.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/request/save_emp.dart';
import '../../model/response/employeelist.dart';
import '../../utils/constant.dart';
import '../dashboard/widget/header_widget.dart';
import '../widget/filter_button.dart';

class EmpDashboard extends StatefulWidget {
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


  List<EmpData>finalEmData=[];
  List<EmpData>empData=[];
  List<EmpData>activeEmpData=[];
  List<EmpData>inActiveEmpData=[];
  bool isLoad=false;
  List<RoleData>dataRole=[];
  int selectRole=0;
  String selectedRole="Select Role";

  @override
  void initState() {
    // TODO: implement initState
    ApiGetDataDashbord("",selectedPageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.baground,
      child: Column(
        children: [
         HeaderWidget(onSearchTap: (value){filterSearchResults(value);},),
         Container(
           margin: EdgeInsets.all(30),
           child: Row(
             children: [
               Text(
                 'Employee Data',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 30.sp,
                   fontFamily:GoogleFonts.poppins().fontFamily,
                   fontWeight: FontWeight.w600,
                   height: 0,
                 ),
               ),
               Spacer(),
               filterIcon(),
               SizedBox(width: 18,)
             ],
           ),
         ),
          Container(
            child: Row(
              children: [
                SizedBox(width: 38.w,),
                empCounts("${totalElements}","Total Employee",Images.emp_tot,Color(0xFFEAF8F4),true),
                SizedBox(width: 38.w,),
                empCounts("${activeEmpData.length}","Active Employee",Images.emp_tot,Color(0xFFFFEDF9),false),
                SizedBox(width: 38.w,),
                empCounts("${inActiveEmpData.length}","Inactive Employee",Images.emp_tot,Color(0xFFFEF0E5),false),
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
                  selectedEmpList=="Total"?"Employee List":selectedEmpList=="Active"?"Active Employees":"InActive Employees",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                    fontSize: 30.sp,
                    fontFamily:GoogleFonts.poppins().fontFamily,
                  ),
                ),
                Container(
                  width: 250.w,
                  height: 50.h,
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
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 30,right: 38),
              child: isLoad?Center(child: CircularProgressIndicator(),) :Container(
               // height: 350,
                decoration: BoxDecoration(
                    color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      finalEmData.isEmpty
                          ? Expanded(
                          child: Container(
                              height:
                              MediaQuery.of(context).size.height - 600,
                              child: Center(
                                  child: TextView(
                                      title: "No Record Found",
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900))))
                          : Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          /// Table Header
                          TableRow(
                            children: [
                              tableHeader("Name"),
                              if (!AppResponsive.isMobile(context))
                                tableHeader("Designation"),
                              tableHeader("Mail"),
                              tableHeader("Contact"),
                              if (!AppResponsive.isMobile(context)) tableHeader(""),
                            ],
                          ),
                          for (int i=0;i<finalEmData.length;i++)  tableRow(
                              context,
                              name: finalEmData[i].firstName!+" "+finalEmData[i].lastName!,
                              color: Colors.blue,
                              image: finalEmData[i].image,
                              designation: finalEmData[i].designation,
                              status: finalEmData[i].mobileNumber,
                              index: i,
                              email: finalEmData[i].emailId
                          ),
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

  void filterSearchResults(String query) {
    debugPrint('Query : $query \n Total leads : ${empData.length}');
    finalEmData.clear();
    debugPrint('Total leads : ${empData.length}');
    empData.forEach((element) {
      if(element.firstName!.contains(query) || element.mobileNumber!.contains(query)){
        finalEmData.add(element);
      }
    });
    debugPrint('Final Leads : ${finalEmData.length}');
    setState(() {});
  }


  EmployeeListResponse? employeeListResponse;
  Future<void> ApiGetDataDashbord(String URL,int pNo) async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    isLoad=true;
    setState(() {
    });
    Dio dio = Dio();
    var roleResponse =await dio.get(ApiConstant.GET_ALL_ROLES,options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));

    if(roleResponse.statusCode==200){
      RoleResponse role=RoleResponse.fromJson(jsonDecode(roleResponse.data));
      dataRole.addAll(role!.data!);
      print('the data is ${dataRole.length}');
    }

    final response = await dio.get(ApiConstant.BASE_URL+"api/Employee/getByPages?page=${pNo}&size=10",options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    print(response.data);
    if(response.statusCode==200){
      employeeListResponse =EmployeeListResponse.fromJson(jsonDecode(response.data));
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
      isLoad=false;
      setState(() {
      });
    }
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
                  _buildPopupMenuItem('Sort By Name A to Z',0),
                  _buildPopupMenuItem('Sort By Name Z to A',1),
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

  PopupMenuItem _buildPopupMenuItem(
      String title, int? id,
      ) {
    return PopupMenuItem(
      child: Text(title),
      onTap: (){
        if(id==0) {
          finalEmData.sort((b, a) => b.firstName!.compareTo(a.firstName!));
          setState(() {});
        }else{
          finalEmData.sort((a, b) => b.firstName!.compareTo(a.firstName!));
          setState(() {});
        }
      },
    );
  }

  addemp() {
    return  Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(
            "Add New Employee",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          SizedBox(height: 16),
          _buildTextField('Frist Name', _nameController),
          SizedBox(height: 16),
          _buildTextField('Last Name', _lastnameController),
          SizedBox(height: 16),
          _buildTextField('Email', _emailController),
          SizedBox(height: 16),
          _buildTextField('Phone', _phoneController),
          /*Row(
            children: [
              Expanded(
                child: _buildTextField('Email', _emailController),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField('Phone', _phoneController),
              ),
            ],
          ),*/
          SizedBox(height: 16),
          _buildTextField('Address', _addLeadController),
          SizedBox(height: 16),
          _buildTextField('Password', _passwordController),
          SizedBox(height: 16),
          _buildText(selectedRole),
          SizedBox(height: 16),

          InkWell(
            onTap: _submitForm,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.yellow,
                  borderRadius: BorderRadius.circular(100)),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.black),
                ),
              ),
            ),
          )
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
      onTap: (){
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
            child: Text(
              label
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async{
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    String addLead = _addLeadController.text.toString();
    String lastName=_lastnameController.text.toString();
    SaveEmploye saveEmploye=SaveEmploye();
    saveEmploye.firstName=name;
    saveEmploye.lastName=lastName;
    saveEmploye.os="Web";
    saveEmploye.emailId=email;
    saveEmploye.address=addLead;
    saveEmploye.mobileNumber=phone;
    saveEmploye.role=selectRole;
    saveEmploye.password=_passwordController.text;
    Dio dio=Dio();
    var response=await dio.post(ApiConstant.SAVE_EMP,data: jsonEncode(saveEmploye.toJson()),options: Options(headers:{ "Content-Type": "application/json",
    'Authorization': 'Bearer ${token}',}));
    if(response.statusCode==200){
     setState(() {
       ApiGetDataDashbord("",selectedPageNumber);
     });
    }else{
      ToastMessage.show(context, "Not Added Sucessfully");
    }
  }

  empdeatils(){
    return isLoad?Center(child: CircularProgressIndicator(),) :Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              /// Table Header
              TableRow(
                children: [
                  tableHeader("Name"),
                  if (!AppResponsive.isMobile(context))
                    tableHeader("Designation"),
                  tableHeader("Mail"),
                  tableHeader("Contact"),
                  if (!AppResponsive.isMobile(context)) tableHeader(""),
                ],
              ),
              for (int i=0;i<finalEmData.length;i++)  tableRow(
                context,
                name: finalEmData[i].firstName!+" "+finalEmData[i].lastName!,
                color: Colors.blue,
                image: finalEmData[i].image,
                designation: finalEmData[i].designation,
                status: finalEmData[i].mobileNumber,
                index: i,
                email: finalEmData[i].emailId
              ),

            ],
          ),

        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, designation, status, color,index,email}) {
    return TableRow(

        children: [
          //Full Name
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EmpInfo(empData: finalEmData[index])));
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
                  getImage(image,height: 30.h,width: 30.w),
                  SizedBox(
                    width: 10.w,
                  ),
                  Center(child: Text(name,style: tableRowStyle()))
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Center(child: Text(designation,style: tableRowStyle(),)),
          if (!AppResponsive.isMobile(context)) Center(child: Text(email,style: tableRowStyle())),
          Center(child: Text(status,style: tableRowStyle())),
          // Menu icon
            Row(
              children: [

                InkWell(
                  onTap: (){
                    editEmp(index);

                  },
                  child: Icon(Icons.edit,size: 20,color: Colors.grey,),
                ),
                SizedBox(width: 7,),
                InkWell(
                  onTap: (){

                    showAlertDialog(context,index);
                  },
                  child: Icon(Icons.delete,size: 20,color: Colors.red,),
                ),


              ],
            )
        ]);
  }

  TextStyle tableRowStyle(){
    return TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
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
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 18.sp),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async{
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
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void callDelete(int index) async{
    Dio dio=Dio();
    String token = await LocalSharePreferences()
        .getString(SharedPreferencesConstant.AuthToken);
    var response=await dio.delete(ApiConstant.EMP_DELTEB,queryParameters: {"id":finalEmData[index].id},options: Options(headers:{ "Content-Type": "application/json",
      'Authorization': 'Bearer ${token}',}));
    if(response.statusCode==200){
      finalEmData.removeAt(index);
      empData.remove(index);
      setState(() {
      });
      ApiGetDataDashbord("",selectedPageNumber);
    }else{
      ToastMessage.show(context, "Please try Again");
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
            onTap: (){
              selectRole=dataRole[index].id!;
              selectedRole=dataRole[index].name!;
              Navigator.pop(context);
              setState(() {
              });
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

  empCounts(String totCount,String name,String image,Color color, bool isSelected){
    return InkWell(
      onTap: (){
        if(name=="Active Employee"){
          finalEmData.clear();
          finalEmData.addAll(activeEmpData);
          selectedEmpList = "Active";
        }else if(name=="Inactive Employee"){
          finalEmData.clear();
          finalEmData.addAll(inActiveEmpData);
          selectedEmpList = "InActive";
        }else{
          finalEmData.clear();
          finalEmData.addAll(empData);
          selectedEmpList = "Total";
        }
        setState(() {
        });
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
                  color: color,//Color(0xFFEAF8F4)
                  shape: CircleBorder(),

                ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(image,height: 10.h,width: 10.w,),
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
                Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  editEmp(int index) async{
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
    ApiGetDataDashbord("",selectedPageNumber);
  }

  int selectedPageNumber = 0;
  int totalPages = 0;
  int totalElements = 0;
  void getPrevPage(selectedPageNumer) {
    if(selectedPageNumber==0){
      ApiGetDataDashbord("", selectedPageNumber);
    }else
    if(selectedPageNumber>0) {
      selectedPageNumber--;
      ApiGetDataDashbord("", selectedPageNumber);
      setState(() {});
    }
  }
  void getNextPage(selectedPageNumer) {
    if(selectedPageNumber<totalPages-1) {
      selectedPageNumber++;
      ApiGetDataDashbord("", selectedPageNumber);
      setState(() {});
    }
  }
}