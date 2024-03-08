import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/model/group_list_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/group/groupChatProvider.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/search_widget.dart';

import '../localization/language_constrants.dart';
import '../group/editGroupScreen.dart';

class AppBarCommon {
  final String title;
  final BuildContext context;
   final String appBarWord;

  const AppBarCommon(this.context,{this.appBarWord="New",required this.title});

  AppBar appBar(){
    return AppBar(
      title: Text(title,style:Style.appheading,),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,),onPressed:(){
    Navigator.pop(context);
    } ,
    ),);
  }
  AppBar appBarWithTextField(TextEditingController _controller,String hintText,Function onChangeVal(value),bool backShow){
    //TextEditingController _controller = TextEditingController();
    return AppBar(
      leadingWidth: 25,
      title: Container(
            alignment: Alignment.center,

            width: MediaQuery.of(context).size.width ,
            child: TextField(
              controller: _controller,
             decoration: InputDecoration(
               filled: true,
               fillColor: Colors.black12,
               contentPadding: EdgeInsets.all(1),
               hintText:hintText,
               prefixIcon:Icon(Icons.search),
               //border: InputBorder.none,
              border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
              ),
              borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,

              ),)
             ),
              style: Style.searchHint,
              onChanged: (value){
                onChangeVal(value);
              },
            ),
          ),
      backgroundColor: Colors.white,
      leading: Visibility(
        visible: backShow,
        child: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,),
          onPressed:(){
          Navigator.pop(context);
        } ,
        ),
      ),

    );
  }

  AppBar appBarWithNewButton(Function ontap){
    return AppBar(
      title: Text(title,style:Style.appheading,),
      backgroundColor: Colors.white,
      leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,),onPressed:(){
        Navigator.pop(context);
      } ,
      ),
      actions: [
      Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: RichText(text:
          TextSpan(
              text: appBarWord,style: Style.newheadingappbar,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                 ontap();
                }
                ),
          ),
        ),
      )
      ],

    );
  }


  Widget appBarWithSearch(TextEditingController _controller,String hintText,Function onChangeVal(value),bool backShow){
    //TextEditingController _controller = TextEditingController();
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          contentPadding: EdgeInsets.all(1),
          hintText:hintText,
          prefixIcon:Icon(Icons.search),
          //border: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,

            ),)
      ),
      style: Style.searchHint,
      onChanged: (value){
        onChangeVal(value);
      },
    );

  }

  AppBar appBarImage(String img,GroupContent content,BuildContext context,GroupChatProvider groupChatProvider){
    img=img.replaceAll('"', '');
    return AppBar(
      title: InkWell(
        onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditGroupScreen(groupContent: content)));
        } ,
        child: Row(
          children: [Padding(padding: EdgeInsets.only(top: 5),child:  CircleAvatar(
            radius: 25.0,
            backgroundImage:
            NetworkImage(img),
            backgroundColor: Colors.transparent,
          ),),SizedBox(width: 20,),Text(title,style:Style.appheading,)],
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(icon:Icon(Icons.refresh,color: Colors.black,),onPressed:(){
          groupChatProvider.loadMessage(content.id!);
          return;
        } ,
        )
      ],
      elevation: 0,
      leading: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,),onPressed:(){
        Navigator.pop(context);
      } ,
      ),);
  }



}
