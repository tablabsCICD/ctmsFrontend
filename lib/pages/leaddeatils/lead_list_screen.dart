import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/provider/leadprovider/leadprovider.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../model/response/employeelist.dart';
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';
import '../../model/response/lead_list.dart';

class LeadListData extends StatefulWidget {
  final String title;

   LeadListData({Key? key, required this.title}) : super(key: key);
  @override
  _LeadListData createState() => _LeadListData();
}

class _LeadListData extends State<LeadListData> {

  List<int>video=[];
  final List<LeadData>emData=[];
  bool isLoad=false;



  @override
  void initState() {
    // TODO: implement initState
   // ApiGetData("");
    Provider.of<LeadProvider>(context).ApiGetData(context, "URL");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                widget.title,
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
                status: emData[i].lead!.leadAssignedTo!.firstName!+" "+emData[i].lead!.leadAssignedTo!.lastName!,
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
  TableRow tableRow(context, {name, image, designation, status, color}) {
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
          Container(
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
            Image.asset(
              "assets/more.png",
              color: Colors.grey,
              height: 30,
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
      emData.addAll(employeeList.data! as Iterable<LeadData>);
      print('this is ${emData.length}');
      isLoad=false;
      setState(() {

      });
    }
    // EmployeeList.fromJson(jsonDecode(response.data));
    // progressDailog.progressDailog(context, false);
    //return response.statusCode!;
  }
}