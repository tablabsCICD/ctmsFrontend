import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/appbar.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/comment_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization_portal/model/group_list_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/group/groupChatProvider.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';



class ChatPage extends StatefulWidget {
  final GroupContent groupContent;
  const ChatPage(this.groupContent);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  late types.User _user ;
  final groupChatProvider = locator<GroupChatProvider>();
  final userProvider=locator<AuthProvider>();
  TextEditingController _textEditingController=TextEditingController();
  late Timer _timer;
  int _start = 10;

  @override
  void initState() {
    super.initState();
    String userId=userProvider.userDetailList[0].id.toString();
    _user= types.User(id: userId,firstName:userProvider.userDetailList[0].firstName ,lastName: userProvider.userDetailList[0].lastName);
    groupChatProvider.loadMessage(widget.groupContent.id!);
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) => Consumer<GroupChatProvider>(
  builder: (context, provider, child) {
  return Scaffold(
    appBar: AppBarCommon(context, title:widget.groupContent.groupName!).appBarImage(widget.groupContent.imageUrl!,widget.groupContent,context,groupChatProvider),
    backgroundColor: ColorResources.HOME_BG,
    body: Chat(
      messages: groupChatProvider.messages,
      onSendPressed: _handleSendPressed,
      showUserAvatars: true,
      showUserNames: true,
      isAttachmentUploading: false,
      user: _user,


      theme: DefaultChatTheme(backgroundColor:ColorResources.HOME_BG ),
      customBottomWidget: CommentTextField(controller: _textEditingController,hintText: "Message",textInputType: TextInputType.text,isFocused: true,onTap: (){

      },onValueChange: (){
        if(_textEditingController.text.length>0){
          handleSendPressed(_textEditingController.text);
          _textEditingController.clear();
        }
      },),

    ),
  );
  },
);


  Future<void> handleSendPressed(String message) async {
    await groupChatProvider.sendMeassage(userProvider.userDetailList[0], widget.groupContent.id!, message);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "const Uuid().v4()",
      text: message.text,
    );

  }


  void _loadMessages() async {
    // final response = await rootBundle.loadString('assets/messages.json');
    // final messages = (jsonDecode(response) as List)
    //     .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
    //     .toList();
    // setState(() {
    //   _messages = messages;
    // });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
            groupChatProvider.loadMessage(widget.groupContent.id!);
      },
    );
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}