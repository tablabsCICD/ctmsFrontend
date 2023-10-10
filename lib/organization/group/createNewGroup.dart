import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/provider/group/groupListProvider.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/appbar.dart';
import 'package:flutter_hr_management/organization/group/groupDeatilsScreen.dart';




class CreateNewGroup extends StatefulWidget {

 final bool isFromEdit;

  const CreateNewGroup({Key? key, this.isFromEdit=false}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CreateNewGroupState(isFromEdit);
  }

}

class CreateNewGroupState extends State<CreateNewGroup> {
  final bool isEdit;
  final groupListProvider = locator<GroupListProvider>();
  TextEditingController _controller = TextEditingController();
  ScrollController horizantalControllet=ScrollController();

  CreateNewGroupState(this.isEdit);
  @override
  void initState() {
    // TODO: implement initState
    groupListProvider.getAllUserList(isEdit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(context, title: "Add Participants",appBarWord: "Next").appBarWithNewButton((){

        if(groupListProvider.selectedUsers.length==0){
          final snackBar = SnackBar(
            content: const Text('Please Select at least one member to create group'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else{
          if(widget.isFromEdit==true){
            Navigator.pop(context,2);
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>GroupDetailsScreen()));

          }


        }

      }),
      body: Consumer<GroupListProvider>( builder: (context, model, child) =>
        groupListProvider.isLoading==true?Center(child: CircularProgressIndicator(),):
       Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           searchBar(),
           Visibility(visible: groupListProvider.selectedUsers.length==0?false:true,child: Container(
             color:  Colors.black12,
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Container(child: selectedUsers(),height: 90,),
                 ),
               ],
             ),
           ),),
           listViewUser(),
         ],
       ),

      ),
      backgroundColor: ColorResources.HOME_BG,
      bottomNavigationBar: nextButton(),


    );
  }

  listViewUser(){
    return Expanded(
      child: StaggeredGridView.countBuilder(
        //controller: _scrollController,
          physics: ScrollPhysics(),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          shrinkWrap: true,

          crossAxisCount: ResponsiveWidget.isDesktop(context)
              ? 3
              : ResponsiveWidget.isMobile(context)
              ? 1
              : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: groupListProvider.filterByName.length,
          itemBuilder: (context, index) {
            return InkWell(onTap: () {}, child: groupTile(index));
          }),
    );
  }
  groupTile(int index) {
    String displayName=groupListProvider.filterByName[index].firstName!+" "+groupListProvider.filterByName[index].lastName!;
    if(displayName.length >18){
      displayName=displayName.substring(0,18);
      displayName=displayName+"...";
    }
    return Container(

      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
               groupListProvider.filterByName[index].profilePicture!.allMatches("null")==0 ? Image.network(groupListProvider.filterByName[index].profilePicture!,height: 64,width: 64,) : Icon(
                  Icons.account_circle,
                  size: 64.0,
                ),
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
                              displayName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20.0),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                            ),
                            widget.isFromEdit?callEditCheckBox(index):callCreateCheckBox(index),
                          ],
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }


  selectedUsers(){
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: horizantalControllet,
      itemCount: groupListProvider.selectedUsers.length,
      itemBuilder: (BuildContext context, int index) => Container(
        height: 70,
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
    );
  }

  nextButton(){
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: ColorResources.PRIMARY_COLOR,
      child: Center(
        child: InkWell(onTap: (){
          if(groupListProvider.selectedUsers.length==0){
            final snackBar = SnackBar(
              content: const Text('Please Select at least one member to create group'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }else{
            if(widget.isFromEdit==true){
              Navigator.pop(context,2);
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) =>GroupDetailsScreen()));
            }
          }
        }
            ,child: Text("Next",style: Style.button,)),
      ),
    );
  }
  searchBar() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBarCommon(context, title: "Search")
          .appBarWithSearch(_controller, "Search by name", (value) {
        return groupListProvider.filterUser(value);
      },false),
    );
  }

  callEditCheckBox(index) {
    return Visibility(
      visible: groupListProvider.filterByName[index].addedIngroup==true?false:true,
      child: Checkbox(value:  groupListProvider.filterByName[index].isSelected, onChanged: (value){

        groupListProvider.selectedUser(value, groupListProvider.filterByName[index]);

        //horizantalControllet.jumpTo(horizantalControllet.position.maxScrollExtent+200);
        if(value==true){
          horizantalControllet.animateTo(horizantalControllet.position.maxScrollExtent+200,
              duration:Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
        }else{
          horizantalControllet.animateTo(horizantalControllet.position.maxScrollExtent,
              duration:Duration(milliseconds: 400), curve: Curves.slowMiddle);
        }



      }),
    );
  }
  callCreateCheckBox(int index) {
    return Checkbox(value:  groupListProvider.filterByName[index].isSelected, onChanged: (value){

      groupListProvider.selectedUser(value, groupListProvider.filterByName[index]);

      //horizantalControllet.jumpTo(horizantalControllet.position.maxScrollExtent+200);
      if(value==true){
        horizantalControllet.animateTo(horizantalControllet.position.maxScrollExtent+200,
            duration:Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
      }else{
        horizantalControllet.animateTo(horizantalControllet.position.maxScrollExtent,
            duration:Duration(milliseconds: 400), curve: Curves.slowMiddle);
      }



    });
  }
}