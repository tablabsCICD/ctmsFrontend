import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/response/employeelist.dart';
import '../../common/app_colors.dart';
import '../../common/app_responsive.dart';

class EmpListData extends StatefulWidget {
  final String title;

  const EmpListData({Key? key, required this.title}) : super(key: key);
  @override
  _EmpListData createState() => _EmpListData();
}

class _EmpListData extends State<EmpListData> {

  List<int>video=[];
  List<EmpData>emData=[];
  bool isLoad=false;

  @override
  void initState() {
    // TODO: implement initState
    ApiGetData("");
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
                  tableHeader("Full Name"),
                  if (!AppResponsive.isMobile(context))
                    tableHeader("Designation"),
                  tableHeader("Status"),
                  if (!AppResponsive.isMobile(context)) tableHeader(""),
                ],
              ),

              /// Table Data

              for (int i=0;i<emData.length;i++)  tableRow(
                context,
                name: emData[i].firstName!+" "+emData[i].lastName!,
                color: Colors.blue,
                image: "assets/user1.jpg",
                designation: emData[i].role!.name!,
                status: "Practical Round",
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

    // ProgressDailog progressDailog=ProgressDailog();
    // progressDailog.progressDailog(context, true);
    // setState(() {
    //
    // });
    isLoad=true;
    setState(() {

    });
    final dio = Dio();
    final response = await dio.get("http://ec2-43-205-143-58.ap-south-1.compute.amazonaws.com:8080/crm/Employee/getAll");
    print(response.data);
    if(response.statusCode==200){
      EmployeeList employeeList =EmployeeList.fromJson(jsonDecode(response.data));
      //emData=employeeList.data!;
      emData.addAll(employeeList.data!);
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