import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';

import '../common/app_colors.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Container(
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
                          "Stefeni Albert",
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          "Project Manger",
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
                                    "House # 2, Road # 5, Green Road Dhanmondi, India, India",
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
                                "Todays Hours",
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
                                    '''Monday - Friday
Open till 7 Pm''',
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