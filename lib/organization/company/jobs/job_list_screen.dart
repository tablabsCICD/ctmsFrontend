import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/generated/l10n.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/organization/company/jobs/create_job_screen.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/job_list_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/pages/widget/card/base_widgets.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class JobListScreen extends StatefulWidget {
  Organization organization;
  JobListScreen(this.organization);

  @override
  State<StatefulWidget> createState() {
    return _JobListState();
  }
}

class _JobListState extends State<JobListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobListProvider>(
        builder: (context, model, child) => Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  child: Padding(
                    padding: ResponsiveWidget.isDesktop(context)
                        ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
                        : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [

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
                    SizedBox(
                      height: 58.h,
                      width: 180.w,
                      child: ElevatedButton(
                          onPressed: () {
                            _showAlertDialog();
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
                                title: "Create Job",
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
                  ],
                ),
              ],
            ),
            model.listJobs.isEmpty
                ? Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                        child: Text(
                          "No Record Found",
                          style: Style.heading,
                        ))))
                : Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 39.w, vertical: 31.h),
                child: StaggeredGridView.countBuilder(
                  physics: ScrollPhysics(),
                  crossAxisCount:
                  ResponsiveWidget.isDesktop(context)
                      ? 3
                      : ResponsiveWidget.isMobile(context)
                      ? 1
                      : 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: model.listJobs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: jobCard(model.listJobs[index]),
                    );
                  },
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.fit(1),
                ),
              ),
            ),
            //  getLoader(model.isLoading)
          ],
        )
    );
  }

  _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            BaseWidget().appBarSearchFilter(context, S().jobs),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Consumer<JobListProvider>(
                builder: (context, provider, child) {
                  return RefreshIndicator(
                    onRefresh: ()async{
                      provider.selectedPage=0;
                      provider.getAllJobs();
                    },
                    child: ListView.builder(
                      controller: provider.scrollController,
                      itemCount: provider.listJobs.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 12.h, left: 20.w, right: 20.w),
                          child: jobCard(provider.listJobs[i]),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }


  jobCard(JobData jobData) {
    return Container(
      width: 335.w,
      // height: 417.h,
      padding: EdgeInsets.all(12.r),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8.r,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 62.w,
              height: 18.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: ShapeDecoration(
                color: Color(0xFFD25D5D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
              ),
              child: Center(
                child: Text(
                  jobData.postJob!.experience==null?
                      "No Info":jobData.postJob!.experience! + " Year",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontFamily: AppConstants.FONTFAMILY,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          BaseWidget().profile(
              "",
              jobData.name != null ? jobData.name! : "No Info",
              jobData.postJob!.companyName != null
                  ? jobData.postJob!.companyName!
                  : "No Info"),
          SizedBox(width: 8.w),
          BaseWidget().jobHeading(jobData.postJob!.salary!),
          BaseWidget().heading(
              jobData.postJob!.jobDepartment!,
              jobData.postingDate != null ? jobData.postingDate! : "",
              jobData.postJob!.jobDescription!),
          SizedBox(width: 8.w),
       //   jobApply(),
        ],
      ),
    );
  }

  Widget jobApply() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 8.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 38.h,
            width: 203.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50.w, color: Color(0x33001E49)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Apply now',
                  style: TextStyle(
                    color: Color(0xFF001E49),
                    fontSize: 12.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(Images.savejob,height: 40.h,width: 40.w,),
          SizedBox(width: 12.w),
          SvgPicture.asset(Images.message_job,height: 45.h,width: 45.w,),
        ],
      ),
    );
  }
  filterIcon(JobListProvider model) {
    return Container(
        width: 125.w,
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
            children: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: SvgPicture.asset(
                  Images.filter,
                  height: 19.h,
                  width: 20.w,
                ),
                onSelected: (value) {},
                itemBuilder: (ctx) => [
                  _buildPopupMenu('Sort By Name A to Z', 0,model),
                  _buildPopupMenu('Sort By Name Z to A', 1,model),
                ],
              ),
              Text(
                "Filter",
                style: TextStyle(
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

  PopupMenuItem _buildPopupMenu(
      String title,
      int? id, JobListProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title, style: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: () {
        if (id == 0) {
          model.listJobs.sort(
                  (b, a) => b.postJob!.jobType!.compareTo(a.postJob!.jobType!));
          setState(() {});
        } else {
          model.listJobs.sort(
                  (a, b) => b.postJob!.jobType!.compareTo(a.postJob!.jobType!));
          setState(() {});
        }
      },
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.centerRight,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: Duration(milliseconds: 200),
          insetAnimationCurve: Curves.easeOutExpo,
          // <-- SEE HERE
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return addemp(setState);
              }),
        );
      },
    );
  }

  List<dynamic> foundEmp = [];
  List<dynamic> uniqueFoundEmp = [];
  List<dynamic> EmployeeList = [];

  bool isLoad=false;


  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, StateSetter stateSetter) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = EmployeeList;
    } else {
      results = EmployeeList
          .where((user) =>
          user.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    stateSetter(() {
      foundEmp = results.toSet().toList();
    });
  }

  addemp(StateSetter stateSetter) {
    return  Container(
      width: 350.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          TextField(
            onChanged: (value) => _runFilter(value,stateSetter),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }


  getUserDetails(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      child: Row(
          children: [
            SizedBox(
              width: 150.w,
              child: TextView(
                title: title,
                fontSize:12.sp,
                fontWeight: FontWeight.w300,
                color: Color(0xff000000),
              ),

            ),
            SizedBox(
              width: 50.w,
              child: TextView(
                title: ':',
                fontSize:12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),

            ),
            TextView(
              title: value,
              fontSize:12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
          ]

      ),
    );
  }
}
