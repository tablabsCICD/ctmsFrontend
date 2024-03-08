import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/appbar.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization_portal/group/createNewGroup.dart';
import 'package:flutter_hr_management/organization_portal/group/groupChatScreen.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/group_list_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/group/groupListProvider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';

import 'editGroupScreen.dart';

class GroupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroupListState();
  }
}

class GroupListState extends State<GroupList> {
  ScrollController _scrollController = ScrollController();
  final groupListProvider = locator<GroupListProvider>();
  final userProvider = locator<AuthProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    callgetApi(context);
    return Consumer<GroupListProvider>(
      builder: (context, provider, child) {
        return Scaffold(

          appBar: AppBarCommon(context, title: "Group").appBarWithNewButton(() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateNewGroup()));
          }),
          body: Column(
            children: [
              getLoader(groupListProvider.isLoading),
              Expanded(
                child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    physics: ScrollPhysics(),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    shrinkWrap: true,

                    crossAxisCount: ResponsiveWidget.isDesktop(context)
                        ? 3
                        : ResponsiveWidget.isMobile(context)
                        ? 1
                        : 2,
                    //crossAxisSpacing: 10,
                    //  mainAxisSpacing: 12,
                    itemCount: groupListProvider.listGroup.length,
                    itemBuilder: (context, index) {
                      return InkWell(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatPage(groupListProvider.listGroup[index]!,)));

                      }, child: groupTile(groupListProvider.listGroup[index ]));
                    }),
              ),

            ],
          ),
          backgroundColor: ColorResources.HOME_BG,
        );
      },
    );
  }

  groupTile(GroupContent? objectGroup) {

    String img=objectGroup!.imageUrl!.replaceAll('"', '');
    print('the image is ${img}');
    return Container(
      color: ColorResources.HOME_BG,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 10),
            child: Row(
              children: <Widget>[
                // Icon(
                //   Icons.account_circle,
                //   size: 64.0,
                // ),
               // getImage(img,height: 50,width: 50),
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:
                  NetworkImage(img),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              objectGroup!.groupName!,
                              style: Style.heading,
                            ),

                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 2.0),
                        //   child: CustomText(
                        //     '',
                        //     style: Style.date,
                        //   ),
                        //)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void callgetApi(context)async {
    groupListProvider.getAllGroup(userProvider.userDetailList[0].id,context);
  }
}
