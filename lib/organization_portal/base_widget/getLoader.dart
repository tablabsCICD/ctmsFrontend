
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';

getLoader(bool loading){
  return  loading ? Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading....",style: Style.heading,),
          SizedBox(height: 10,),
          SpinKitCircle(
            color: Colors.grey,
           // size: 50.0,
          )
         ],
      )
  ) : SizedBox.shrink();
}