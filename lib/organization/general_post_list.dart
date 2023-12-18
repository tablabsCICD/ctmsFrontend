import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/generated/l10n.dart';
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
import 'package:flutter_hr_management/organization/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/general_post_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/pages/widget/card/base_widgets.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GeneralPostList extends StatefulWidget {
  final generalPostProvider = locator<GeneralPostProvider>();
  Organization organization;
  GeneralPostList(this.organization,{Key? key}) : super(key: key) {
    generalPostProvider.getAllPost(organization.id!);
  }
  @override
  State<GeneralPostList> createState() => _GeneralPostListState();
}

class _GeneralPostListState extends State<GeneralPostList> {
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
    return Consumer<GeneralPostProvider>(
        builder: (context, model, child) => Container(
            padding: ResponsiveWidget.isDesktop(context)
                ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
                : EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                filterIcon(model),
            SizedBox(height: 30.h,),
                  getPostList(model,context),
                ]
            )
        )
    );

  }



  getPostList(GeneralPostProvider model,BuildContext context) {
    return /* model.isLoading==true?Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 400,
              child: Center(
                  child: CircularProgressIndicator()))):*/
      model.generalPostList.isEmpty
          ? Expanded(
          child: Container(
              height:
              MediaQuery.of(context).size.height - 400,
              decoration: BoxDecoration(
                  color: AppColor.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: TextView(
                      title: "No Record Found",
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w900))))
          :Expanded(
        child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            physics: ScrollPhysics(),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.fit(1),
            shrinkWrap: true,
            crossAxisCount: ResponsiveWidget.isDesktop(context)
                ? 3
                : ResponsiveWidget.isMobile(context)
                ? 1
                : 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            itemCount: model.generalPostList.length,
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
                      height: AppResponsive.isDesktop(context)?200.h:100.h,
                      // width: 510.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: getImage(''),
                            title: TextView(
                              title: "${model.generalPostList[index].title}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),
                            subtitle: TextView(
                              title: "${model.generalPostList[index].description}",
                              fontSize:15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff818080),
                            ),
                          ),
SizedBox(height: 16.h,),
                          Divider(),
                          SizedBox(height: 16.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                           // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Images.like),
                                  const SizedBox(width: 5),
                                  Text(
                                    S().like,
                                    style: TextStyle(
                                      color: Color(0xFF001E49),
                                      fontSize: 14.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Color(0xFF001E49),
                                      fontSize: 14.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Images.message),
                                  const SizedBox(width: 5),
                                  Text(
                                    S().comment,
                                    style: TextStyle(
                                      color: Color(0xFF001E49),
                                      fontSize: 14.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Color(0xFF001E49),
                                      fontSize: 14.sp,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                         // BaseWidget().likeComment(),
                        ],
                      ),
                    )),
              );
            }
        ),

      );
  }


  filterIcon(GeneralPostProvider model) {
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
                  _buildPopupMenu('Sort By Name A to Z', 0,model),
                  _buildPopupMenu('Sort By Name Z to A', 1,model),
                ],
              ),
              Text(
                "Filter",
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }

  String selectedTab='';
  PopupMenuItem _buildPopupMenu(
      String title, int? id,GeneralPostProvider model
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: (){
        if (id == 0) {
          model.generalPostList.sort(
                  (b, a) => b.title!.compareTo(a.title!));
          setState(() {});
        } else {
          model.generalPostList.sort(
                  (a, b) => b.title!.compareTo(a.title!));
          setState(() {});
        }
      },
    );
  }

}
