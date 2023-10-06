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
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/constants.dart';
import '../../model/request/save_lead.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/lead_list.dart';
import '../../utils/constant.dart';
import '../../utils/image_upload.dart';
import '../../utils/sharepreferences.dart';
import '../dashboard/widget/header_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/employee_dialog.dart';
import '../widget/one_emp_dilaog.dart';

class LeadDashboard extends StatefulWidget {
  @override
  _LeadDashboard createState() => _LeadDashboard();
}

class _LeadDashboard extends State<LeadDashboard> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _sourceofleadController = TextEditingController();
  TextEditingController _coordinatorController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _typeOfBusinessController = TextEditingController();



  TextEditingController _editnameController = TextEditingController();
  TextEditingController _editemailController = TextEditingController();
  TextEditingController _editphoneController = TextEditingController();
  TextEditingController _editsourceofleadController = TextEditingController();
  TextEditingController _editcoordinatorController = TextEditingController();
  TextEditingController _editaddressController = TextEditingController();
  TextEditingController _edittypeOfBusinessController = TextEditingController();

  List<LeadData>emData=[];
  bool isLoad=false;
  late EmpData empData =EmpData();
  int selectedEmp=0;
  int editselectedEmp=0;

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
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
                          child: addLead(setState),
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


  }

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData("");
    getAllEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          /// Header Part
          HeaderWidget(title: "Lead Data",),
          Container(
            margin: EdgeInsets.all(33),
            child: Row(
              children: [
                Text(
                  'Lead Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontFamily:GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    filterIconButton(),
                    SizedBox(width: 27.w,),
                    SizedBox(
                      height: 58.h,
                      width: 180.w,
                      child: ElevatedButton(
                          onPressed: (){
                            _showAlertDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ThemeColor.theme_blue,
                            onPrimary: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle,size:18,),
                              SizedBox(width: 6.w,),
                              TextView(
                               title: "Add Lead",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400, color: Colors.white,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 33.w,vertical: 20.h),
            child: Row(
              children: [
                leadCountCard('Total Lead','700','',true,Colors.green.shade50),
                SizedBox(width: 32.w,),
                leadCountCard('Converted','300','',false,Colors.red.shade50),
                SizedBox(width: 32.w,),
                leadCountCard('Rejected','200','',false,Colors.orange.shade50),
                SizedBox(width: 32.w,),
                leadCountCard('Pending','200','',false,Colors.blue.shade50),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child:/* Row(
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
              leadList()
            ),
          ),
        ],
      ),
    );
  }


  addLead(StateSetter stateSetter){
    return Container(
      width: 408.w,
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
              "Add Lead",
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
          Center(child: InkWell(onTap:(){
           // ImageUpload().postImage(context);
    },child: SvgPicture.asset('assets/upload_profile.svg',height: 202.h,width:202.w))),
          SizedBox(height: 16.h),
          _buildTextField('Company Name','Please Comapny name', _nameController),
          SizedBox(height: 16.h),
          _buildText('${selectedEmp==0?"Select Employee ":"One Employee Selected"}', () async {
            int list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialogOne();
                });
           // print('the list is ${list}');
            selectedEmp=list;
            print('the list is$selectedEmp');
            stateSetter(() {
              selectedEmp=list;
            });

          }),
          SizedBox(height: 16.h),
          _buildTextField('Email','Please enter your email ID', _emailController),
          SizedBox(height: 16.h),
          _buildTextField('Phone','Please enter your phone number', _phoneController),
          SizedBox(height: 16.h),
         // _buildTextField('Name Coordinator', _coordinatorController),
       //   _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16.h),
          _buildTextField('Source Of Lead', 'Please select',_sourceofleadController),

          SizedBox(height: 16.h),
          _buildTextField('typeOfBusiness',"Enter type of business" ,_typeOfBusinessController),
          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
          SizedBox(height: 16.h),
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
                  style: TextStyle(fontSize: 20.sp,fontFamily:
                  GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
          )
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

  void _submitForm() async{

   LoginDeatils loginDeatils= await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    SaveLeadRequest saveEmploye=SaveLeadRequest();
    saveEmploye.id=1;
    saveEmploye.companyName=name;
    saveEmploye.coordinator="Parag Kumbhar";
    saveEmploye.emailId=email;
    saveEmploye.mobileNumber=phone;
    saveEmploye.address=_addressController.text;
    saveEmploye.sourceOfLead=_sourceofleadController.text;
    saveEmploye.typeOfBusiness=_typeOfBusinessController.text;
    saveEmploye.leadAssignedTo=selectedEmp;
    saveEmploye.leadAddedBy=loginDeatils.data!.id;
    EasyLoading.show(status: "Loading");
    Dio dio=Dio();
    //try{
      var response=await dio.post(ApiConstant.SAVE_LEAD,data: jsonEncode(saveEmploye.toJson()));
      print('the body ${response.data}');
      if(response.statusCode==200){

        PostLead postLead =PostLead.fromJson(jsonDecode(response.data));
        Map<String,dynamic> parameter={
          "date":GetDateFormat.getCurrentDate(),
          "lead":postLead.data!.id,
          "nextFollowUpBy":empData.id,
          "potential":"10",
          "status":"Pending",
          "updatedByUser":loginDeatils.data!.id,
          "description":" Lead Created "
        };
        var para= jsonEncode(parameter);
        var leadResponse=await dio.post(ApiConstant.SAVE_LEAD_UPDATe,data:para );
        if(leadResponse.statusCode==200){
          print('done is done ');
      }
        ApiGetData("");
      }else{
        ToastMessage.show(context, "Please try Again");
      }
      EasyLoading.dismiss();
    // }catch(e){
    //   EasyLoading.dismiss();
    // }


  }

  leadList(){
   return isLoad?Center(child: CircularProgressIndicator(),) :Container(
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
               title: "All Leads",
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                  fontSize: 30.sp,

              ),
              Container(
                width: 350.w,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 260.w,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.arrow_back_ios,size: 16,)),
                          Text("Showing ${emData.length} out of ${emData.length} Results",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w300,fontFamily:
                          GoogleFonts.poppins().fontFamily),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.arrow_forward_ios,size: 16,))
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    SvgPicture.asset('assets/more_icon.svg')
                  ],
                ),
              ),
            ],
          ),
        /*  Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),*/
          SizedBox(height: 25.h,),
          Container(
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(20),
            child: Table(
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
                    tableHeader("Name"),
                    tableHeader("Client"),
                    tableHeader("Project"),
                    tableHeader("Contact"),
                    tableHeader(""),
                    /*if (!AppResponsive.isMobile(context))
                      tableHeader("Email"),
                    tableHeader("Assign to"),
                    if (!AppResponsive.isMobile(context)) tableHeader(""),*/

                  ],
                ),

                /// Table Data

                for (int i=0;i<emData.length;i++)  tableRow(
                    context,
                  name: emData[i].lead!.leadAddedBy!.firstName,
                  color: Colors.blue,
                  image: "assets/user1.jpg",
                  client: emData[i].lead!.companyName,
                 project: emData[i].lead!.companyName,
                    contact: emData[i].lead!.mobileNumber,
                 // status: emData[i].lead!.leadAssignedTo!.firstName!+" "+emData[i].lead!.leadAssignedTo!.lastName!,
                  status: emData[i].lead!.leadAddedBy!.firstName,
                  index: i
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, client, project,status, color, index, String? contact}) {
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
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeadInfo(leadData: emData[index],)));
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
                  TextView(title: name, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300)
                ],
              ),
            ),
          ),

          TextView(title: client, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300),
          TextView(title: project, fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300),
          TextView(title: contact.toString(), fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300),
          Row(
            children: [
              InkWell(onTap:(){
                showAlertDialog(context,index);
              },child: Icon(Icons.delete,color: Colors.red)),
              SizedBox(
                width: 5.w,
              ),
              InkWell(onTap:(){
                editleadDilaog(emData[index]);
              },child: Icon(Icons.edit,color: Colors.grey)),
            ],
          )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(title: text, fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w900),

    );
  }

  Future<void> ApiGetData(String URL) async{

    isLoad=true;
    setState(() {

    });
    final dio = Dio();
    final response = await dio.get(ApiConstant.GET_ALL_LEAD);
    print(response.data);
    if(response.statusCode==200){
      LeadList employeeList =LeadList.fromJson(jsonDecode(response.data));
      emData.clear();
      emData.addAll(employeeList.data!);
      print('this is ${emData.length}');
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
      "id":emData[index].lead!.id!
    });
    if(response.statusCode==200){
      emData.removeAt(index);
      setState(() {

      });

    }else{
      ToastMessage.show(context, "Please try Again");
    }
  }


  Widget _buildTextOne(String label) {
    return InkWell(
      onTap: (){
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
              children: [
                Text(
                    label
                ),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }

  getAllEmployee()async{
    Dio dio=Dio();
    final response = await dio.get(ApiConstant.BASE_URL+"/Employee/getAll");
    print(response.data);
    if(response.statusCode==200){
      EmployeeList employeeList =EmployeeList.fromJson(jsonDecode(response.data));
      Constants.allEmployee.clear();
      Constants.allEmployee.addAll(employeeList.data!);
    }
  }
  Widget setupAlertDialoadContainer(){

    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:  Constants.allEmployee.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              // selectRole=dataRole[index].id!;
              // selectedRole=dataRole[index].name!;
              empData=Constants.allEmployee[index];
              Navigator.pop(context);
              setState(() {
              });
            },
            child: ListTile(
              title: Text( Constants.allEmployee[index].firstName!+" "+Constants.allEmployee[index].lastName!),
            ),
          );
        },
      ),
    );
  }


  leadCountCard(String title,String count,String img, bool isSelected, Color bgColor,){
    return InkWell(
      onTap: (){
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
            side: BorderSide(width: 0.50, color: isSelected?Color(0xFFC3262C):Colors.white),
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
              child: SvgPicture.asset(Images.emp_tot,height: 50.h,width: 50.w,),
            ),
            SizedBox(width: 17.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(title: count, fontSize: 35.sp, color: AppColor.black, fontWeight: FontWeight.w600),
                TextView(title: title, fontSize: 20.sp, color: Color(0xff6C6C6C), fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }

  editleadDilaog(LeadData leadData){
    editselectedEmp=leadData.lead!.leadAssignedTo!.id!;
    _editnameController.text =leadData.lead!.companyName!;
     _editemailController.text=leadData.lead!.emailId!;
    _editphoneController.text=leadData.lead!.mobileNumber!;
     _editsourceofleadController.text= leadData.lead!.sourceOfLead!;
     _editcoordinatorController.text=leadData.lead!.coordinator!;
     _editaddressController.text=leadData.lead!.address!;
     _edittypeOfBusinessController.text= leadData.lead!.typeOfBusiness!;


    return showDialog<void>(
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
                          child: EditLeadLead(leadData,setState),
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

  }

  EditLeadLead(LeadData leadData,StateSetter stateSetter){
    return Container(
      width: 408.w,
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
              "Add Lead",
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
          Center(child: SvgPicture.asset('assets/upload_profile.svg',height: 202.h,width:202.w)),
          SizedBox(height: 16.h),
          _buildTextField('Company Name','Please Comapny name', _editnameController),
          SizedBox(height: 16.h),
          _buildText('${editselectedEmp==0?"Select Employee ":"One Employee Selected"}', () async {
            int list = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmpDialogOne();
                });
            // print('the list is ${list}');
            editselectedEmp=list;
            print('the list is$selectedEmp');
            stateSetter(() {
              editselectedEmp=list;
            });

          }),
          SizedBox(height: 16.h),
          _buildTextField('Email','Please enter your email ID', _editemailController),
          SizedBox(height: 16.h),
          _buildTextField('Phone','Please enter your phone number', _editphoneController),
          SizedBox(height: 16.h),
          // _buildTextField('Name Coordinator', _coordinatorController),
          //   _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16.h),
          _buildTextField('Source Of Lead', 'Please select',_editsourceofleadController),

          SizedBox(height: 16.h),
          _buildTextField('typeOfBusiness',"Enter type of business" ,_edittypeOfBusinessController),
          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
          SizedBox(height: 16.h),
          InkWell(
            onTap: (){
              submitEditForm(leadData);
            },
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
                  style: TextStyle(fontSize: 20.sp,fontFamily:
                  GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w500, color: AppColor.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  void submitEditForm(LeadData leadData) async{

    LoginDeatils loginDeatils= await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _editnameController.text.toString();
    String email = _editemailController.text.toString();
    String phone = _editphoneController.text.toString();
    SaveLeadRequest saveEmploye=SaveLeadRequest();
    saveEmploye.id=leadData.lead!.id;
    saveEmploye.companyName=name;
    saveEmploye.coordinator="Parag Kumbhar";
    saveEmploye.emailId=email;
    saveEmploye.mobileNumber=phone;
    saveEmploye.address=_editaddressController.text;
    saveEmploye.sourceOfLead=_editsourceofleadController.text;
    saveEmploye.typeOfBusiness=_edittypeOfBusinessController.text;
    saveEmploye.leadAssignedTo=editselectedEmp;
    saveEmploye.leadAddedBy=loginDeatils.data!.id;
    EasyLoading.show(status: "Loading");
    Dio dio=Dio();
    //try{
    var response=await dio.put(ApiConstant.UPDATE_LEAD,data: jsonEncode(saveEmploye.toJson()));
    print('the body ${response.data}');
    if(response.statusCode==200){

      PostLead postLead =PostLead.fromJson(jsonDecode(response.data));
      Map<String,dynamic> parameter={
        "date":GetDateFormat.getCurrentDate(),
        "lead":postLead.data!.id,
        "nextFollowUpBy":empData.id,
        "potential":"10",
        "status":"Pending",
        "updatedByUser":loginDeatils.data!.id,
        "description":" Lead Created "
      };
      var para= jsonEncode(parameter);
      var leadResponse=await dio.post(ApiConstant.SAVE_LEAD_UPDATe,data:para );
      if(leadResponse.statusCode==200){
        print('done is done ');
      }
      Navigator.pop(context);
      ApiGetData("");
    }else{
      ToastMessage.show(context, "Please try Again");
    }
    EasyLoading.dismiss();
    // }catch(e){
    //   EasyLoading.dismiss();
    // }


  }
}