import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tkd_app/locator.dart';
import 'package:tkd_app/model/truck_load_model.dart';
import 'package:tkd_app/provider/auth_provider.dart';
import 'package:tkd_app/provider/buy_sell_provider.dart';
import 'package:tkd_app/provider/delete_interface.dart';
import 'package:tkd_app/view/base_widget/home_base_widgets.dart';
import 'package:tkd_app/view/base_widget/utils.dart';

class AllCards {
  final buysellProvider = locator<BuySellProvider>();
  final authProvider = locator<AuthProvider>();

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
          load.userId == userId
              ? BaseWidget().deleteButton((val) {
                  if (val == 10) {
                    if (isDashBoard == true) {
                      buysellProvider.deleteBuySell(load.id!, index,
                          load.mainTag == "Sell vehicle" ? false : true);
                    } else {
                      postDelete.deleteOwnPost(load.id!, index);
                    }
                  } else {
                    Utils().openMenu(val, load, context);
                  }
                }, false)
              : BaseWidget().getInTouchButton((val) {
                  Utils().openMenu(val, load, context);
                })
        ],
      ),
    );
  }

  cardJobPost(
      int index, BuildContext context, TruckLoad load, DeletePostInf postDelete,
      {int userId = 0}) {
    return Container(
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
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 18,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: Color(0xFFd35e61),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Center(
                child: Text(
                  load.type!,
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
          BaseWidget().profileWithUser(
              load.companyLogo!, load.nameOfPerson!, load.companyName!,
              verify: load.isverified!,
              transporterOrAgent: load.transporterOrAgent!),
          BaseWidget().headingWithDescription("Job Title",
              getDateObject(load.postingTime), "-", load.topicName!, '', true),
          SizedBox(height: 8),
          BaseWidget().heading("Job Description", load.content!),
          load.userId == userId
              ? BaseWidget().deleteButton((val) {
                  if (val == 10) {
                  } else {
                    Utils().openMenu(val, load, context);
                  }
                }, false)
              : jobApply(load, context)
        ],
      ),
    );
  }

  Widget jobApply(TruckLoad load, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Utils().callFunction(context, load.mobileNumber.toString());
            },
            child: Container(
              height: 38,
              width: 240,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0x33001E49)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Call now',
                    style: TextStyle(
                      color: Color(0xFF001E49),
                      fontSize: 12,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //  SizedBox(width: 12),
          // SvgPicture.asset(Images.savejob),
          SizedBox(width: 12),
          InkWell(
              onTap: () {
                String Message =
                    "I am writing to express my strong interest in the our department" +
                        " From TKD Connect Application";
                Utils().openwhatsapp(context, load.mobileNumber!, Message);
              },
              child: SvgPicture.asset("assets/svg/message_job.svg")),
        ],
      ),
    );
  }

  getDateObject(String? dateTime) {
    try {
      DateTime formatedDate = DateTime.parse(dateTime!);
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

  imageLoad(TruckLoad load) {
    if (load.postImages!.length == 0) {
      return Column(
        children: [
          SizedBox(
            height: 0,
          ),
        ],
      );
    } else if (load.postImages!.length == 1) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: load.postImages!.first,
              placeholder: (context, url) =>
                  SvgPicture.asset("assets/svg/logo.svg"),
              errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "https://igps.net/wp-content/uploads/2018/08/shutterstock_711168088.jpg",
                    fit: BoxFit.fill,
                    width: 311,
                    height: 200,
                  )),
              fit: BoxFit.fill,
              width: 311,
              height: 200,
            ),
          ),
          SizedBox(
            height: 9,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
              transform: Matrix4.translationValues(0.0, -25.0, 00),
              child: Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  padEnds: false,
                  pageSnapping: false,
                  enableInfiniteScroll: false,
                ),
                items: load.postImages!
                    .map((item) => Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: imageLink(item!)),
                          ),
                        ))
                    .toList(),
              ))),
          SizedBox(
            height: 9,
          ),
        ],
      );
    }
  }

  Widget imageLink(String link) {
    return CachedNetworkImage(
      imageUrl: link,
      placeholder: (context, url) => SvgPicture.asset("assets/svg/logo.svg"),
      errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://igps.net/wp-content/uploads/2018/08/shutterstock_711168088.jpg",
            fit: BoxFit.fill,
            width: 311,
            height: 200,
          )),
      fit: BoxFit.fill,
      width: 311,
      height: 200,
    );
  }
}
