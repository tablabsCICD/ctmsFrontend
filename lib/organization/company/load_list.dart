import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_search_city_feild.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization/get_city_list.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/multi_select.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class LoadList extends StatefulWidget {
  final dashboardProvider = locator<OrgProvider>();
  final buySellProvider = locator<OrgProvider>();
  Organization organization;
  int index;
  LoadList(this.organization,{Key? key, required this.index}) : super(key: key) {
    dashboardProvider.getOrgFullLoadList(organization.id!);
  }
  @override
  State<LoadList> createState() => _LoadListState();
}

class _LoadListState extends State<LoadList> {
  final bidProvider = locator<BidProvider>();
  final authProvider = locator<AuthProvider>();
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
                                    _showMultiSelect(context);
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
                                      /*ElevatedButton(
                                  onPressed: () {
                                    model.getSearchByNameList('',
                                        selectedFromCity!, selectedToCity!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    onPrimary: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: CustomText("Search",
                                        style: Style.button),
                                  ),
                                ),*/
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  filterIconButton(),
                                  SizedBox(
                                    width: 27.w,
                                  ),
                                  SvgPicture.asset('assets/more_icon.svg'),
                                  SizedBox(
                                    width: 27.w,
                                  ),
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
                          getContainer("All Loads",0,model.allUserList.length.toString(), Color(0xffEAF8F4),'assets/org/all_load.svg'),
                          getContainer("Full Loads",1,model.fullLoadPostCount.toString(), Color(0xffFFEDF9),'assets/org/full_load.svg'),
                          getContainer("Part Loads",3, model.buySellPostCount.toString(), Color(0xffFEF0E5),'assets/org/part_load.svg'),
                        ],
                      ),
                    ),
                    Visibility(visible: widget.index==1?true:false,child: SizedBox(height: 30.h,)),
                    getPostList(context),
            ]
           )
        )
    );

  }
  Set<int>? selectedValues = [1, 2, 3, 4, 5].toSet();

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'All Requirements'),
      MultiSelectDialogItem(2, 'Required - Full load vehicle'),
      MultiSelectDialogItem(3, 'Required - Part load vehicle'),
      MultiSelectDialogItem(4, 'Available - Full load vehicle'),
      MultiSelectDialogItem(5, 'Available - Part load vehicle'),
    ];

    selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          initialSelectedValues: selectedValues,
        );
      },
    );
    print(selectedValues!.length);
    print(selectedValues);
  }

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

  getCircularContainer(String title, bool isSelected,int i) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) =>InkWell(
        onTap: (){
          setState(() {
            selectedTab = title;
            model.getFilterFullLoadList(title);
          });
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 2.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
            child: CustomText(title,style: Style.filterHeading,textAlign: TextAlign.center,),
            decoration: BoxDecoration(
              color: isSelected? Colors.white :Color(0xffe6e0d7),
              border: isSelected? null : Border.all(color: Color(0xffd1ccc4)),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getPostList(BuildContext context) {
    return Consumer<OrgProvider>(
      builder: (context, model, child) =>/* model.isLoading==true?Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 400,
              child: Center(
                  child: CircularProgressIndicator()))):*/
      model.orgAllFullLoadList.isEmpty
          ? Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 400,
              child: Center(
                  child: CircularProgressIndicator()/*TextView(
                      title: "No Record Found",
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w900)*/)))
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
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0.r),
                ),
                elevation: 1,
                child: Container(
                  height: 218.h,
                  width: 510.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 174.w,
                        child: Column(
                          children: [
                            Image.asset('assets/org/container.png',height: 162.h,width: 174.w,),
                            TextView(
                              title: 'Plywood',
                              // title: "${model.orgFullLoadList[index].modelName}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                            TextView(
                              title: "${model.orgFullLoadList[index].vehicleSize}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 17.w),
                      SizedBox(
                        width: 174.w,
                        child: Column(
                          children: [
                            Container(
                              width: 140,
                              height: 20,
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
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                            Container(color: Colors.black,width: 1.w,height: 48.h,),
                            TextView(
                              title: "${model.orgFullLoadList[index].destination}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                            SizedBox(height: 20.h,),
                            TextView(
                              title: "Expire : 19 Sept, 2023",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff000000),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h,),
                          Container(
                            width: 130.w,
                              alignment: Alignment.centerRight,
                              child: InkWell(onTap: (){}, child: SvgPicture.asset('assets/delete.svg',height: 20.h,width: 20.w,))),
                          SizedBox(height: 20.h,),
                          Row(
                            children: [
                              getImage('',height: 30.h),
                              SizedBox(width: 10.w,),
                              TextView(
                                 title: "${model.orgFullLoadList[index].nameOfPerson}",
                                fontSize:15.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            children: [
                              SizedBox(width: 15.w,),
                              SvgPicture.asset('assets/sheild.svg',height: 12.h,width: 12.w,),
                              SizedBox(width: 20.w,),
                              TextView(
                                title: "${model.orgFullLoadList[index].type}",
                                fontSize:15.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                            ],
                          ),
                  SizedBox(height: 30.h,),
                  SizedBox(
                    width: 121.w,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColor.theme_blue,
                        onPrimary: Colors.white,
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
                    ],
                  ),
                )),
        );
      }
      ),
          ),
    );
  }
  getContainer(String title, int value,String count, Color bgColor, String img) {
    return InkWell(
     onTap: (){},
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
}
