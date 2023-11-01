import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/network/api_helper.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../constant/constants.dart';
import '../../model/response/employeelist.dart';
import '../../model/response/lead_list.dart';

class LeadDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeadDialog();
  }
}

class _LeadDialog extends State<LeadDialog>{

  List<LeadData>emData=[];
  List<LeadData>temData=[];
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
                    child: Text("Find the Lead",style: TextStyle(fontSize: 20),)),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 600.w,
                    child: SearchBar(
                      hintText: "Enter Company name",
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
                             /* if(emData[index].lead!.isSelected!){
                                selectedEmp.add(emData[index].lead!.id!);
                                emData[index].lead!.isSelected=false;
                              }else{
                                // selectedEmp.remove(emData[index].id!);
                                emData[index].lead!.isSelected=true;
                              }*/
                              emData.forEach((element) {element.lead!.isSelected!=false; });
                              emData[index].lead!.isSelected=true;
                              selectedEmp.add(emData[index].lead!.id!);
                              print(selectedEmp);
                              setState(() {
                              });
                            },
                            child: ListTile(
                              style: ListTileStyle.list,


                              title: Row(
                                children: [
                                  getImage('${emData[index].lead!.addLogo}',height: 50.h,width: 50.w),
                                  SizedBox(width: 10,),
                                  Text(emData[index].lead!.companyName!,style: TextStyle(color: Colors.black),),
                                ],
                              ),
                              trailing: emData[index].lead!.isSelected! ?Icon(Icons.check,color: Colors.green,):SizedBox(),


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
                    child:Container(
                      decoration: BoxDecoration(
                          color: ThemeColor.theme_blue,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
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

    var response = await ApiHelper().apiGet(ApiConstant.GET_ALL_LEAD);
    if(response.status==200){
      LeadList employeeList =LeadList.fromJson(response.response);
      //emData=employeeList.data!;
      emData.addAll(employeeList.data! as Iterable<LeadData>);
      temData.addAll(employeeList.data! as Iterable<LeadData>);

      setState(() {

      });
    }
  }

  filterData(String filter){
    if (filter.length<2) {
      emData.clear();
      emData.addAll(temData);
      return emData;
    } else {
      emData.clear();
      emData.addAll(temData
          .where((item) => item.lead!.companyName!.toLowerCase().contains(filter.toLowerCase()))
          .toList());

    }

    setState(() {

    });


  }

}
