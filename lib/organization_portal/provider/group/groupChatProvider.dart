import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization_portal/model/api_response.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/group_chat_message.dart';
import 'package:flutter_hr_management/organization_portal/network/api_call.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../util/app_constants.dart';

class GroupChatProvider extends ChangeNotifier{
  List<types.Message> messages = [];

  loadMessage(int groupId) async{
    messages.clear();
    APIHelper apiHelper=APIHelper();
    var response=await apiHelper.ApiGetData(AppConstants.GROUP_CHAT_MASSAGE+groupId.toString());
    GroupChatMassage groupChatMassage=GroupChatMassage.fromJson(response);
    List<GroupChatMessageContent>listMessages=groupChatMassage.content!;
   for (int i=listMessages.length-1;i>=0;i--){
     types.User _user= types.User(id:listMessages[i].userId.toString() ,firstName:listMessages[i].displayName );

     final textMessage = types.TextMessage(
       author: _user,
       createdAt: DateTime.now().millisecondsSinceEpoch,
       id: listMessages[i].id.toString(),
       text:listMessages[i].message!,
     );
     messages.add(textMessage);

   }

   notifyListeners();
  }

  sendMeassage(User user,int groupId,String messageSend)async{
    String date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now());
    print('the date is ${date}');
    Map<String,dynamic>parameter={
      "date":date,
      "displayName":user.firstName!+" "+user.lastName! ,
      "groupId": groupId,
      "imageUrl": user.profilePicture,
      "message": messageSend,
      "userId": user.id
    };
    APIHelper apiHelper=APIHelper();
    ApiResponseHelper response=await apiHelper.ApiAddPostDataMapRequestCall(AppConstants.SEND_GROUP_CHAT_MEASSAGE, parameter);
    GroupChatMessageContent chatMessageContent=GroupChatMessageContent.fromJson(response.response);
    if(response.statusCode==200){
      final textMessage = types.TextMessage(
        author: types.User(id:user.id.toString(),firstName: user.firstName!+" "+user.lastName!,imageUrl: user.profilePicture ),
        createdAt: chatMessageContent.date,
        id: chatMessageContent.id.toString(),
        text: messageSend,
      );
      addMessage(textMessage);
    }else{

    }
  }

  void addMessage(types.Message message) {
    messages.insert(0, message);
    notifyListeners();
  }

}