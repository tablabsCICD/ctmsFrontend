// Updated BidList.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/progress_dialog.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BidList extends StatefulWidget {
  final bidProvider = locator<CompanyBidProvider>();
  Organization organization;
  BidList(this.organization, {Key? key}) : super(key: key) {
    bidProvider.getPlacedQuoteList(organization.id!);
  }

  @override
  _BidListState createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  String selectedFromDate = '';
  String selectedToDate = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33.0.w, vertical: 20.h),
      child: Consumer<CompanyBidProvider>(
        builder: (context, model, child) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  children: [
                    getCircularContainer("Placed Quotes", (model.selectedQuoteTab == "Placed Quotes"), 0, model),
                    SizedBox(width: 10.w),
                    getCircularContainer("Received Quotes", (model.selectedQuoteTab == "Received Quotes"), 1, model),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    title: 'Total Quote : ${model.orgBigingList.length}',
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  filterIcon(model)
                ],
              ),
              SizedBox(height: 32.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(20),
                child: model.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : model.orgBigingList.isEmpty
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.h),
                    child: Text(
                      "No Record Found",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.orgBigingList.length,
                  itemBuilder: (context, i) {
                    final item = model.orgBigingList[i];
                    final biding = item.bidingList?.isNotEmpty == true
                        ? item.bidingList!.last.bidings
                        : null;

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;

                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.grey.shade100],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Side Image
                              Container(
                                width: 90.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
                                  child: Image.asset(
                                    'assets/org/container.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Content Section
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(isWide ? 20.w : 14.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Company Name
                                      Text(
                                        item.genericCardsDto?.companyName ?? '-',
                                        style: TextStyle(
                                          fontSize: isWide ? 18.sp : 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[900],
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, size: 16.sp, color: Colors.blueGrey),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              "${item.genericCardsDto?.source ?? '-'} → ${item.genericCardsDto?.destination ?? '-'}",
                                              style: TextStyle(fontSize: 13.sp, color: Colors.blueGrey[600]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),

                                      // Info Chips
                                      Wrap(
                                        spacing: 8.w,
                                        runSpacing: 8.h,
                                        children: [
                                          _infoChip("📞", biding?.mobileNumber?.toString() ?? '-'),
                                          _infoChip("📊", item.bidingList?.length.toString() ?? '-'),
                                          _infoChip("✉️", biding?.emailId ?? '-'),
                                          _infoChip("👤", biding?.userName ?? '-'),
                                          _infoChip("✅", biding?.status?.toString() ?? '-'),
                                          _infoChip("💰", biding?.amount?.toString() ?? '-'),
                                        ],
                                      ),

                                      SizedBox(height: 12.h),

                                      // Action Buttons
                                      Row(
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.visibility, size: 18.sp),
                                            label: Text("View"),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                              ),
                                            ),
                                          ),
                                         /* SizedBox(width: 10.w),
                                          OutlinedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.check_circle_outline, size: 18.sp),
                                            label: Text("Approve"),
                                            style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                              ),
                                              side: BorderSide(color: Colors.blueGrey),
                                            ),
                                          ),*/
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for Chip UI
  Widget _infoChip(String icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 14.sp)),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(fontSize: 13.sp, color: Colors.blueGrey[700]),
          ),
        ],
      ),
    );
  }

// keep your existing filterIcon, _showDateWiseDialog, _buildText, getCircularContainer methods untouched


filterIcon(CompanyBidProvider model) {
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
                itemBuilder: (ctx) {
                  if(model.selectedQuoteTab=="Placed Quotes"){
                    return [
                      _buildPopupMenu('Sort By Company Name A to Z', 0,model),
                      _buildPopupMenu('Sort By Company Name Z to A', 1,model),
                      _buildPopupMenu('Sort By Date', 2,model),
                    ];
                  }else{
                    return [
                      _buildPopupMenu('Sort By Company Name A to Z', 0,model),
                      _buildPopupMenu('Sort By Company Name Z to A', 1,model),
                    ];
                  }
                },
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
        )
    );
  }

  PopupMenuItem _buildPopupMenu(
      String title,
      int? id, CompanyBidProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title,style: TextStyle(
          fontSize: 14.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w500,
          color: Colors.black),),
      onTap: () {
        if (id == 0) {
          model.orgBigingList.sort(
                  (b, a) => b!.genericCardsDto!.companyName!.compareTo(a.genericCardsDto!.companyName!));
          setState(() {});
        }else if (id == 1) {
          model.orgBigingList.sort(
                  (a, b) => b.genericCardsDto!.companyName!.compareTo(a.genericCardsDto!.companyName!));
          setState(() {});
        }else{
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
                  return _showDateWiseDialog(context, setState,model);
                }),
              );
            },
          );
        }
      },
    );
  }

  Widget _showDateWiseDialog(BuildContext context, StateSetter stateSetter,CompanyBidProvider model) {
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
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  child: _buildText(context, selectedFromDate, "Select From Date",
                          () async {
                        selectedFromDate =
                        await DateTimePickerDialog().pickBeforeDateDialog(context);
                        if (selectedFromDate == null) {
                          selectedFromDate = "Select From Date";
                        }
                        stateSetter(() {});
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 200.w,
                  child:
                  _buildText(context, selectedToDate, "Select To Date", () async {
                    selectedToDate =
                    await DateTimePickerDialog().pickDateDialog(context);
                    if (selectedToDate == '') {
                      selectedToDate = "Select To Date";
                    }
                    stateSetter(() {});
                  }),
                ),
                SizedBox(
                  height: 20.h,
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
                      if(selectedFromDate.isNotEmpty && selectedToDate.isNotEmpty){
                        model.getPlacedQuoteListByDate(selectedFromDate,selectedToDate,widget.organization.id!);
                        Navigator.of(context).pop();
                      }else{
                        showCustomToast(
                            context, "Please select date", Icons.clear, Colors.red);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildText(
      BuildContext context, String label, String label1, Function onClick) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Text(
              label1,
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
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 52.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow tableRow(context, {String? material,String? route1,String? route2,String? km,String? totalBids,String? bestMatch,String? endtime,String?status,String?price}) {
    return TableRow(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white
        ),
        children: [
          //Full Name
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/org/container.png',height: 82.h,width: 88.w,alignment: Alignment.centerLeft,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  material!,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            // height: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  route1!,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Container(
                    height: 30.h,
                    width: 1.w,
                    color: Colors.black,
                  ),
                ),
                Text(
                  route2!,
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Text(
            km==null?'-':km,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            totalBids=='0'?'-':totalBids!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            bestMatch==null?'-':bestMatch,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            endtime==null?'-':endtime,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            status==null?'-':status,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            price==null?'-':price,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          /*SizedBox(
           // width: 93.w,
            height: 26.h,
            child: ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.theme_blue,
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.r))),
              ),
              child: TextView(
                title: "Quote Now",
                fontSize:13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
          ),*/
        ]
    );
  }

  getCircularContainer(
      String title, bool isSelected, int i, CompanyBidProvider model) {
    return InkWell(
      onTap: () {
        setState(() {
          model.selectedQuoteTab = title;
          model.getFinalQuoteList(title,widget.organization!.id);
        });
      },
      child: Container(
        width: 200.w,
        height: 150.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? Color(0xffC3262C) : Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.only(top: 10.h,bottom: 20.h),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w700, color: AppColor.black,fontSize: 15.sp),
      ),
    );
  }
}
