import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/generated/l10n.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/model/response/job_list.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/organization/company/jobs/create_job_screen.dart';
import 'package:flutter_hr_management/organization/model/job_model.dart';
import 'package:flutter_hr_management/organization/model/organization/job_applicant_model.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/job_list_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/pages/widget/card/base_widgets.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/date.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class JobListScreen extends StatefulWidget {
  Organization organization;

  JobListScreen(this.organization);

  @override
  State<StatefulWidget> createState() {
    return _JobListState();
  }
}

class _JobListState extends State<JobListScreen> {
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController jobLocationController = TextEditingController();
  TextEditingController jobDepartmentController = TextEditingController();


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
                            : EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                        child: Row(
                          children: [],
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
                        model.loginDeatils!.data!.isAdmin==false?SizedBox.shrink():SizedBox(
                          height: 58.h,
                          width: 180.w,
                          child: ElevatedButton(
                              onPressed: () {
                                _showAlertDialog(model);
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
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.white, borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 33.w,vertical: 20.h),
                  child: model.listJobs.isEmpty
                      ? Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 600,
                          child: Center(
                              child: TextView(
                                  title: "No Record Found",
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)))
                      : Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths:model.loginDeatils!.data!.isAdmin==false?{
                      0: FlexColumnWidth(50),
                      1: FlexColumnWidth(70),
                      2: FlexColumnWidth(30),
                      3: FlexColumnWidth(30),
                      4: FlexColumnWidth(30),
                      5: FlexColumnWidth(30),
                      6: FlexColumnWidth(10),
                    }: {
                      0: FlexColumnWidth(50),
                      1: FlexColumnWidth(70),
                      2: FlexColumnWidth(30),
                      3: FlexColumnWidth(30),
                      4: FlexColumnWidth(30),
                      5: FlexColumnWidth(30),
                      6: FlexColumnWidth(30),
                    },
                    children: [
                      /// Table Header
                      TableRow(
                        children: [
                          tableHeader("Job Title"),
                          tableHeader("Jod Description"),
                          tableHeader("Experience"),
                         // tableHeader("Experience"),
                          tableHeader("Job Type"),
                          tableHeader("Salary"),
                          tableHeader("Date"),
                          tableHeader("Applicants"),
                          model.loginDeatils!.data!.isAdmin==false?SizedBox.shrink():tableHeader(""),
                        ],
                      ),
                      /// Table Data
                      for (int i = 0; i < model.listJobs.length; i++)
                        tableRow(context, model.listJobs[i],
                            id: model.listJobs[i].postJob!.id,
                            color: Colors.blue,
                            title: model.listJobs[i].postJob!.message,
                            jd: model.listJobs[i].postJob!.jobDescription,
                            experience: model.listJobs[i].postJob!.experience,
                            salary: model.listJobs[i].postJob!.salary,
                            date: model.listJobs[i].postJob!.postingTime,
                            jobType: model.listJobs[i].postJob!.jobType,
                            index: i),
                    ],
                  ),
                ),
               /* model.listJobs.isEmpty
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
                            crossAxisCount: ResponsiveWidget.isDesktop(context)
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
                                child: jobCard(model.listJobs[index], model),
                              );
                            },
                            shrinkWrap: true,
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(1),
                          ),
                        ),
                      ),*/
                //  getLoader(model.isLoading)
              ],
            ));
  }

  TableRow tableRow(context, JobData jobData,
      {id, title, jd, experience, color, index, date,jobType,salary}) {
    return TableRow(
        children: [
          Container(
            height: 100.h,
            alignment: Alignment.centerLeft,
            child: TextView(
                title: title,
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300),
          ),

          TextView(
              title: jd,
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: experience,
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: jobType,
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: salary,
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: date,
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          InkWell(
              onTap: () async{
                await jobProvider.getAllJobApplicantsByJobId(jobData.postJob!.id!);
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // user must tap button!
                  builder: (BuildContext context) {
                    return Dialog(
                      alignment: Alignment.centerRight,
                      backgroundColor: Colors.transparent,
                      insetAnimationDuration: Duration(milliseconds: 200),
                      insetAnimationCurve: Curves.easeOutExpo,
                      // <-- SEE HERE
                      child: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return DispalyApplicants(setState);
                          }),
                    );
                  },
                );
              },
              child: Text("View",style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                decoration: TextDecoration.underline
              ),)),
          jobProvider.loginDeatils!.data!.isAdmin==false?SizedBox.shrink():InkWell(
              onTap: () {
                jobProvider.deleteJob(jobData);
              },
              child: Icon(Icons.delete, color: Colors.red)),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    jobProvider.deleteJob(jobData);
                  },
                  child: Icon(Icons.delete, color: Colors.red)),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                  onTap: () {

                  },
                  child: Icon(Icons.edit, color: Colors.grey)),
            ],
          )*/
        ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextView(
          title: text,
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w900),
    );
  }

