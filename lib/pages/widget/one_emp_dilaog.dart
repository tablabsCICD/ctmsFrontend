import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../constant/constants.dart';
import '../../model/response/employeelist.dart';

class EmpDialogOne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmpDialogOne();
  }
}

class _EmpDialogOne extends State<EmpDialogOne>{

  List<EmpData>emData=[];
  List<EmpData>temData=[];
  int selectedEmp=0;

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

                              for(int i=0;i<emData.length;i++){
                                if(index==i){
                                  emData[index].isSelected=true;
                                }else{
                                  emData[i].isSelected=false;
                                }
                              }
                              // if(emData[index].isSelected!){
                              //   emData[index].isSelected=false;
                              // }else{
                              //   emData[index].isSelected=true;
                              // }
                              selectedEmp=emData[index].id!;

                              setState(() {

                              });
                            },
                            child: ListTile(
                              style: ListTileStyle.list,


                              title: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(emData[index].image==''?'https://tablabs-images.s3.ap-south-1.amazonaws.com/1699264942004-profile.png':emData[index].image=="string"?'https://tablabs-images.s3.ap-south-1.amazonaws.com/1699264942004-profile.png':emData[index].image!)
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
                      print('the length is ${selectedEmp}');
                      Navigator.pop(context,selectedEmp);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ThemeColor.theme_blue,
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
                          "Done",
                          style: TextStyle(fontSize: 20.sp,fontFamily:
                          GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500, color: AppColor.white),
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

    var response = await ApiHelper().apiGet(ApiConstant.BASE_URL+"api/Employee/getByPages?page=0&size=10000");
    if(response.status==200){
      EmployeeListResponse employeeList =EmployeeListResponse.fromJson(response.response);
      //emData=employeeList.data!;
      emData.addAll(employeeList.data!.content!);
      temData.addAll(employeeList.data!.content!);

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