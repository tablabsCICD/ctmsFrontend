import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../constant/images.dart';
import '../../locator.dart';
import '../../utils/colors.dart';
import '../base_widget/custom_button.dart';
import '../base_widget/custom_textfeild.dart';
import '../base_widget/custom_textview.dart';
import '../dialog/animated_custom_dialog.dart';
import '../dialog/my_dialog.dart';
import '../dialog/share_dialog_box.dart';
import '../model/truck_load_model.dart' show TruckLoad;
import '../provider/auth_provider.dart';
import '../provider/bid_provider.dart';

import 'app_constant.dart';
import 'color-resource.dart';


class Utils {
  String getTranport(int val) {
    switch (val) {
      case 0:
        return "Agents/Brokers";

      case 1:
        return "Transporters";

      case 2:
        return "PACKERS AND MOVERS";
      case 3:
        return "MANUFACTURERS";
      case 4:
        return "DISTRIBUTORS";
      case 5:
        return "CLEARING AND FORWARDING AGENTS";
      default:
        return "";
    }
  }

  String mainTag(String tag) {
    switch (tag) {
      case 'Full load available':
        return 'Full vehicle required';
      case 'Part load available':
        return 'Part vehicle required';
      case 'Full load required':
        return 'Full load required';
      case 'Part load required':
        return 'Part load required';

      case '':
    }

    return "";
  }

  final authProvider = locator<AuthProvider>();


  callFunction(BuildContext context, String mobile) async {
    if (authProvider.userDetailList[0].isPaid == 0) {
      getAdminSupportDailog(context);

    } else {
      showDialog(
          context: context,
          builder: (_) => new CupertinoAlertDialog(
            title: CustomText('Contact Number : $mobile',
                style: TextStyle(
                    color: ColorResources.BOTTOM_HEADING,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Ok",
                      style: TextStyle(
                          color: ColorResources.GREEN, fontSize: 18)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }
  }

  callShareFunction(String des, TruckLoad load, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShareDialogBox(load);
        });
  }

  getAdminSupportDailog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: CustomText(
              'For Upgrade Plan please connect To the below contact',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          content: Column(
            children: [
              SizedBox(height: 16),
              CustomText('Email Id :',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              CustomText('support@tkdconnect.in',
                  style: TextStyle(
                      color: ColorResources.PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              CustomText('Mobile Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              CustomText('(+91) 8123006888 / (+91) 8123004666',
                  style: TextStyle(
                      color: ColorResources.PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Ok",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  Future openwhatsapp(BuildContext context, int number, String text) async {
    final link = WhatsAppUnilink(
      phoneNumber: "+91 ${number}",
      text: text,
    );

    if (authProvider.userDetailList[0].isPaid == 0) {
      getAdminSupportDailog(context)
         ;
    } else {
      authProvider.userDetailList[0].transporterOrAgent == 3
          ? getAdminSupportDailog(context)
          : await launchUrl(Uri.parse(link.toString()));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final bidProvider = locator<BidProvider>();

  TextEditingController bidAmtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  labelText(String label) {
    return SizedBox(
      width: 332,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  openMenu(int a, TruckLoad load, BuildContext context) async {
    if (a == 0) {
      showAnimatedDialog(
          context,
          Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Form(
              key: _formKey,
              child: Container(
                height: 350,
                width: 300,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(children: [
                        CustomText(
                          'Place Your Quote',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        labelText("Quote Amount"),
                        CustomTextField(
                            controller: bidAmtController,
                            hintText: "Enter Your quote Amount",
                            isDigits: true,
                            textInputType: TextInputType.number),
                        labelText("Quote justification with cost(optional)"),
                        Visibility(
                          visible: true,
                          child: CustomTextField(
                              controller: descriptionController,
                              hintText: "quote justification with cost(optional)",
                              isValidator: false,
                              textInputType: TextInputType.text),
                        ),
                        CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                bidProvider
                                    .generateBid(context,
                                    mobile: authProvider
                                        .userDetailList[0].mobileNumber,
                                    description: descriptionController.text,
                                    idOfPost: load.id,
                                    email: authProvider
                                        .userDetailList[0].emailId,
                                    amount: bidAmtController.text,
                                    id: 0,
                                    bidderUserName: authProvider
                                        .userDetailList[0].userName,
                                    userName: authProvider
                                        .userDetailList[0].userName,
                                    type: load.mainTag,
                                    loggedUserName:
                                    '${authProvider.userDetailList[0].firstName} ${authProvider.userDetailList[0].lastName}')
                                    .then((value) => {
                                  showAnimatedDialog(
                                      context,
                                      MyDialog(
                                        icon: Icons.check,
                                        title: 'Generate Quote',
                                        description:
                                        'Your quote Created successfully',
                                        isFailed: false, isFromPost: true,
                                      ),
                                      dismissible: false,
                                      isFlip: false),
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            buttonText: "Submit")
                      ]),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
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
            ),
          ));
    } else {
      String description =
          "${load.mobileNumber.toString()}'Type : ${load.type}, \nSubject : ${load.content}, \nSource : ${load.source}, \nDestination : ${load.destination}, \nLink : https://api.tkdost.com/bids/?id=${load.id}'";

      switch (a) {
        case 1:
          Utils().openwhatsapp(context, load.mobileNumber!, description);
          return;
        case 2:
          await Utils().callFunction(context, "${load.mobileNumber}");
          return;

        case 3:
          Utils().callShareFunction(description, load, context);
          return;


      }
    }
  }



  bool isExpired(String expiryDateString) {
    if(expiryDateString==''){
      return false;
    }else{
      // Parse the string into a DateTime object
      DateTime expiryDate = DateTime.parse(expiryDateString);

      // Compare with the current date
      return DateTime.now().isAfter(expiryDate.add(const Duration(days: 1)));
    }
  }


  getSelectedPackageImage(int val) {
    switch (val) {
      case 0:
        return Images.pearls;

      case 10:
        return Images.pearls_blue;

      case 20:
        return Images.pearls_red;
      case 30:
        return Images.pearls_black;
    }
  }

  getSelectedPackageName(int val) {
    switch (val) {
      case 0:
        return "Clear";

      case 10:
        return "Blue";

      case 20:
        return "Red";
      case 30:
        return "Black";
    }
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
