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

class DiscussionList extends StatefulWidget {
  final dashboardProvider = locator<OrgProvider>();
  final buySellProvider = locator<OrgProvider>();
  Organization organization;
  int index;
  DiscussionList(this.organization,{Key? key, required this.index}) : super(key: key) {
    dashboardProvider.getOrgFullLoadList(organization.id!);
  }
  @override
  State<DiscussionList> createState() => _DiscussionListState();
}

class _DiscussionListState extends State<DiscussionList> {
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
                  Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Spacer(),
                          Spacer(),
                          Row(
                            children: [
                              filterIconButton(),
                              SizedBox(
                                width: 27.w,
                              ),
                              SizedBox(
                                height: 51.h,
                                width: 127.w,
                                child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: ThemeColor.theme_blue,
                                        onPrimary: Colors.white),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        TextView(
                                          title: "New",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )),
                              ),
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
                  getPostList(context)
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
      builder: (context, model, child) => /*model.orgAllFullLoadList.isEmpty
          ? Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 400,
              child: Center(
                  child: TextView(
                      title: "No Record Found",
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w900))))
          :*/StaggeredGridView.countBuilder(
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
          itemCount: 2,
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
                    height: 253.h,
                    width: 511.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          horizontalTitleGap: 5,
                          minVerticalPadding: 0,
                          leading: getImage(model
                              .orgFullLoadList[index]
                              .companyLogo
                              .toString()),
                          title: CustomText(
                              model.orgFullLoadList[index]
                                  .nameOfPerson
                                  .toString(),
                              style: Style.title),
                          subtitle: CustomText(
                              model.orgFullLoadList[index]
                                  .companyName
                                  .toString(),
                              style: Style.subtitle),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 7),
                          child: CustomText(
                              model.orgFullLoadList[index]
                                  .topicName
                                  .toString(),
                              style: Style.title),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, bottom: 10, right: 10),
                          child: CustomText(
                            model.orgFullLoadList[index].content
                                .toString(),
                            style: Style.content,
                          ),
                        ),
                        Divider(
                          height: 1.5,
                          thickness: 1.5,
                        ),
                      ],
                    ),
                  )),
            );
          }
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
