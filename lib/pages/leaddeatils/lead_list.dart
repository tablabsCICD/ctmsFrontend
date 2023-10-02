import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/model/response/post_lead.dart';
import 'package:flutter_hr_management/pages/leaddeatils/lead_info.dart';
import 'package:flutter_hr_management/pages/widget/toast.dart';
import 'package:flutter_hr_management/utils/date.dart';
import '../../constant/constants.dart';
import '../../model/request/save_lead.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/lead_list.dart';
import '../../utils/constant.dart';
import '../../utils/sharepreferences.dart';
import '../dashboard/widget/header_widget.dart';

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


  List<LeadData>emData=[];
  bool isLoad=false;
  late EmpData empData =EmpData();

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
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          HeaderWidget(title: "Lead Data",),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
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
              ),
            ),
          ),
        ],
      ),
    );
  }


  addLead(){
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(
            "Add Lead Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          )),
          SizedBox(height: 16),
          _buildTextField('Company Name', _nameController),
          SizedBox(height: 16),
          _buildTextField('Email', _emailController),
          SizedBox(height: 16),
          _buildTextField('Phone', _phoneController),
          SizedBox(height: 16),
         // _buildTextField('Name Coordinator', _coordinatorController),
          _buildText(empData.firstName==null?"Name of Coordinator":empData.firstName!+" "+empData.lastName!),
          SizedBox(height: 16),
          _buildTextField('Source Of Lead', _sourceofleadController),
          SizedBox(height: 16), _buildTextField('Address', _addressController),
          SizedBox(height: 16),
          SizedBox(height: 16), _buildTextField('typeOfBusiness', _typeOfBusinessController),
          SizedBox(height: 16),

          /*ElevatedButton(
            onPressed: _submitForm,
            child: Center(child: Text('Submit')),
          ),*/
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

  void _submitForm() async{

   LoginDeatils loginDeatils= await LocalSharePreferences.localSharePreferences.getLoginData();
    String name = _nameController.text.toString();
    String email = _emailController.text.toString();
    String phone = _phoneController.text.toString();
    SaveLeadRequest saveEmploye=SaveLeadRequest();
    saveEmploye.companyName=name;
    saveEmploye.coordinator=_coordinatorController.text;
    saveEmploye.emailId=email;
    saveEmploye.mobileNumber=phone;
    saveEmploye.address=_addressController.text;
    saveEmploye.sourceOfLead=_sourceofleadController.text;
    saveEmploye.typeOfBusiness=_typeOfBusinessController.text;
    saveEmploye.leadAssignedTo=empData.id;
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
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Leads",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.yellow,
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColor.black),
                ),
              )
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              /// Table Header
              TableRow(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      )),
                ),
                children: [
                  tableHeader("Company Name"),
                  if (!AppResponsive.isMobile(context))
                    tableHeader("Email"),
                  tableHeader("Assign to"),
                  if (!AppResponsive.isMobile(context)) tableHeader(""),

                ],
              ),

              /// Table Data

              for (int i=0;i<emData.length;i++)  tableRow(
                context,
                name: emData[i].lead!.companyName,
                color: Colors.blue,
                image: "assets/user1.jpg",
                designation: emData[i].lead!.emailId,
               // status: emData[i].lead!.leadAssignedTo!.firstName!+" "+emData[i].lead!.leadAssignedTo!.lastName!,
                status: "name",
                  index: i
              ),

            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Showing ${emData.length} out of ${emData.length} Results"),
                Text(
                  "View All",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TableRow tableRow(context, {name, image, designation, status, color, index}) {
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
                  Text(name)
                ],
              ),
            ),
          ),
          // Designation
          if (!AppResponsive.isMobile(context)) Text(designation),


          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                height: 10,
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(status),
            ],
          ),
          // Menu icon
          if (!AppResponsive.isMobile(context))
            // Image.asset(
            //   "assets/more.png",
            //   color: Colors.grey,
            //   height: 30,
            // )
            InkWell(
              onTap: (){

                showAlertDialog(context,index);
              },
              child: Icon(Icons.delete,size: 30,color: Colors.red,),
            )
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
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


  Widget _buildText(String label) {
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
}