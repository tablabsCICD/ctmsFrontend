import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/pages/widget/filter_button.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/progress_dialog.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BidList extends StatefulWidget {
  final bidProvider = locator<OrgProvider>();


  Organization organization;
  BidList(this.organization,{Key? key}) : super(key: key) {
    bidProvider.getOrgBidingList(organization.id!);
  }

  @override
  _BidListState createState() => _BidListState();
}

class _BidListState extends State<BidList> {


  String selectedTab = "Placed Quotes";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(29),
      child:Consumer<OrgProvider>(
        builder: (context, model, child) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                child: Row(
                  children: [
                    getCircularContainer(
                        "Placed Quotes",
                        (selectedTab == "Placed Quotes"),
                        0,
                        model),
                    getCircularContainer(
                        "Received Quotes",
                        (selectedTab == "Received Quotes"),
                        1,
                        model),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    title:'Total Quote : ${model.orgBigingList.length}',
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ) ,
                  Row(
                    children: [
                      filterIcon(model),
                      SizedBox(width: 10.w,),
                      SvgPicture.asset('assets/more_icon.svg')
                    ],
                  )
                ],
              ),
              SizedBox(height: 32.h,),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.white, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(20),
                child: /*model.orgBigingList.isEmpty
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
                    : */Table(
                  columnWidths: {
                    0: FlexColumnWidth(60),
                    1: FlexColumnWidth(40),
                    2: FlexColumnWidth(40),
                    3: FlexColumnWidth(40),
                    4: FlexColumnWidth(40),
                    5: FlexColumnWidth(40),
                    6: FlexColumnWidth(40),
                    7: FlexColumnWidth(40),
                    8: FlexColumnWidth(30),
                    9: FlexColumnWidth(70),
                  },
                  textBaseline: TextBaseline.ideographic,
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    /// Table Header
                    TableRow(
                      children: [
                        tableHeader("Material"),
                        tableHeader("Routes"),
                        tableHeader("Km"),
                        tableHeader("Total Quotes"),
                        tableHeader("Best Match"),
                        tableHeader("End Time"),
                        tableHeader("Status"),
                        tableHeader("Price"),
                        tableHeader("Action"),
                      ],
                    ),
                    for (int i=0;i<model.orgBigingList.length;i++)  tableRow(
                        context,
                        material: model.orgBigingList[i].companyName,
                        route1: model.orgBigingList[i].source,
                        route2: model.orgBigingList[i].destination,
                        km: '300',
                        totalBids: model.orgBigingList[i].bidingId.toString(),
                        bestMatch:'test',//model.orgBigingList[i].companyName,
                        endtime:'test',//model.orgBigingList[i].postingTime,
                        status: 'complete',//model.orgBigingList[i].description,
                        price: '${model.orgBigingList[i].amount.toString()}'
                    ),

                  ],
                ),
              ),



              //  getEmpTable(),
            ],
          ),
        ),
      ),
    );
  }

  filterIcon(OrgProvider model) {
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
                  _buildPopupMenu('Sort By Company Name A to Z', 0,model),
                  _buildPopupMenu('Sort By Company Name Z to A', 1,model),
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
      int? id, OrgProvider model,
      ) {
    return PopupMenuItem(
      child: Text(title,style: TextStyle(
      fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
        color: Colors.black),),
      onTap: () {
        if (id == 0) {
          model.orgBigingList.sort(
                  (b, a) => b.companyName!.compareTo(a.companyName!));
          setState(() {});
        } else {
          model.orgBigingList.sort(
                  (a, b) => b.companyName!.compareTo(a.companyName!));
          setState(() {});
        }
      },
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
          Column(
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
                Text(
                  route1!,
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
            km!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            totalBids!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            bestMatch!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            endtime!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            status!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            price!,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
           // width: 93.w,
            height: 26.h,
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
                title: "Quote Now",
                fontSize:13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ]);
  }

  getCircularContainer(
      String title, bool isSelected, int i, OrgProvider model) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = title;
          model.getFinalBuySellList(title);
        });
      },
      child: Container(
        width: 250.w,
        height: 150.h,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              Images.red_arrow,
              alignment: Alignment.center,
              width: 250.w,
              height: 100.h,
              color: isSelected ? Color(0xffC3262C) : Colors.white,
            ),
            Container(
              height: 100.h,
              width: 200.w,
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 20.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
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
