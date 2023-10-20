import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
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
        builder: (context, model, child) => Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  title:'Total Bids : 54',
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ) ,
                Row(
                  children: [
                    filterIconButton(),
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
               /* columnWidths: {
                  0: FlexColumnWidth(70),
                  1: FlexColumnWidth(50),
                  2: FlexColumnWidth(50),
                  3: FlexColumnWidth(50),
                  4: FlexColumnWidth(70),
                  5: FlexColumnWidth(70),
                  6: FlexColumnWidth(70),
                  7: FlexColumnWidth(70),
                  8: FlexColumnWidth(70),
                },*/
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  /// Table Header
                  TableRow(
                    children: [
                      tableHeader("Material"),
                      tableHeader("Routes"),
                      tableHeader("Km"),
                      tableHeader("Total Bids"),
                      tableHeader("Best Match"),
                      tableHeader("End Time"),
                      tableHeader("Status"),
                      tableHeader("Price"),
                      tableHeader("Action"),
                    ],
                  ),
                  for (int i=0;i<2/*model.orgBigingList.length*/;i++)  tableRow(
                      context,
                      material: 'test',//model.orgBigingList[i].companyName,
                      route1: 'test',//model.orgBigingList[i].source,
                      route2: 'test',//model.orgBigingList[i].destination,
                      km: 'test',//model.orgBigingList[i].mobileNumber,
                      totalBids: 'test',//model.orgBigingList[i].bidingId,
                      bestMatch:'test',//model.orgBigingList[i].companyName,
                      endtime:'test',//model.orgBigingList[i].postingTime,
                      status: 'test',//model.orgBigingList[i].description,
                      price: 'test',//model.orgBigingList[i].amount
                  ),

                ],
              ),
            ),



            //  getEmpTable(),
          ],
        ),
      ),
    );
  }

  TableRow tableRow(context, {material, route1,route2, km, totalBids, bestMatch, endtime,status,price,action}) {
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
                material,
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Text(
            route1,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            km,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            totalBids,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            bestMatch,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            endtime,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            status,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            price,
            style:TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            width: 93.w,
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
                title: "Bid Now",
                fontSize:15.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ]);
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
