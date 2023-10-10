import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization/constant.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/transport_serach_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/provider/route_provider.dart';
import 'package:flutter_hr_management/organization/share_data.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';

enum SocialMedia {whatsapp,facebook,email,twitter,linkedin,pintrest,google,evernote,buffer}



class ShareDialogBox extends StatefulWidget {
  TruckLoad loadTypeList;

  ShareDialogBox(this.loadTypeList);


  @override
  _ShareDialogBoxState createState() => _ShareDialogBoxState();
}

class _ShareDialogBoxState extends State<ShareDialogBox> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
                  margin: ResponsiveWidget.isDesktop(context)
              ?EdgeInsets.only(top: Constants.avatarRadius,left: 250,right: 250)
              :EdgeInsets.only(top: Constants.avatarRadius,left: 10,right: 10,bottom: 50),
          height: ResponsiveWidget.isDesktop(context)
              ?350
              :400,
          width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:ResponsiveWidget.isDesktop(context)?400:400,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child:Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Share Data Using....",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildSocialButton(
                          icon: Icons.mail,
                          color:Colors.red,
                          onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.email),
                          iconName: "Mail"
                      ),

                      buildSocialButton(
                        icon: FontAwesomeIcons.whatsapp,
                        color:Colors.green,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.whatsapp),
                        iconName: "WhatsApp"
                      ),
                      buildSocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        color:Colors.blue,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.linkedin),
                        iconName: "LinkeIn"
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildSocialButton(
                        icon: FontAwesomeIcons.twitter,
                        color:Colors.blue,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.twitter),
                        iconName: "Twitter"
                      ),
                      buildSocialButton(
                        icon: FontAwesomeIcons.googlePlus,
                        color:Colors.orange,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.google),
                        iconName: "GooglePlus"
                      ),
                      buildSocialButton(
                          icon: FontAwesomeIcons.facebookSquare,
                          color:Colors.blue,
                          onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.facebook),
                          iconName : "Facebook"
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildSocialButton(
                        icon: FontAwesomeIcons.pinterest,
                        color:Colors.red,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.pintrest),
                        iconName: "Pinterest"
                      ),
                      buildSocialButton(
                        icon: FontAwesomeIcons.evernote,
                        color:Colors.purple,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.evernote),
                        iconName: "EverNote"
                      ),
                      buildSocialButton(
                        icon: FontAwesomeIcons.buffer,
                        color:Colors.pink,
                        onClicked: ()=>shareSocialMedia(widget.loadTypeList,SocialMedia.buffer),
                        iconName: "Buffer"
                      ),
                    ],
                  )
                 ],
              ),
              Positioned(
                top: 7,
                right: 7,
                child: IconButton(
                  icon: Icon(Icons.close,size: 18,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          )
      )
    );
  }

  Widget buildSocialButton({required IconData icon,Color? color,required VoidCallback onClicked, required String iconName}){
    return InkWell(
      onTap: (){
        onClicked();
      },
      child: Container(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FaIcon(icon,color: color,size:40),
            ),
            Text(iconName),
          ],
        ),
      ),
    );
  }

}
