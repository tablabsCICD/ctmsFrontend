import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

Future openwhatsapp(BuildContext context,String number,String text,) async{
/*  var whatsapp = number;
  var whatsappURl_android = "https://www.getwidget.dev/blog/flutter-dropdown-widget/  ";
  var whatappURL_ios ="https://pub.dev/packages/url_launcher";

  if (!await launch(whatsappURl_android)) throw 'Could not launch $whatsappURl_android';*/

  final link = WhatsAppUnilink(
    phoneNumber: "+91 ${number}",
    text: text,
  );

  await launch('$link');
}