import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/organization_portal/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../../locator.dart';
import '../../../organization_portal/model/truck_load_model.dart';
import '../../../organization_portal/provider/dashboard_provider.dart';
import '../../../organization_portal/provider/delete_interface.dart';
import '../../../organization_portal/util/ResponsiveWidget.dart';
import '../../../utils/colors.dart';
import '../toast.dart';
import 'base_widgets.dart';

class AllCards {

  cardLoadHome(int index, BuildContext context, TruckLoad load, int userId,
      DeletePostInf postDelete, DashboardProvider provider, bool isOwnPost) {
    return Opacity(
      opacity: Utils().isExpired(load.expireDate!) || (load.isOpenForBid==0) ? 0.5 : 1.0,
      child: Container(
        width: 335,
        padding: EdgeInsets.all(12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x114A5568),
              blurRadius: 8,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible:load.expireDate==''?false:true,
              child: Container(
                width: 120,
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(2)
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: ThemeColor.red,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text("valid till: ${load.expireDate==''?"-":load.expireDate!}",
                    style: TextStyle(
                      color: ThemeColor.black,
                      fontSize: 8,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 50,
                width: 140,
                child: Column(
                  children: [
                    Text(
                      "TKD${load.id}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 18,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: ShapeDecoration(
                        color: Color(0xFF2C8FEA),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Center(
                        child: Text(
                          Utils().mainTag(load.mainTag!),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: load.privatePost == 1 ? 10 : 5),
            load.privatePost == 1
                ? SizedBox.shrink()
                : BaseWidget().profileWithUser(
                load.companyLogo!, load.nameOfPerson!, load.companyName!,
                verify: load.isverified!,
                transporterOrAgent: load.transporterOrAgent!),
            BaseWidget().routes(load.source!, load.destination!),
            SizedBox(
              height: 12,
            ),
            imageLoad(load),
            BaseWidget().heading(
                load.topicName!, getDateObject(load.postingTime), load.content!),
            load.userId == userId
                ? BaseWidget().deleteButton((val) {
              if (val == 5) {
                postDelete.rePost(load, false);
              } else if (val == 6) {
                postDelete.rePost(load, true);
              } else if (val == 10) {
                postDelete.deleteOwnPost(load.id!, index);
              } else if (val == 11) {
              } else if (val == 7) {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 0.0,
                      insetPadding: ResponsiveWidget.isMobile(context)
                          ? EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10)
                          : ResponsiveWidget.isTablet(context)
                          ? EdgeInsets.symmetric(
                          vertical: 50, horizontal: 50)
                          : EdgeInsets.symmetric(
                          vertical: 50, horizontal: 50),
                      backgroundColor: Colors.white,
                      child: Container(
                        width: ResponsiveWidget.isMobile(context)
                            ? MediaQuery.of(context).size.width - 50
                            : ResponsiveWidget.isDesktop(context)
                            ? 500
                            : 400,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 7,
                              right: 7,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                if (load.dnd == 1) {
                  ToastMessage.show(context, "This is DND Post");
                } else {
                  Utils().openMenu(val, load, context);
                }
              }
            },load,isOwnPost: isOwnPost)
                : BaseWidget().bidButton((val) {
              if (load.dnd == 1) {
                ToastMessage.show(context, "This is DND Post");
              } else {
                Utils().openMenu(val, load, context);
              }
            })
          ],
        ),
      ),
    );
  }

  cardLoad(int index, BuildContext context, TruckLoad load) {
    return Container(
      width: 335.w,
      // height: 255.h,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100.w,
              height: 18.h,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: ShapeDecoration(
                color: Color(0xFF2C8FEA),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
              ),
              child: Center(
                child: Text(
                  load.mainTag!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          BaseWidget().profile(
              load.companyLogo!, load.nameOfPerson!, load.companyName!,
              verify: load.isPaid!),
          BaseWidget().routes(load.source!, load.destination!),
          SizedBox(
            height: 12.h,
          ),
          imageLoad(load),
          BaseWidget().heading(load.topicName!, load.postingTime!.split(" ").first, load.content!),

          BaseWidget().bidButton((val) {
            Utils().openMenu(val, load, context);
          })
        ],
      ),
    );
  }

  final buysellProvider = locator<BuySellProvider>();
  cardSellBuyPost(
      int index, BuildContext context, TruckLoad load, DeletePostInf postDelete,
      {int? userId, bool? isDashBoard}) {
    return Container(
      width: 335,
      // height: 255,
      padding: EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 18,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: Color(0xffd0a232),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Center(
                child: Text(
                  load.mainTag!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          BaseWidget().profile(
              load.companyLogo!, load.nameOfPerson!, load.companyName!,
              verify: load.isverified!),
          BaseWidget().headingWithDescription(
              load.topicName!,
              getDateObject(load.postingTime),
              load.mfgYear!,
              load.modelName!,
              load.estPrice!,
              false),
          SizedBox(height: 8),
          imageLoad(load),

        ],
      ),
    );
  }

  imageLoad(TruckLoad load){
    if(load.postImages!.length==0){
      return    Column(
        children: [
          SizedBox(
            height: 0.h,
          ),

        ],
      );
    }else if(load.postImages!.length==1){
      return Column(
        children: [
          BaseWidget().image(image: load.postImages!.first),
          SizedBox(
            height: 9.h,
          ),
        ],
      );
    }else{

      return Column(
        children: [
          Container(
              transform: Matrix4.translationValues(0.0, -25.0.h, 00),
              child: BaseWidget().carouseImage(new List<String>.from(load.postImages!))),
          SizedBox(
            height: 9.h,
          ),
        ],
      );
    }

  }


  generalPost(TruckLoad truckLoad) {
    return Container(
      width: 335.w,

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: (){
                String des=truckLoad.topicName!+"\n "+truckLoad.content!;
                Utils().callShareFunction(des,truckLoad,context);
              },
              child: Container(
                width: 38.w,
                height: 38.h,
                child: SvgPicture.asset(
                  Images.share_icon,
                  height: 38.h,
                  width: 38.w,
                ),
              ),
            ),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -25.0.h, 00),
              child: BaseWidget().profile(truckLoad.companyLogo!, truckLoad.nameOfPerson!, truckLoad.companyName!,verify: truckLoad.isPaid!)),
          // SizedBox(
          //   height: 12.h,
          // ),
          Container(
              transform: Matrix4.translationValues(0.0, -25.0.h, 00),
              child: BaseWidget().heading(truckLoad.topicName!, "", truckLoad.content!)),
          SizedBox(
            height: 5.h,
          ),

          imagePost(truckLoad),

        ],
      ),
    );
  }

