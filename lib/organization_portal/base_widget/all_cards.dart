import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../locator.dart';
import '../../pages/widget/card/base_widgets.dart';
import '../../pages/widget/toast.dart';
import '../../utils/colors.dart';
import '../model/truck_load_model.dart';
import '../provider/auth_provider.dart';
import '../provider/buy_sell_provider.dart';
import '../provider/delete_interface.dart';
import '../util/ResponsiveWidget.dart';
import '../util/utils.dart';

class AllCards {
  final buysellProvider = locator<BuySellProvider>();
  final authProvider = locator<AuthProvider>();

  Widget cardSellBuyPost(
      int index,
      BuildContext context,
      TruckLoad load,
      DeletePostInf postDelete, {
        int? userId,
        bool? isDashBoard,
      }) {
    return Container(
      width: 335,
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TAG
          Align(
            alignment: Alignment.topRight,
            child: Container(
              constraints: const BoxConstraints(minHeight: 18, maxWidth: 130),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xffd0a232),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                load.mainTag ?? "-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// PROFILE
          BaseWidget().profile(
            load.companyLogo ?? "",
            load.nameOfPerson ?? "-",
            load.companyName ?? "-",
            verify: 1,
          ),

          const SizedBox(height: 8),

          /// HEADING + DETAILS
          BaseWidget().headingWithDescription(
            load.topicName ?? "-",
            getDateObject(load.postingTime),
            load.mfgYear ?? "-",
            load.modelName ?? "-",
            load.estPrice ?? "-",
            false,
          ),
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
              getDateObject( load.postingTime ), "-", load.topicName!, '', true),
          SizedBox(height: 8),
          BaseWidget().heading("Job Description", load.content!,''),

        ],
      ),
    );
  }

  cardLoadHome(int index, BuildContext context, TruckLoad load, int userId,
      DeletePostInf postDelete, bool isOwnPost) {
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
            load.privatePost == 1
                ? SizedBox.shrink()
                : BaseWidget().profileWithUser(
                load.companyLogo!, load.nameOfPerson!, load.companyName!,
                verify: load.isverified!,
                transporterOrAgent: load.transporterOrAgent!),
            BaseWidget().routes(load.source!, load.destination!),
            SizedBox(
              height: 7,
            ),
            BaseWidget().heading(
                load.topicName!, getDateObject(
              load.postingTime
            ), load.content!),
         /*  BaseWidget().bidButton((val) {
              if (load.dnd == 1) {
                ToastMessage.show(context, "This is DND Post");
              } else {
                Utils().openMenu(val, load, context);
              }
            })*/
          ],
        ),
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
