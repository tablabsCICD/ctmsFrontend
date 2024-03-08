import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_hr_management/organization_portal/dialog/share_dialog_box.dart';
import 'package:flutter_hr_management/organization_portal/model/truck_load_model.dart';
import 'package:url_launcher/url_launcher.dart';

/*Future<void> share_data(TruckLoad loadTypeList) async {

  var shareData = {
    "title": loadTypeList.nameOfPerson,
    "text": loadTypeList.mobileNumber,
    "url": loadTypeList.sharableLink,
  };

  try{
    await html.window.navigator.share(shareData);
  }catch(e){
    print(e);
  }

}*/

Future shareSocialMedia(TruckLoad loadTypeList, SocialMedia socialMedia) async {

  final subject = loadTypeList.content.toString();
  final text = "Name: "+loadTypeList.nameOfPerson.toString()+
      "\nMobile Number: "+loadTypeList.mobileNumber.toString()+
      '\nType : ${loadTypeList.type}, '
          '\nSource : ${loadTypeList.source}, '
          '\nDestination : ${loadTypeList.destination}'
          '\nSubject : ${loadTypeList.content}, ';
  final urlShare =  Uri.encodeComponent(loadTypeList.sharableLink.toString());

 /* final urls = {
    SocialMedia.facebook:'https://www.facebook.com/sharer/sharer.php?u=${urlShare}&t=${text}',
    SocialMedia.whatsapp:'https://api.whatsapp.com/send?text=${text}',
    SocialMedia.email:'mailto:?subject=${subject}&body=${text}\n\n$urlShare',
    SocialMedia.twitter:'https://twitter.com/intent/tweet?url=${urlShare}&text=${text}\n$urlShare',
    SocialMedia.linkedin:'https://www.linkedin.com/shareArticle?url=$urlShare&title=$text',
    //'https://www.linkedin.com/shareArtical?mini=true&url=${urlShare}'
  };

  Map<SocialMedia,String>? socialPlatform;

  final url = urls[socialPlatform]!;*/

  switch(socialMedia){
    case SocialMedia.facebook :
      if(await canLaunchUrl(Uri.parse('https://www.facebook.com/sharer.php?u=$urlShare&t=$text'))){
        launchUrl(Uri.parse('https://www.facebook.com/sharer.php?u=$urlShare'));
      }
      break;
    case SocialMedia.whatsapp :
      if(await canLaunchUrl(Uri.parse('https://api.whatsapp.com/send?text=${text}'))){
        await launchUrl(Uri.parse('https://api.whatsapp.com/send?text=${text}'));
      }
      break;
    case SocialMedia.linkedin :
      if(await canLaunchUrl(Uri.parse('https://www.linkedin.com/shareArticle?url=$urlShare&title=$text'))){
        await launchUrl(Uri.parse('https://www.linkedin.com/shareArticle?url=$urlShare&title=$text'));
      }
      break;
    case SocialMedia.email :
      if(await canLaunchUrl(Uri.parse('mailto:?subject=$subject&body=$text'))){
        await launchUrl(Uri.parse('mailto:?subject=$subject&body=$text'));
      }
      break;
    case SocialMedia.twitter :
      if(await canLaunchUrl(Uri.parse('https://twitter.com/share?url=$urlShare&text=$text&via=$urlShare&hashtags=$subject'))){
        await launchUrl(Uri.parse('https://twitter.com/share?url=$urlShare&text=$text&via=$urlShare&hashtags=$subject'));
      }
      break;
    case SocialMedia.pintrest :
      if(await canLaunchUrl(Uri.parse('https://pinterest.com/pin/create/bookmarklet/?media=$text&url=$urlShare&idescription=$text'))){
        await launchUrl(Uri.parse('https://pinterest.com/pin/create/bookmarklet/?media=$text&url=$urlShare&idescription=$text'));
      }
      break;
    case SocialMedia.google :
      if(await canLaunchUrl(Uri.parse('https://plus.google.com/share?url=$urlShare'))){
        await launchUrl(Uri.parse('https://plus.google.com/share?url=$urlShare'));
      }
      break;
    case SocialMedia.evernote :
      if(await canLaunchUrl(Uri.parse('https://www.evernote.com/clip.action?url=$urlShare&title=$text'))){
        await launchUrl(Uri.parse('https://www.evernote.com/clip.action?url=$urlShare&title=$text'));
      }
      break;
    case SocialMedia.buffer :
      if(await canLaunchUrl(Uri.parse('https://bufferapp.com/add?text=$text&url=$urlShare'))){
        await launchUrl(Uri.parse('https://bufferapp.com/add?text=$text&url=$urlShare'));
      }
      break;
  }




}