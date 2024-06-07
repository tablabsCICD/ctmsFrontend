import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/SharedPreferencesConstant.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization_portal/get_city_list.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization_portal/model/organization/org_full_load_model.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/multi_select.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/star_display.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class LoadList extends StatefulWidget {
  final orgProvider = locator<OrgProvider>();
  final buySellProvider = locator<BuySellProvider>();
  Organization organization;
  int index;
  LoadList(this.organization,{Key? key, required this.index}) : super(key: key) {
    orgProvider.getOrgFullLoadList(organization.id!);
    orgProvider.getUsersByCompanyId(organization.id!);
    orgProvider.getAllBranch(organization.id!);
  }
  @override
  State<LoadList> createState() => _LoadListState();
}

class _LoadListState extends State<LoadList> {
  final bidProvider = locator<BidProvider>();
  final orgProvider = locator<OrgProvider>();
  TextEditingController bidAmtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController filterController = TextEditingController();
  int counter = 0;
  var selectedPageNumber = 1;
  final dashboardProvider = locator<DashboardProvider>();
  ScrollController _scrollController = ScrollController();
  String? selectedFromCity = '', selectedToCity = "";
  String? branchNamedropdownvalue;
  String? userNamedropdownvalue;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        dashboardProvider.getFullLoadTruckList(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<OrgProvider>(
        builder: (context, model, child) => Container(
            padding: ResponsiveWidget.isDesktop(context)
                ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
                : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    Visibility(
                      visible: widget.index==1?true:false,
                      child: Container(
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: InkWell(
                                  onTap: () {
                                   // _showMultiSelect(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomSearchCityTextField(
                                        hintText: 'From',
                                        controller: selectedFromCity!,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetCityList())).then((value) {
                                            if (value.toString().isNotEmpty &&
                                                value != null) {
                                              selectedFromCity = value[0];
                                              setState(() {});
                                            }
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      TextView(
                                        title: "To",
                                        fontSize:15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      CustomSearchCityTextField(
                                        hintText: 'To',
                                        controller: selectedToCity!,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GetCityList())).then((value) {
                                            if (value.toString().isNotEmpty &&
                                                value != null) {
                                              selectedToCity = value[0];
                                              setState(() {});
                                            }
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          model.getSearchByNameList(widget.organization.id!,
                                              '', selectedFromCity!, selectedToCity!);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          child: Text("Search",
                                              style: Style.button),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  filterIcon(model),
                                  SizedBox(
                                    width: 27.w,
                                  ),
                                 /* SvgPicture.asset('assets/more_icon.svg'),
                                  SizedBox(
                                    width: 27.w,
                                  ),*/
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                    Visibility(visible: widget.index==1?true:false,child: SizedBox(height: 30.h,)),
                    Visibility(
                      visible: widget.index==1?true:false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          getContainer(model,"All Loads",0,model.fullLoadPostCount.toString(), Color(0xffEAF8F4),'assets/org/all_load.svg'),
                          getContainer(model,"Full Loads",1,model.fullLoadCount.toString(), Color(0xffFFEDF9),'assets/org/full_load.svg'),
                          getContainer(model,"Part Loads",3, model.partLoadCount.toString(), Color(0xffFEF0E5),'assets/org/part_load.svg'),
                        ],
                      ),
                    ),
                    Visibility(visible: widget.index==1?true:false,child: SizedBox(height: 30.h,)),
                    getPostList(model,context),
            ]
           )
        )
    );

  }
  Set<int>? selectedValues = [1, 2, 3, 4, 5].toSet();

    String getText(Set<int>? selectedValues) {
    int count = selectedValues!.length;
    String message = 'All Requirements';
    if (count == 5)
      return message;
    else
      return '${count} ' + 'selected Requirements';
  }

  var selectedTab = 'All Loads';
  late List<int> selectedValuesList = <int>[];



  getPostList(OrgProvider model,BuildContext context) {
    return /* model.isLoading==true?Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 600,
              child: Center(
                  child: CircularProgressIndicator()))):*/
      model.orgFullLoadList.isEmpty && model.isLoading==false
          ?  Container(
        margin: EdgeInsets.all(30),
          height:
          MediaQuery.of(context).size.height - 600,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: TextView(
                  title: "No Record Found",
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w900)))
          :model.orgAllFullLoadList.isEmpty
          ? Container(
              height:
              MediaQuery.of(context).size.height - 600,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(20),
              child: Center(
                  child: CircularProgressIndicator()))
          :Expanded(
            child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            physics: ScrollPhysics(),
      staggeredTileBuilder: (int index) =>
      StaggeredTile.fit(1),
      shrinkWrap: true,
      crossAxisCount: ResponsiveWidget.isDesktop(context)
      ? 2
            : ResponsiveWidget.isMobile(context)
      ? 1
            : 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      itemCount: model.orgFullLoadList.length,
      itemBuilder: (context, index) {
       return InkWell(
            onTap: () {},
            child: Card(
                color:Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0.r),
                ),
                elevation: 1,
                child: Container(
                  height: 230.h,
                 // width: 510.w,
                  decoration: BoxDecoration(
                      color:Colors.white,
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180.w,
                        child: Column(
                          children: [
                            Image.asset('assets/org/container.png',height: 150.h,width: 174.w,),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: TextView(
                                title: "${model.orgFullLoadList[index].topicName}",
                                fontSize:12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                            ),
                            /*TextView(
                              title: "${model.orgFullLoadList[index].vehicleSize}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),*/
                          ],
                        ),
                      ),
                     // SizedBox(width: 17.w),
                      SizedBox(
                        width: 174.w,
                        child: Column(
                          children: [
                            Container(
                              width: 150.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                  color: model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Full load required"
                                      ? ColorResources
                                      .FULL_LOAD_REQUIRED
                                      : model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Part load required"
                                      ? ColorResources
                                      .PART_LOAD_REQUIRED
                                      : model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Full load available"
                                      ? ColorResources
                                      .FULL_LOAD_AVAILABLE
                                      : ColorResources
                                      .PART_LOAD_AVAILABLE,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft:
                                      Radius.circular(5),
                                      bottomRight:
                                      Radius.circular(5))),
                              child: TextView(
                                title: "${model.orgFullLoadList[index].mainTag}",
                                fontSize:15.sp,
                                fontWeight: FontWeight.w600,
                                color: model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Full load required"
                                      ? ColorResources
                                      .FLR_TEXT
                                      : model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Part load required"
                                      ? ColorResources
                                      .PLR_TEXT
                                      : model
                                      .orgFullLoadList[
                                  index]
                                      .mainTag ==
                                      "Full load available"
                                      ? ColorResources
                                      .FLA_TEXT
                                      : ColorResources
                                      .PLA_TEXT)),
                            SizedBox(height: 30.h,),
                            TextView(
                              title: "${model.orgFullLoadList[index].source}",
                              fontSize:14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                            Container(color: Colors.black,width: 1.w,height: 48.h,),
                            TextView(
                              title: "${model.orgFullLoadList[index].destination}",
                              fontSize:14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                            SizedBox(height: 20.h,),
                           /* TextView(
                              title: "Expire : ${model.orgFullLoadList[index].expireDate}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff000000),
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      SizedBox(
                        width: 170.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h,),
                            Container(
                              width: 130.w,
                                alignment: Alignment.centerRight,
                                child: InkWell(onTap: (){
                                 // orgProvider.deleteFullLoad(model.orgFullLoadList[index]);
                                  showAlertDialog(context,model.orgFullLoadList[index]);
                                }, child: SvgPicture.asset('assets/images/delete.svg',height: 20.h,width: 20.w,))),
                            SizedBox(height: 20.h,),
                            Row(
                              children: [
                                getImage('',height: 30.h),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Text(
                                     "${model.orgFullLoadList[index].nameOfPerson}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize:14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Row(
                              children: [
                                SizedBox(width: 15.w,),
                                SvgPicture.asset('assets/sheild.svg',height: 12.h,width: 12.w,),
                                SizedBox(width: 20.w,),
                                SizedBox(
                                  width: 100.w,
                                  child: Text(
                                     "${model.orgFullLoadList[index].companyName}",
                                    style:TextStyle(fontSize:15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),),overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                  SizedBox(height: 30.h,),
                  SizedBox(
                    width: 121.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => new CupertinoAlertDialog(
                              title: Column(
                                children: [
                                  Text(
                                      'Contact Number : ${model.orgFullLoadList[index].mobileNumber}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      'Email_Id : ${model.orgFullLoadList[index].mobileNumber}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(10.0),
                                    child: Text('Ok',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.theme_blue,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.r))),
                        ),
                        child: TextView(
                          title: "Contact",
                          fontSize:15.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff),
                        ),
                    ),
                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
        );
      }
      ),

    );
  }
  getContainer(OrgProvider model,String title, int value,String count, Color bgColor, String img) {
    return InkWell(
     onTap: (){
       model.getFilterFullLoadList(title);
     },
      child:  Container(
        width: 329.w,
        height: 162.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.50,
                color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 108.w,
              height: 108.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: CircleBorder(),
              ),
              child: SvgPicture.asset(
                img,
                height: 50.h,
                width: 50.w,
              ),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                    title: count,
                    fontSize: 35.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600),
                TextView(
                    title: title,
                    fontSize: 20.sp,
                    color: Color(0xff6C6C6C),
                    fontWeight: FontWeight.w300)
              ],
            )
          ],
        ),
      ),
    );
  }

  filterIcon(OrgProvider model) {
    return Container(
        width: 130.w,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  _buildPopupMenu('All Loads',0,model),
                  _buildPopupMenu('Full Load Available',1,model),
                  _buildPopupMenu('Full Load Required',2,model),
                  _buildPopupMenu('Part Load Available',3,model),
                  _buildPopupMenu('Part Load Required',4,model),
                  _buildPopupMenu('Get Load By Branch Name',5,model),
                  _buildPopupMenu('Get Load By User Name',6,model),
                ],
              ),
              Text(
                "Filter",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  PopupMenuItem _buildPopupMenu(
      String title, int? index,OrgProvider model
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 14.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: (){
        if(index==5){
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return Dialog(
                alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                insetAnimationDuration: Duration(milliseconds: 200),
                insetAnimationCurve: Curves.easeOutExpo,
                // <-- SEE HERE
                child: StatefulBuilder(builder:
                    (BuildContext context, StateSetter setState) {
                  return _branchNameWiseDialog(context, setState,index!);
                }),
              );
            },
          );
        }else
        if(index==6){
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return Dialog(
                alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                insetAnimationDuration: Duration(milliseconds: 200),
                insetAnimationCurve: Curves.easeOutExpo,
                // <-- SEE HERE
                child: StatefulBuilder(builder:
                    (BuildContext context, StateSetter setState) {
                  return _userNameWiseDialog(context, setState,index!,model);
                }),
              );
            },
          );
        }else {
          setState(() {
            selectedTab = title;
            model.getFilterFullLoadList(title);
          });
        }
      },
    );
  }

  TextEditingController branchNameController = TextEditingController();
  Widget _branchNameWiseDialog(BuildContext context, StateSetter stateSetter, int index) {
    return Container(
      width: 350.w,
      height: 350.h,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close_rounded,size: 20,),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _buildDropdownField('Branch Name', 'Please select branch', stateSetter,true),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColor.red,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      onPressed: () {
                        if(branchNameController.text.isNotEmpty){
                        orgProvider.getOrgFullLoadListByBranch(widget.organization.id!, branchNameController.text);}else{
                          showCustomToast(
                              context, "Please select branch name", Icons.clear, Colors.red);
                        }
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController userNameController = TextEditingController();
  Widget _userNameWiseDialog(BuildContext context, StateSetter stateSetter, int index, OrgProvider model) {
    return Container(
      width: 350.w,
      height: 350.h,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.close_rounded,size: 20,),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _buildDropdownField('Employee Name', 'Please select employee name', stateSetter,false),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColor.red,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
                      onPressed: () {
                        if(userNameController.text.isNotEmpty){
                        if(model.userList.isNotEmpty){
                          model.userList.forEach((element) async {
                            if("${element.firstName} ${element.lastName}" == userNameController.text){
                              await orgProvider.getOrgFullLoadListByEmployee(widget.organization.id!, element.id!);
                              Navigator.of(context).pop();
                            }
                          });
                        }}
                        else{
                          showCustomToast(
                              context, "Please select username", Icons.clear, Colors.red);
                        }
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  var items = [
    'Shreeji',
    'Marketing',
    'Test',
  ];

  Widget _buildDropdownField(
      String label, String hint, StateSetter stateSetter, bool isBranch) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          height: 52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.7),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton(
                value: isBranch?branchNamedropdownvalue:userNamedropdownvalue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                borderRadius: BorderRadius.circular(5.0),
                underline: SizedBox.shrink(),
                hint: Text(
                  hint,
                  style: TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                items: isBranch?orgProvider.branchNameList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }).toList():orgProvider.userNameList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  stateSetter(() {
                    if(isBranch){
                    branchNamedropdownvalue = newValue!;
                    branchNameController.text = branchNamedropdownvalue!;
                    }else{
                      userNamedropdownvalue = newValue!;
                      userNameController.text = userNamedropdownvalue!;
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, OrgFullLoadModel orgFullLoadList) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes",style: TextStyle(color: Colors.red),),
      onPressed: () async {
        await orgProvider.deleteFullLoad(orgFullLoadList);
       Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: Text("No",style: TextStyle(color: Colors.green),),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Do you want to delete this post"),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
