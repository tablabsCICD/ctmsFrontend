import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textfeild.dart';
import 'package:flutter_hr_management/organization_portal/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization_portal/dialog/my_dialog.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/network/api_call.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class NewDiscussion extends StatefulWidget {

  // const NewDiscussion({Key? key}) : super(key: key);

  @override
  _NewDiscussionState createState() => _NewDiscussionState();
}

class _NewDiscussionState extends State<NewDiscussion> {
  final authProvider = locator<AuthProvider>();
  final _formKey = GlobalKey<FormState>();
  final _toKey = GlobalKey<FormState>();

  TextEditingController additionalinfo = TextEditingController();
  TextEditingController topic = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _toKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("New Discussion",style: Style.appheading,),
        shadowColor: Colors.white,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),onPressed:(){
          Navigator.pop(context,1);
        } ,),
      ),

      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
              // margin: ResponsiveWidget.isDesktop(context)? EdgeInsets.symmetric(horizontal: 50,vertical: 10):EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              child: SingleChildScrollView(
                child: Column(
                  children:[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        child: Text('Requirement you post will be visible on the general board to vendors whose routes match to yours.',style: Style.appsubtitle,)),

                    CustomTextField(
                      hintText: 'Topic Name',
                      textInputType: TextInputType.text,
                      controller: topic,
                    ),
                    Visibility(
                      visible: false,
                      child: CustomTextField(
                        hintText: 'Additional Information',
                        textInputType: TextInputType.multiline,
                        maxLine: 7,
                        controller: additionalinfo,
                      ),
                    ),
                    CustomButton(
                        onTap: () async{
                            sendPost();
                          },
                        buttonText: "Post Discussion")
                  ],
                ),


              ),
            ),

        ),
      ),
    );

  }

  savePost({int? mobile,String? additionalinfo,String? email,int? id,User? userList,String? name,int? userId}) async {

  /*  APIHelper api=APIHelper();
    var result= await api.ApiPOSTData(AppConstants.GET_DISCUSSION);*/
    String myUrl = AppConstants.GET_DISCUSSION;
    print(myUrl);
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "contactNumber": mobile?? 0,
      //"date": "2022-07-04T08:55:23.783Z",
      "emailId": email,
      //"loggedTime": "2022-07-04T08:55:23.783Z",
      "loggedUserName": name,
      "description": "",
      "topicName": topic,
    };
    var body = json.encode(data);
    print("request : ${data}");
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("response : ${response.statusCode}" + " --- " + response.body.toString());
    var jsonData = jsonDecode(response.body);

  }

  void sendPost() async{

    if (_formKey.currentState!.validate()) {

      print('call API');
      Map<String,dynamic>parameter= {
        "contactNumber": authProvider.userDetailList[0].mobileNumber,
        "emailId": authProvider.userDetailList[0].emailId,
        "firstName":authProvider.userDetailList[0].firstName,
        "loggedUserName": authProvider.userDetailList[0].userName,
        'lastName':authProvider.userDetailList[0].lastName,
        'profilePicture':authProvider.userDetailList[0].profilePicture,
        "description":additionalinfo.text.toString() ,
        "topic": topic.text.toString(),
        'companyName':authProvider.userDetailList[0].companyName
      };;
      print('the parameter${parameter}');

      APIHelper apiHelper=APIHelper();
      var result=await apiHelper.ApiAddPostDataMapRequest(AppConstants.GET_DISCUSSION, parameter);
      if(result == 200){
        topic.clear();
        additionalinfo.clear();
        setState(() {

        });
        //SnackBar snackBar=SnackBar(content: Text("Discussion post Successfully"),duration: Duration(seconds: 2),);
        //await ScaffoldMessenger.of(context).showSnackBar(snackBar);
        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.check,
              title:
              'New Discussion',
              description:
              'Your discussion submitted successfully',
              isFailed: false,
              isFromPost: true,

            ),
            dismissible: true,
            isFlip: false);

      }else{
        SnackBar snackBar=SnackBar(content: Text("Discussion post failed"),duration: Duration(seconds: 2),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  }