/*  _buildPage(BuildContext context) {
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
                          child: jobCard(provider.listJobs[i],model),
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
  }*/

  jobCard(JobData jobData, JobListProvider model) {
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
                  jobData.postJob!.experience == null
                      ? "No Info"
                      : jobData.postJob!.experience! + " Year",
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
          SizedBox(height: 8.h),
          BaseWidget().jobHeading(jobData.postJob!.salary!),
          BaseWidget().heading(
              jobData.postJob!.message!,
              jobData.postingDate != null ? jobData.postingDate! : "",
              jobData.postJob!.jobDescription!),
          SizedBox(height: 8.h),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFD25D5D), onPrimary: Colors.white),
              onPressed: () {
                model.deleteJob(jobData);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ))
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
          SvgPicture.asset(
            Images.savejob,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 12.w),
          SvgPicture.asset(
            Images.message_job,
            height: 45.h,
            width: 45.w,
          ),
        ],
      ),
    );
  }

  filterIcon(JobListProvider model) {
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
                  _buildPopupMenu('Sort By Name A to Z', 0, model),
                  _buildPopupMenu('Sort By Name Z to A', 1, model),
                ],
              ),
              Text(
                "Filter",
                style: TextStyle(
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
    String title,
    int? id,
    JobListProvider model,
  ) {
    return PopupMenuItem(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16.sp,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w500,
            color: Colors.black),
      ),
      onTap: () {
        if (id == 0) {
          model.listJobs.sort(
              (b, a) => b.postJob!.jobDescription!.compareTo(a.postJob!.jobType!));
          setState(() {});
        } else {
          model.listJobs.sort(
              (a, b) => b.postJob!.jobDescription!.compareTo(a.postJob!.jobType!));
          setState(() {});
        }
      },
    );
  }

  Future<void> _showAlertDialog(JobListProvider model) async {
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
            return createJob(setState, model);
          }),
        );
      },
    );
  }

  String? uploadedDocument;

  createJob(StateSetter stateSetter, JobListProvider model) {
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    )),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "Create Job",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildTextField('Job Title', 'Job Title', jobTitleController),
            SizedBox(height: 16.h),
            _buildTextField('Job Description', 'Please enter Job Description',
                jobDescController),
            SizedBox(height: 16.h),
            _buildTextField('Salary', 'Please enter Salary', salaryController),
            SizedBox(height: 16.h),
            _buildTextField(
                'Experience', 'Please enter Experience', experienceController),
            SizedBox(height: 16.h),
            _buildTextField('Job Location', 'Please enter Job Location',
                jobLocationController),
            SizedBox(height: 16.h),
            _buildTextField('Department', 'Please enter Job Department',
                jobDepartmentController),
            SizedBox(height: 16.h),
            _buildDropdownField('Job Type', 'Please select job type',
                jobTypeController, stateSetter),
            SizedBox(height: 16.h),
            InkWell(
              onTap: () {
                _submitForm(model);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeColor.theme_blue,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Center(
                  child: Text(
                    "Create",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  final orgProvider = locator<OrgProvider>();
  final jobProvider = locator<JobListProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobProvider.getLoginDetails();
  }

  void _submitForm(JobListProvider model) async {
    EasyLoading.show(status: "Loading");
    var status = await model.createJob(
        widget.organization.companyName,
        widget.organization.companyMobileNumber,
        orgProvider.userList[0].emailId,
        jobLocationController.text,
        0,
        salaryController.text,
        GetDateFormat.getNextMonthDateOfCurrentDate(),
        orgProvider.userList[0].userName,
        jobDescController.text,
        "Jobs",
        jobTypeController.text,
        jobTitleController.text,
        jobDepartmentController.text,
        0,
        0,
        experienceController.text);
    EasyLoading.dismiss();
    if (status == 200) {
      showCustomToast(context, "Job Created", Icons.check, Colors.green);
    } else {
      showCustomToast(context, "Please Try Again", Icons.clear, Colors.red);
    }
    Navigator.of(context).pop();
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: label=='Job Description'?75.h:52.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                    color: Color(0xffcccccc),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String dropdownvalue = 'Full Time';
  var items = [
    'Full Time',
    'Part Time',
  ];

  Widget _buildDropdownField(String label, String hint,
      TextEditingController controller, StateSetter stateSetter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 10.h,
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
                value: dropdownvalue,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                borderRadius: BorderRadius.circular(5.0),
                underline: SizedBox.shrink(),
                hint: Text(
                  "Full Load",
                  style: TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                items: items.map((String items) {
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
                    dropdownvalue = newValue!;
                    jobTypeController.text = dropdownvalue;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  DispalyApplicants(StateSetter setState) {
    return Consumer<JobListProvider>(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 33.w,vertical: 20.h),
        child: model.jobApplicantList.isEmpty
            ? Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 600,
                child: Center(
                    child: TextView(
                        title: "There is no applicant in this job role!!",
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)))
            : Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(20),
            1: FlexColumnWidth(50),
            2: FlexColumnWidth(30),
            3: FlexColumnWidth(40),
            4: FlexColumnWidth(30),
            5: FlexColumnWidth(30),
          },
          children: [
            /// Table Header
            TableRow(
              children: [
                tableHeader("No."),
                tableHeader("Applicant Name"),
                tableHeader("Contact"),
                tableHeader("EmailId"),
                tableHeader("Qualification"),
                tableHeader("Resume"),
              ],
            ),
            /// Table Data
            for (int i = 0; i < model.jobApplicantList.length; i++)
              applicantTableRow(context, model.jobApplicantList[i],i),
          ],
        ),
      ),
    );
  }

  TableRow applicantTableRow(context, ApplicantList jobApplicantList,int index
      ) {
    return TableRow(
        children: [
          Container(
            height: 100.h,
            alignment: Alignment.centerLeft,
            child: TextView(
                title: '-',//jobApplicantList.applicationId.toString(),
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300),
          ),
          TextView(
              title: jobApplicantList.firstName.toString()+" "+jobApplicantList.lastName.toString(),
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: jobApplicantList.mobile.toString(),
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: jobApplicantList.emailId.toString(),
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          TextView(
              title: jobApplicantList.qualification==''?"-":jobApplicantList.qualification.toString(),
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300),
          jobApplicantList.document=='-'?TextView(
              title: "-",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w300)
          :InkWell(
              onTap: () async {
                final url =Uri.parse(jobApplicantList.document.toString());
                if (!await launchUrl(url,)) {
                throw Exception('Could not launch $url');
                }
              },
              child: Text("View Resume",style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  decoration: TextDecoration.underline
              ),
              )
          )
        ]);
  }
}


