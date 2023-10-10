
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization/base_widget/rating_star.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/pool_purchase_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/open_whatsapp.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization/share_data.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/date_converter.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';

class PoolPurchaseDetailsScreen extends StatefulWidget {
  PoolPurchase poolPurchase;
  PoolPurchaseDetailsScreen(this.poolPurchase);

  @override
  _PoolPurchaseDetailsScreenState createState() => _PoolPurchaseDetailsScreenState();
}

class _PoolPurchaseDetailsScreenState extends State<PoolPurchaseDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.PRIMARY_COLOR,
        title: CustomText('Pool Purchase Details'),),
      body: Container(
        child: ResponsiveWidget.isMobile(context)
            ? Stack(children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('assets/images/truck.png'),
              ),
            ),
            child: getCart()
          ),
        ])
            : Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('assets/images/truck.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: getCart(),
            ),

          ],
        ),
      ),

    );
  }

  getCart(){
    return Container(
      width: ResponsiveWidget.isMobile(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width/2,
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              horizontalTitleGap: 5,
              minVerticalPadding: 0,
              leading: getImage(widget.poolPurchase.profilePicture.toString()),
              title: Row(
                children: [
                  CustomText(
                      widget.poolPurchase.firstName
                          .toString(),
                      style: titleTextStyle),
                  SizedBox(width: 5,),
                  CustomText(
                      widget.poolPurchase.lastName
                          .toString(),
                      style: titleTextStyle),
                ],
              ),
              subtitle: CustomText(
                  widget.poolPurchase.mobileNumber.toString(),
                  style: subTitleTextStyle),
              trailing: ConvertStringToDate(widget
                  .poolPurchase.purchasePlannedDate
                  .toString()),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 7),
              child: CustomText(
                  widget.poolPurchase.purchaseItem.toString(),
                  style: titilliumSemiBold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, bottom: 10, right: 10),
              child: CustomText(
                widget.poolPurchase.description.toString(),
                style: regularTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, bottom: 10, right: 10),
              child: CustomText(
                widget.poolPurchase.ownerName.toString(),
                style: regularTextStyle,
              ),
            ),
            Divider(
              height: 1.5,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 7),
              child: CustomText(
                  'Other Details',
                  style: titilliumSemiBold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, bottom: 10, right: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Email_Id',
                        style: regularTextStyle,
                      ),
                      CustomText('Alternate Number', style: regularTextStyle),
                      CustomText('Vehicle Size', style: regularTextStyle),
                      CustomText('User Type', style: regularTextStyle),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        ': ${widget.poolPurchase.emailId.toString()}',
                        style: TextStyle(
                            color: ColorResources.PRIMARY_COLOR),
                      ),
                      CustomText(
                        ': ${widget.poolPurchase.contactNumber.toString()}',
                        style: TextStyle(
                            color: ColorResources.PRIMARY_COLOR),
                      ),
                      CustomText(
                        ': ${widget.poolPurchase.city.toString()}',
                        style: TextStyle(
                            color: ColorResources.PRIMARY_COLOR),
                      ),
                      CustomText(
                        ': ${widget.poolPurchase.type.toString()}',
                        style: TextStyle(
                            color: ColorResources.PRIMARY_COLOR),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.5,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      var shareData = {
                        "title": widget.poolPurchase
                            .agentName,
                        "text": widget.poolPurchase
                            .mobileNumber,
                        "url": 'link',
                      };
                      try {
                        await html.window.navigator
                            .share(shareData);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/share.png',
                          color: ColorResources.PRIMARY_COLOR,
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            getTranslated("share", context)!,
                            style: Style.bottomHeading)
                      ],
                    ),
                  ),
                  Container(
                    width: 1.5,
                    height: 30,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      openwhatsapp(
                          context,
                          widget.poolPurchase
                              .mobileNumber
                              .toString(),
                          'Type : ${widget.poolPurchase.type}, \nPurchase Item : ${widget.poolPurchase.purchaseItem}, \nSubject : ${widget.poolPurchase.description}');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/chat.png',
                          color: ColorResources.PRIMARY_COLOR,
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                            getTranslated("chat", context)!,
                            style: Style.bottomHeading)
                      ],
                    ),
                  ),
                  Container(
                    width: 1.5,
                    height: 30,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) =>
                          new CupertinoAlertDialog(
                            title: CustomText(
                                'Contact Number : ${widget.poolPurchase.mobileNumber}',
                                style: TextStyle(
                                    color:
                                    ColorResources
                                        .BOTTOM_HEADING,
                                    fontSize: 18,
                                    fontWeight:
                                    FontWeight
                                        .bold)),
                            actions: <Widget>[
                              TextButton(
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(10.0),
                                  child: CustomText(
                                      getTranslated(
                                          'ok',
                                          context)!,
                                      style: TextStyle(
                                          color:
                                          ColorResources
                                              .GREEN,
                                          fontSize:
                                          18)),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop();
                                },
                              ),
                            ],
                          ));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/call.png',
                          color: ColorResources.PRIMARY_COLOR,
                          height: 14,
                          width: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            "Call",
                            style: Style.bottomHeading)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1.5,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: RatingStar()),
            ),
          ],
        ),
      ),
    );
  }
}