  getDateObject(String? dateTime) {
    try {
      DateTime formatedDate = DateTime.parse(dateTime!);
      print(formatedDate);
      var date1 = DateFormat("yyyy-MM-dd").format(formatedDate);
      var todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      if (date1 == todayDate) {
        date1 = DateFormat("H:mm").format(formatedDate);
      }
      return date1;
    } catch (e) {
      return dateTime;
    }
  }

  imagePost(TruckLoad load){
    if(load.postImages!.length==0){
      return    Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0.0, -20.0.h, 00),
            width: 311.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 311.w,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50.w,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0x332C363F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),

          Container(
              transform: Matrix4.translationValues(0.0, -10.0.h, 00),
              child: BaseWidget().likeComment())
        ],
      );
    }else if(load.postImages!.length==1){
      return Column(
        children: [
          BaseWidget().image(image: load.postImages!.first),
          SizedBox(
            height: 9.h,
          ),
          Container(
            //transform: Matrix4.translationValues(0.0, -5.0.h, 00),
              child: BaseWidget().likeComment())
        ],
      );
    }else{

      return Column(
        children: [
          Container(
              transform: Matrix4.translationValues(0.0, -25.0.h, 00),
              child: BaseWidget().carouseImage(new List<String>.from(load.postImages!))),
          SizedBox(
            height: 9.h,
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -10.0.h, 00),
              child: BaseWidget().likeComment())
        ],
      );
    }

  }

}