import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/app_colors.dart';
import '../../constant/constants.dart';
import '../../model/response/employeelist.dart';

class EmpDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmpDialog();
  }
}

class _EmpDialog extends State<EmpDialog>{

  List<EmpData>emData=[];
  List<EmpData>temData=[];
  List<int>selectedEmp=[];

  @override
  void initState() {
    ApiGetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 900.h,
          width: 900.w,
          color: Colors.white,
          child: Container(
            width: 600.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Find the Employee",style: TextStyle(fontSize: 20),)),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 600.w,
                  child: SearchBar(
                    hintText: "Enter Employee name",
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/search.png",height: 20,width: 20,),
                    ),
                    onChanged: (name){
                      filterData(name);
                      },
                  ),
                ),
              ),
                emData.length>0?Expanded(
                  child: ListView.builder(
                    itemCount: emData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              if(emData[index].isSelected!){
                                selectedEmp.add(1);
                                emData[index].isSelected=false;
                              }else{
                               // selectedEmp.remove(emData[index].id!);
                                emData[index].isSelected=true;
                              }
                              selectedEmp.add(1);
                              setState(() {

                              });
                            },
                            child: ListTile(
                              style: ListTileStyle.list,


                              title: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(emData[index].image!)
                                  ),
                                  SizedBox(width: 10,),
                                  Text(emData[index].firstName!+" "+emData[index].lastName!,style: TextStyle(color: Colors.black),),
                                ],
                              ),
                              trailing: emData[index].isSelected! ?Icon(Icons.check,color: Colors.green,):SizedBox(),


                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                ):Container(height:200.h,child: Column(
                  children: [
                    Text("No data found"),
                    Spacer()
                  ],
                )),


                Visibility(
                  visible: true,
                  child: InkWell(
                    onTap: (){
                      print('the length is ${selectedEmp.length}');
                      Navigator.pop(context,selectedEmp);

                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                     width: 600.w,
                      height: 59.h,
                      decoration: BoxDecoration(

                          color: AppColor.yellow,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: AppColor.black),
                        ),
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),

        ),
      ),

    );
  }


  Future<void> ApiGetData() async{

    var response = await ApiHelper().apiGet(ApiConstant.GET_ALL_EMPLOYEE);
    if(response.status==200){
      EmployeeList employeeList =EmployeeList.fromJson(response.response);
      //emData=employeeList.data!;
      emData.addAll(employeeList.data!);
      temData.addAll(employeeList.data!);

      setState(() {

      });
    }
    // EmployeeList.fromJson(jsonDecode(response.data));
    // progressDailog.progressDailog(context, false);
    //return response.statusCode!;
  }

  filterData(String filter){
    if (filter.length<2) {
      emData.clear();
      emData.addAll(temData);
      return emData;
    } else {
      emData.clear();
       emData.addAll(temData
           .where((item) => item.firstName!.toLowerCase().contains(filter.toLowerCase()))
           .toList());

    }

    setState(() {

    });


  }

}




