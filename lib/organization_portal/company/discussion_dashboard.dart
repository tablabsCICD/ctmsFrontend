import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/appbar.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';
import 'package:flutter_hr_management/organization_portal/model/discussion_model.dart';
import 'package:flutter_hr_management/organization_portal/network/api_call.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'discussion_details.dart';
import 'discussion_new.dart';

class DiscussionDashboard extends StatefulWidget {
  // const ({Key? key}) : super(key: key);

  @override
  _DiscussionDashboardState createState() => _DiscussionDashboardState();
}

class _DiscussionDashboardState extends State<DiscussionDashboard> {
  List<DiscussionContent> discussionList = [];
  String? langCode;
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();
  var selectedPageNumber = 0;

  @override
  void initState() {
   /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (isLoading == false) {
          selectedPageNumber++;
          GetDiscussionApi();
        }
      }
    });*/
    GetDiscussionApi();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,

      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
           /* discussionList.isEmpty && isLoading == true
                ? Visibility(
              visible: false,
                  child: Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                              child: Text(
                            getTranslated('no_post', context)!,
                            style: Style.heading,
                          )))),
                )
                : discussionList.isEmpty && isLoading
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                      )
                    :*/ Expanded(
                        child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        physics: ScrollPhysics(),
                        crossAxisCount: ResponsiveWidget.isDesktop(context)
                            ? 2
                            : ResponsiveWidget.isMobile(context)
                                ? 1
                                : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                        itemCount: 2,//discussionList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => DiscussionDetails(
                                          discussionList[index])));*/
                            },
                            child: Card(
                              elevation: 5,
                              child: listCard(index),
                            ),
                          );
                        },
                        //  physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1),
                      )),
            getLoader(isLoading)
          ],
        ),
      ),
    );
  }

  Widget listCard(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: getImage("discussionList[index].profilePicture.toString()"),
            title: Text('Text',
               // '${discussionList[index].firstName.toString()} ${discussionList[index].lastName.toString()}',
                style: Style.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("discussionList[index].companyName.toString()",
                    style: Style.subtitle),
              ],
            ),
            /*trailing: Text(
              discussionList[index].loggedTime.toString(),
              style: Style.date,
            ),*/
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(
              'discussionList[index].topic.toString()',
              style: Style.title,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(
                left: 20.0, bottom: 10, right: 20,top: 5),
            child: Text(
                "discussionList[index].description.toString()",
                maxLines: 4,

                style: Style.content,
                overflow: TextOverflow.ellipsis,

            ),
          ),
          cardDivider(),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => DiscussionDetails(
                                discussionList[index])));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/more.png',
                        color: Colors.black,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Comments",
                          style: Style.callHeading)
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
                    launch("tel:${discussionList[index].mobileNumber}");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/more.png',
                        color: Colors.black,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Call", style: Style.callHeading)
                    ],
                  ),
                )
              ],
            ),
          ),
          cardDivider(),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text('10',
             // "${discussionList[index].totalComments} Comment",
              style: Style.date,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 15),
            child: Visibility(
                visible:
                    discussionList[index].totalComments == "0" ? false : true,
                child: latestComment(index)),
          )
        ],
      ),
    );
  }

  Widget latestComment(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            '${discussionList[index].firstNameForComment} ${discussionList[index].lastNameForComment}',
            style: Style.title),
        SizedBox(
          height: 5,
        ),
        CustomText(
          discussionList[index].latestComment!,
          overflow: TextOverflow.ellipsis,
          style: Style.content,
        )
      ],
    );
  }

  void GetDiscussionApi() async {
    isLoading = true;
    setState(() {

    });
    APIHelper api = APIHelper();
    var result = await api.ApiGetData(
        AppConstants.GET_DISCUSSION + "?page=${selectedPageNumber}");
    // print(result);
    DiscussionModel discussion = await DiscussionModel.fromJson(result);
    discussionList.addAll(discussion.content!);

    setState(() {
      isLoading = false;
    });
  }

  Widget cardDivider() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Divider(
        height: 1.5,
        thickness: 1.5,
      ),
    );
  }
}
