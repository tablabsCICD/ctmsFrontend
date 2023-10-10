import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/group/groupListProvider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';


class GroupDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GroupDetailsState();
  }
  
}
class GroupDetailsState extends State<GroupDetailsScreen>{

  final groupListProvider = locator<GroupListProvider>();
  final userProvider = locator<AuthProvider>();
  TextEditingController _controller = TextEditingController();
  ScrollController horizantalControllet=ScrollController();
  @override
  Widget build(BuildContext context) {
   return Consumer<GroupListProvider>(
  builder: (context, provider, child) {

  return Scaffold(
     backgroundColor: ColorResources.HOME_BG,
    // appBar: AppBarCommon(context, title: "Create Group").appBar(),
     body: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         topBar(),
         SizedBox(height: 50,),
         groupName(),
         SizedBox(height: 30,),
         particepent(),
         SizedBox(height: 20,),
         Padding(padding: EdgeInsets.only(left: 10,right: 10),child: selectUserList(),),
       ],
     ),

    bottomNavigationBar: nextButton(),
   );
  },
);
  }

  topBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 25,left: 15,right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: (){
            Navigator.pop(context);
          },child: Text("Back",style: Style.headingBack,)),
         Text("New Group",style:Style.heading),
          InkWell(onTap: (){
            if(_controller.text.length==0){
              final snackBar = SnackBar(
                content: const Text('Please Enter Group Name'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }else{
              groupListProvider.callCreateGroupApi(userProvider.userDetailList[0].id,_controller.text,context);
            }
          },child: Text("Create",style: Style.creategroup,))
        ],
      ),
    );
  }

  groupName() {
    String img=groupListProvider.imageUrl.replaceAll('"', '');
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ClipOval(
            child: Material(
              color: Colors.grey, // Button color
              child: InkWell(
                splashColor: Colors.grey, // Splash color
                onTap: () async{
                  var doc = await groupListProvider.pickFile().then((value){
                    print(value);
                  });
                },
                child: SizedBox(width: 67, height: 67, child:  Image.network(img)),
              ),
            ),
          ),
        ),
        Container(height: 100,width: 320,child: CustomTextField(controller: _controller, hintText: "Enter Group Name", textInputType: TextInputType.text))
      ],
    );
  }

  particepent() {
    return Container(
      height: 40,
      color: Colors.black12,
      child: Center(child: Text("PARTICIPANTS: ${groupListProvider.selectedUsers.length} OF 1000",style: Style.buttonType2,)),
    );
  }

  selectedUsers(){
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        controller: horizantalControllet,
        itemCount: groupListProvider.selectedUsers.length,
        itemBuilder: (BuildContext context, int index) => Container(
          height: 80,
          width: 100,
          child: Column(

            children: <Widget>[
              groupListProvider.selectedUsers[index].profilePicture!.allMatches("null")==0 ? Image.network(groupListProvider.selectedUsers[index].profilePicture!,height: 64,width: 64,) : Icon(
                Icons.account_circle,
                size: 64.0,
              ),
              Text(
                groupListProvider.selectedUsers[index].firstName!,
                style: Style.subtitle,)

            ],
          ),
        ),
      ),
    );
  }

  selectUserList(){
    return StaggeredGridView.countBuilder(
       // controller: _scrollController,
        physics: ScrollPhysics(),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        shrinkWrap: true,

        crossAxisCount: ResponsiveWidget.isDesktop(context)
            ? 5
            : ResponsiveWidget.isMobile(context)
            ? 5
            : 5,
        //crossAxisSpacing: 10,
        //  mainAxisSpacing: 12,
        itemCount: groupListProvider.selectedUsers.length,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {}, child: Column(

            children: <Widget>[
              groupListProvider.selectedUsers[index].profilePicture!.allMatches("null")==0 ? Image.network(groupListProvider.selectedUsers[index].profilePicture!,height: 64,width: 64,) : Icon(
                Icons.account_circle,
                size: 64.0,
              ),
              Text(
                groupListProvider.selectedUsers[index].firstName!,
                style: Style.subtitle,)

            ],
          ));
        });
  }

  nextButton(){
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: ColorResources.PRIMARY_COLOR,
      child: Center(
        child: InkWell(onTap: (){
          if(_controller.text.length==0){
            final snackBar = SnackBar(
              content: const Text('Please Enter Group Name'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else{
            groupListProvider.callCreateGroupApi(userProvider.userDetailList[0].id,_controller.text,context);
          }
        }
            ,child: Text("Create Group",style: Style.button,)),
      ),
    );
  }
}