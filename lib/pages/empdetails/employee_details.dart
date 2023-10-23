import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/constants.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/roles.dart';
import 'package:flutter_hr_management/pages/empdetails/add_employee.dart';
import 'package:flutter_hr_management/pages/empdetails/emp_info.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
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
  TextEditingController _inStockController = TextEditingController();
  TextEditingController _costPriceController = TextEditingController();
  TextEditingController _sellingPriceController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
TextEditingController _vendorController = TextEditingController();
  TextEditingController _lowStockController = TextEditingController();


  List<EmpData>emData=[];
  List<EmpData>temEmData=[];

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
          HeaderWidget(title: "Medical Stock"),
         Container(
           margin: EdgeInsets.all(30),
           child: Row(
             children: [
               Text(
                 'Medical Stock',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 30.sp,
                   fontFamily:GoogleFonts.poppins().fontFamily,
                   fontWeight: FontWeight.w600,
                   height: 0,
                 ),
               ),
               Spacer(),
               SizedBox(
                 height: 58.h,
                 width: 180.w,
                 child: ElevatedButton(
                     onPressed: (){
                       _showAlertDialog();
                     },
                     style: ElevatedButton.styleFrom(
                         primary: ThemeColor.red,
                         onPrimary: Colors.white
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.add_circle,size:18,),
                         SizedBox(width: 6.w,),
                         TextView(
                           title: "Add Products",
                           fontSize: 16.sp,
                           fontWeight: FontWeight.w400, color: Colors.white,
                         ),
                       ],
                     )),
               ),
               SizedBox(width: 18.w,)
             ],
           ),
         ),
          Container(
           // margin: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(width: 38.w,),
                empCounts("${emData.length}","Out of stock product",Icons.medical_information,Color(0xFFEAF8F4)),
                SizedBox(width: 38.w,),
                empCounts("10","Product on low stock",Icons.medical_information,Color(0xFFFFEDF9)),
                SizedBox(width: 38.w,),
                empCounts("16","Number of products to be arrived",Icons.medical_information,Color(0xFFFEF0E5)),
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
              "Product List",
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


  empdeatils(){
    return isLoad?Center(child: CircularProgressIndicator(),) :Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(5)),
     // padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
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
              columnWidths: {
                0: FlexColumnWidth(50),
                1: FlexColumnWidth(30),
                2: FlexColumnWidth(30),
                3: FlexColumnWidth(30),
                4: FlexColumnWidth(60),
                5: FlexColumnWidth(20),
              },
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
                    tableHeader("In Stock"),
                    if (!AppResponsive.isMobile(context))  tableHeader("Cost Price"),
                    if (!AppResponsive.isMobile(context)) tableHeader("Selling Price"),
                    if (!AppResponsive.isMobile(context)) tableHeader("Notes"),
                    tableHeader(""),
                  ],
                ),

                /// Table Data

                for (int i=0;i<5;i++)  tableRow(
                  context,
                  name: "Azithromycin 250 mg",
                  image: '',
                  inStock:'45',
                  costPrice: '1135',
                  sellingPrice: '1250',
                  index: i,
                  notes: 'Azithromycin is used to treat certain bacterial infections.'
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
      ),
    );
  }


  TableRow tableRow(context, {name, image, inStock, costPrice, sellingPrice,index,notes}) {
    return TableRow(

        children: [
          //Full Name
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EmpInfo(empData: emData[index])));
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
                 // getImage('assets/azi.jpeg',height: 30.h,width: 30.w),
                  CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/azi2.jpeg',)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Center(child: Text(name,style: tableRowStyle()))
                ],
              ),
            ),
          ),
          // Designation
          Center(child: Text(inStock,style: tableRowStyle(),)),
          if (!AppResponsive.isMobile(context)) Center(child: Text(costPrice,style: tableRowStyle(),)),
          if (!AppResponsive.isMobile(context)) Center(child: Text(sellingPrice,style: tableRowStyle())),
          if (!AppResponsive.isMobile(context)) Text(notes,style: tableRowStyle(),),
          Center(child: Icon(Icons.more_vert)),
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
      temEmData.addAll(employeeList.data!);

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


  empCounts(String totCount,String name,IconData image,Color color){
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
              name,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 75.w,
                  height: 75.h,
                  decoration: ShapeDecoration(
                    color: color,//Color(0xFFEAF8F4)
                    shape: CircleBorder(),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                 //   child: SvgPicture.asset(image,height: 10.h,width: 10.w,),
                    child: Icon(image,size: 25,color: Colors.grey,),
                  ),
                ),
              ),
              Text(
                totCount,
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                ),


              ),
            ],
          )
        ],
      ),
    );
  }


  editEmp(int index) async{
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,// <-- SEE HERE
          title: const Text(''),
          content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {

            return SingleChildScrollView(
              child: Container(
                  color: Colors.transparent,
                  height: 1024.h,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: Colors.transparent,
                          width: 408.w,
                          child: AddEmployee(empData: emData[index],),
                        ),
                      )
                    ],
                  )
              ),
            );
          }),
        );
      },
    );
    ApiGetData("");
  }

  void onFilter(String value) {
    // if(value.length>2){
    //   emData.clear();
    //   for(int i=0;i<temEmData.length;i++){
    //     if(temEmData[i].firstName!.contains(value)==0){
    //       emData.add(temEmData[i]);
    //     }
    //   }
    // }else{
    //   emData.clear();
    //   emData.addAll(temEmData);
    // }

    emData.addAll(temEmData);

    setState(() {

    });

  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,// <-- SEE HERE
          scrollable: true,
          content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: addProduct(setState),
                    )
                  ],
                )
            );
          }),
        );
      },
    );


  }

  addProduct(StateSetter setState) {
    return Container(
      width: 450.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios,size: 16,)),
              SizedBox(width: 5.w,
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
              "Add Product",
              style: TextStyle(
                fontFamily:
                GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
                fontSize: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Center(
            child: CircleAvatar(
                radius: 100.r,
                backgroundImage: AssetImage('assets/azi2.jpeg',)),
          ),
          SizedBox(height: 16.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _buildTextField('Name','', _nameController),
              SizedBox(height: 16.h),
              _buildTextField('Quantity In stock','1200', _inStockController),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:200.w,child: _buildTextField('Low stock warning','100', _lowStockController),),
                  SizedBox(width:200.w,child: _buildTextField('Expiry Date','10/10/2025', _lowStockController),),

                ],
              ),

              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width:200.w,child: _buildTextField('Cost Price(1 item)','1134', _costPriceController)),
                  SizedBox(width:200.w,child: _buildTextField('Selling Price(1 item)','1250', _sellingPriceController)),

                ],
              ),
              _buildTextField('Preferred Vendor', 'Please select',_vendorController),

              SizedBox(height: 16.h),
              _buildTextField('Notes',"Enter additional notes" ,_notesController),
             /* ElevatedButton(
                onPressed: _submitForm,
                child: Center(child: Text('Submit')),
              ),*/
              SizedBox(height: 16.h),
              InkWell(
               // onTap: _submitForm,
                child: Container(
                  decoration: BoxDecoration(
                      color: ThemeColor.red,
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Text(
                      "Add Product",
                      style: TextStyle(fontSize: 20.sp,fontFamily:
                      GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.w500, color: AppColor.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildText(String label, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.r),
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
    );
  }

  Widget _buildTextField(String label, String hint,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(label,style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w300,),),
        ),
        SizedBox(height: 10.h,),
        SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Color(0xff1B1B1B),fontSize: 15.sp,fontWeight: FontWeight.w500,),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xffcccccc),fontSize: 13.sp,fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

}