import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/roles.dart';
import 'package:flutter_hr_management/pages/empdetails/emp_info.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
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


  List<EmpData>emData=[];

  bool isLoad=false;
  List<RoleData>dataRole=[];
  int selectRole=0;
  String selectedRole="Select Role";

  @override
  void initState() {
    // TODO: implement initState
    ApiGetDataDashbord("");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.baground,
    

      child: Column(
        children: [
          /// Header Part
          HeaderWidget(title: "Employee Data",),
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
               filterIconButton(),
               SizedBox(width: 18,)
             ],
           ),
         ),
          Container(
           // margin: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(width: 38.w,),
                empCounts("10","Total Employee",Images.emp_tot,Color(0xFFEAF8F4)),
                SizedBox(width: 38.w,),
                empCounts("10","Active Employee",Images.emp_tot,Color(0xFFFFEDF9)),
                SizedBox(width: 38.w,),
                empCounts("10","Inactive Employee",Images.emp_tot,Color(0xFFFEF0E5)),
              ],
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //
          //         Expanded(
          //           flex: 1,
          //           child: Container(
          //             child: Column(
          //               children: [
          //                 // CountCardWidget(),
          //                 // SizedBox(
          //                 //   height: 20,
          //                 // ),
          //                 //EmpListData(title: 'All Employee',),
          //                 empdeatils(),
          //                 if (AppResponsive.isMobile(context)) ...{
          //                   //AddEmployee(),
          //
          //                  // addemp(),
          //                   SizedBox(
          //                     height: 20,
          //                   ),
          //                 },
          //
          //               ],
          //             ),
          //           ),
          //         ),
          //         if (!AppResponsive.isMobile(context))
          //           Expanded(
          //             child: Container(
          //               margin: EdgeInsets.symmetric(horizontal: 10),
          //               child: Column(
          //                 children: [
          //                 // AddEmployee(),
          //
          //                  // addemp(),
          //                   SizedBox(
          //                     height: 20,
          //                   ),
          //
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(30),
            child: Text(
              "Employee List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 30.sp,
                fontFamily:GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30,right: 38),
            child: empdeatils(),),
        ],
      ),
    );
  }

  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  late String? _selectedLocation;

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
    var response=await dio.post(ApiConstant.SAVE_EMP,data: jsonEncode(saveEmploye.toJson()));
    if(response.statusCode==200){
     setState(() {
       ApiGetData("");
     });
    }else{
      ToastMessage.show(context, "Not Added Sucessfully");
    }

  }
  empdeatils(){
    return isLoad?Center(child: CircularProgressIndicator(),) :Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(5)),
     // padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //
          //     Container(
          //       decoration: BoxDecoration(
          //           color: AppColor.yellow,
          //           borderRadius: BorderRadius.circular(100)),
          //       padding: EdgeInsets.symmetric(
          //         vertical: 10,
          //         horizontal: 20,
          //       ),
          //       child: Text(
          //         "View All",
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, color: AppColor.black),
          //       ),
          //     )
          //   ],
          // ),
          // Divider(
          //   thickness: 0.5,
          //   color: Colors.grey,
          // ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              /// Table Header
              TableRow(
                // decoration: BoxDecoration(
                //   border: Border(
                //       bottom: BorderSide(
                //         color: Colors.grey,
                //         width: 0.5,
                //       )),
                // ),
                children: [
                  tableHeader("Name"),
                  if (!AppResponsive.isMobile(context))
                    tableHeader("Designation"),
                  tableHeader("Mail"),
                  tableHeader("Contact"),
                  if (!AppResponsive.isMobile(context)) tableHeader(""),
                ],
              ),

              /// Table Data

              for (int i=0;i<emData.length;i++)  tableRow(
                context,
                name: emData[i].firstName!+" "+emData[i].lastName!,
                color: Colors.blue,
                image: "assets/img.png",
                designation: emData[i].role!.name!,
                status: emData[i].mobileNumber,
                index: i,
                email: emData[i].emailId
              ),

            ],
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Showing ${emData.length} out of ${emData.length} Results"),
          //       Text(
          //         "View All",
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }


  TableRow tableRow(context, {name, image, designation, status, color,index,email}) {
    return TableRow(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        children: [
          //Full Name
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EmpInfo(empData: emData[index])));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Image.asset(
                      image,
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
          if (!AppResponsive.isMobile(context))
            InkWell(
              onTap: (){

                showAlertDialog(context,index);
              },
              child: Icon(Icons.delete,size: 30,color: Colors.red,),
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

  Future<void> ApiGetData(String URL) async{
    isLoad=true;
    setState(() {
    });
    final dio = Dio();
    final response = await dio.get(ApiConstant.BASE_URL+"/Employee/getAll");
    print(response.data);
    if(response.statusCode==200){
      EmployeeList employeeList =EmployeeList.fromJson(jsonDecode(response.data));
      emData.clear();
      emData.addAll(employeeList.data!);

      isLoad=false;
      setState(() {
      });
    }
  }

  Future<void> ApiGetDataDashbord(String URL) async{
    isLoad=true;
    setState(() {
    });
    Dio dio = Dio();
   var roleResponse =await dio.get(ApiConstant.GET_ALL_ROLES);

    if(roleResponse.statusCode==200){
     RoleResponse role=RoleResponse.fromJson(jsonDecode(roleResponse.data));
     dataRole.addAll(role!.data!);
     print('the data is ${dataRole.length}');
    }
    final response = await dio.get(ApiConstant.BASE_URL+"Employee/getAll");
    print(response.data);
    if(response.statusCode==200){
      EmployeeList employeeList =EmployeeList.fromJson(jsonDecode(response.data));
      emData.clear();
      emData.addAll(employeeList.data!);
      //print('this is ${emData.length}');
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeList.data!);
      isLoad=false;
      setState(() {
      });
    }
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
    var response=await dio.delete(ApiConstant.LEAD_DELTEB,queryParameters: {
      "id":emData[index].id
    });
    if(response.statusCode==200){
      emData.removeAt(index);
      setState(() {
      });
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


  empCounts(String totCount,String name,String image,Color color){
    return Container(
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
                shape: OvalBorder(),

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
    );
  }
}