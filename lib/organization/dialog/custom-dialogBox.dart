import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization/constant.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/transport_serach_model.dart';
import 'package:flutter_hr_management/organization/provider/route_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';

class CustomDialogBox extends StatefulWidget {
  TransportSearchData transportList;
  bool? flag;
  CustomDialogBox(this.transportList, {this.flag});


  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final model = locator<RouteProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.getRouteListByUserId(widget.transportList.id!);
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: widget.flag == true ?Container(
        // padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
        //     + Constants.padding, right: Constants.padding,bottom: Constants.padding
        // ),
        margin: ResponsiveWidget.isDesktop(context)
            ?EdgeInsets.only(top: Constants.avatarRadius,left: 250,right: 250)
            :EdgeInsets.only(top: Constants.avatarRadius,left: 10,right: 10,bottom: 50),
        height: ResponsiveWidget.isDesktop(context)
          ?350
          :400,
          width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:ResponsiveWidget.isDesktop(context)?500:400,
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
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: ColorResources.HOME_APPBAR,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(' Contact No. : ',style: Style.title),
                      CustomText('${widget.transportList.mobileNumber}',style: Style.subtitle),
                    ],
                  ),
                )),
          //  SizedBox(height: 15,),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: ColorResources.HOME_BG,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(' Email_Id : ',style: Style.title),
                      CustomText('${widget.transportList.emailId}',style: Style.subtitle),
                    ],
                  ),
                )),
            //SizedBox(height: 15,),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: ColorResources.HOME_APPBAR,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(' Company Name : ',style: Style.title,),
                      Expanded(child: CustomText('${widget.transportList.companyName}',style: Style.subtitle,softWrap: true,
                        maxLines: 2,)),
                    ],
                  ),
                )),
            //SizedBox(height: 15,),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: ColorResources.HOME_BG,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(' Company Address : ',style: Style.title,),
                      Expanded(child: Text('${widget.transportList.companyAddress}',style: Style.subtitle,softWrap: true,
                        maxLines: 3,)
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  buttonText: "Ok"),

            )],
        )
      ):contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: ResponsiveWidget.isMobile(context)
              ?EdgeInsets.only(bottom: 10,left: 10,right: 10,top: Constants.padding+ Constants.padding+10)
              :EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: ResponsiveWidget.isDesktop(context)
              ?EdgeInsets.only(top: Constants.avatarRadius,left: 250,right: 250)
              :EdgeInsets.only(top: Constants.avatarRadius,left: 10,right: 10),
          width: ResponsiveWidget.isMobile(context)?MediaQuery.of(context).size.width-50:ResponsiveWidget.isDesktop(context)?500:400,

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
          child: Consumer<RouteProvider>(
          builder: (context, model, child) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomText('${widget.transportList.firstName} ${widget.transportList.lastName}',style: Style.title,textAlign: TextAlign.center,),
                SizedBox(height: 5,),
                CustomText('${widget.transportList.companyAddress}',style: Style.subtitle,textAlign: TextAlign.center,),
                SizedBox(height: 20,),

                widget.transportList.listOfPreferredRoutes.length != 0? CustomText('Operating Routes',style: Style.contentHeading):SizedBox.shrink(),
                widget.transportList.listOfPreferredRoutes.length != 0 ? Container(
                  height:  widget.transportList.listOfPreferredRoutes.length <= 3 ? 200 : 200,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.transportList.listOfPreferredRoutes.length,
                    itemBuilder: (contex,index){
                      return Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 10),
                        color: index.isEven
                            ? ColorResources.HOME_APPBAR
                            : ColorResources.HOME_BG,
                       /* child: ListTile(
                         title: CustomText('${model.routeList[index].routeSource} to ${model.routeList[index].routeDestination}',style: Style.cityHeading,),
                          trailing: ElevatedButton(
                            onPressed: (){
                              model.deleteRoute(model.routeList[index]);
                            },
                            child: Text('Delete'),
                          ),
                        ),*/
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${widget.transportList.listOfPreferredRoutes[index].routeSource}',style: Style.cityHeading,),
                            SizedBox(width: 5,),
                            Image.asset('assets/images/two_way_arrow.png',height: 15,width: 25,),
                            SizedBox(width: 5,),
                            Text('${widget.transportList.listOfPreferredRoutes[index].routeDestination}',style: Style.cityHeading,),
                          ],
                        )
                      );
                    },
                  ),
                ):Text("No Data Found!"),SizedBox.shrink(),
                SizedBox(height: 22,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      buttonText: "Ok"),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: widget.transportList.profilePicture.toString() == ""?
                Icon(
                    Icons.account_circle,
                    size: 75
                ):
                Image.network(widget.transportList.profilePicture.toString(),height: 75,width: 75,)

            ),
          ),
        ),
      ],
    );
  }
}
