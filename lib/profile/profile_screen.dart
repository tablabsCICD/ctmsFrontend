import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';

import '../common/app_colors.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late LoginDeatils loginDeatils;
  bool isload=true;

  @override
  void initState() {
    // TODO: implement initState
    inCallData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: isload?Center(
          child: CircularProgressIndicator(),

        ):Container(
          height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(30),
            ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWidget(title: "Profile"),
              Row(
                children: <Widget>[
                  Image.asset("assets/user1.jpg", height: 220),
                  SizedBox(
                    width: 20,
                  ),
                  Container(

                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                         loginDeatils.data!.firstName!+" "+loginDeatils.data!.lastName!,
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          loginDeatils!.data!.role!.name!,
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Engginering degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.pin_drop_outlined),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    loginDeatils!.data!.address!,
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.watch_later),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Contact Info",
                                style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                   "Email : ${loginDeatils!.data!.emailId!}",
                                    style: TextStyle(color: Colors.grey),
                                  )),

                              Container(
                                  width:
                                  MediaQuery.of(context).size.width - 268,
                                  child: Text(
                                    "Mobile : ${loginDeatils!.data!.mobileNumber!}",
                                    style: TextStyle(color: Colors.grey),
                                  ))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }


  void inCallData()async {

    loginDeatils=await LocalSharePreferences.localSharePreferences.getLoginData();
    isload=false;
    setState(() {

    });
  }
}

class IconTile extends StatelessWidget {
  final String? imgAssetPath;
  final Color? backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath!,
          width: 20,
        ),
      ),
    );
  }



}