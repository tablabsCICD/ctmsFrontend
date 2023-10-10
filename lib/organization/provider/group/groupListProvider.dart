import 'dart:convert';

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hr_management/organization/base_widget/loader.dart';
import 'package:flutter_hr_management/organization/model/api_response.dart';
import 'package:flutter_hr_management/organization/model/create_group.dart';
import 'package:flutter_hr_management/organization/model/group_list_model.dart';
import 'package:flutter_hr_management/organization/network/api_call.dart';
import 'package:http/http.dart' as http;
import '../../model/auth_api.dart';
import '../../model/group_added_member.dart';
import '../../model/group_member.dart';
import '../../util/app_constants.dart';


class GroupListProvider extends ChangeNotifier{
  bool isLoading=false;
  bool isFirstLoading=false;
  List<User> allUserList = [];
  List<User>filterByName=[];
  List<User>selectedUsers=[];
  List<GroupMemberContent>listAddedMember=[];
  bool createGroup=false;
  String imageUrl='https://cdn.pixabay.com/photo/2016/03/23/22/26/user-1275780_1280.png';
  List<GroupContent?>listGroup=[];
  String changeImageUrl='';

  getAllUserList(bool isFromEdit) async {

    selectedUsers=[];
    isLoading = true;
    notifyListeners();
    if(allUserList.length==0){
      String myUrl = AppConstants.BASE_URL +'companyRegistration?page=${0}&size=6000';
      var responseBody=await APIHelper().ApiGetData(myUrl);
      isFirstLoading= false;
      var type = AuthApi.fromJson(responseBody);
      allUserList.addAll(type.content!);
    }
    isLoading = false;
    //filterByName.addAll(allUserList);
    if(isFromEdit==true){
      for(int i=0;i<allUserList.length;i++){
        allUserList[i].addedIngroup=false;
        for(int j=0;j<listAddedMember.length;j++){
            if(allUserList[i].id==listAddedMember[j].userId){
              allUserList[i].addedIngroup=true;
            }
          }

        if(allUserList[i].id != AppConstants.USER_OBJECT.id){
          filterByName.add(allUserList[i]);
        }

      }
    }else{
      for(int i=0;i<allUserList.length;i++){
        allUserList[i].isSelected=false;
        if(allUserList[i].id != AppConstants.USER_OBJECT.id){

             filterByName.add(allUserList[i]);
        }
      }
    }

    notifyListeners();
  }
  changeImage(String imageUrl){
    changeImageUrl=imageUrl;
    notifyListeners();
  }

  filterUser(String name){
    filterByName.clear();
    if(name.length > 2){
      filterByName.clear();
      notifyListeners();
      for(int i=0;i<allUserList.length;i++){
        if(allUserList[i].firstName!.toLowerCase().contains(name.toLowerCase())==true||allUserList[i].lastName!.toLowerCase().contains(name.toLowerCase())==true){
            filterByName.add(allUserList[i]);
        }
      }
    }else{
      filterByName.addAll(allUserList);
    }
  notifyListeners();
  }

  selectedUser(bool? value,User userObj){
    userObj.isSelected=value;

    if(value==true){
      selectedUsers.add(userObj);
    }else{
      selectedUsers.remove(userObj);
    }
    notifyListeners();
  }

  callCreateGroupApi(int? userId,String groupName,BuildContext context)async{
    isLoading=true;
    showLoader(context);
    APIHelper apiHelper=APIHelper();
    String date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now());
    Map<String,dynamic>parameter={
      'createByUserId':userId,
      'groupName':groupName,
      'isPrivate':0,
      'imageUrl':imageUrl,
      'date':date

    };
    ApiResponseHelper response=await apiHelper.ApiAddPostDataMapRequestCall(AppConstants.GROUP,parameter);
    if(response.statusCode==200){
      GroupCreateModel model=GroupCreateModel.fromJson(response.response);
      callGroupMember(model.id,userId,context,false);
    }else{
      isLoading=false;
      showLoader(context);
      notifyListeners();
    }
  }

  void callGroupMember(int? groupId,int? userId,BuildContext context,bool isFrom) async{
    String date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now());
    List<GroupMember>selectedUserId=[];
    for(int i=0;i<selectedUsers.length;i++){
      String? dpName= selectedUsers[i].firstName!+" "+selectedUsers[i].lastName!;
      selectedUserId.add(GroupMember(displayName:dpName,userId: selectedUsers[i].id));
    }
    APIHelper apiHelper=APIHelper();
    Map<String,dynamic>parameter={
      'addedByUserId':userId,
      'groupId':groupId,
      'date':date,
      'listOfUsers':selectedUserId,

    };
    var response=await apiHelper.ApiAddPostDataMapRequest(AppConstants.GROUP_MEMBER_BULK,parameter);
    if(response==200){
      isLoading=false;
      createGroup=true;

      if(isFrom==true){
        getGroupMember(groupId!);
      }else{
        await getAllGroup(userId, context);
        showLoader(context);
        goToNextPage(context);
      }

      //notifyListeners();
    }else{
      isLoading=false;
      showLoader(context);
      notifyListeners();

    }

  }

  pickFile() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true,
      allowMultiple: false,
      //allowedExtensions: ['png','jpg']// this will return PlatformFile object with read stream
    );
    if(result!=null){
 try {
       String fileName = result.files.first.name;
        print(result.files.first.toString());
      var objFile = result.files.single;
       var imageBytes = result.files.first.bytes;
        print(fileName);
        var docs =  await uploadGroupPhoto(imageFilePath: fileName,imageBytes: imageBytes,objectFile: objFile);
        print(docs);

      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }

  }


  uploadGroupPhoto({String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {
    String myUrl = AppConstants.IMG_UPLOAD;
    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);
    Map<String,String> headers = {"Content-Type": "multipart/form-data"};
    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      imageUrl = value;
      //changeImageUrl=value;
    });

   notifyListeners();
  }

  showLoader(context){
    if(isLoading){
      Loader().showLoaderDialog(context);
    }else{
      Loader().dismissLoader(context);
    }
  }
  goToNextPage(BuildContext context){
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });


  }
  
  getAllGroup(int? userId,context)async{
    print('the id is +${AppConstants.USER_OBJECT.id}');
    listGroup.clear();
    isLoading=true;
    //showLoader(context);
    APIHelper apiHelper=APIHelper();
    var response=await apiHelper.ApiGetData(AppConstants.GROUP_BY_USER+userId!.toString());
    GroupListModel groupListModel=GroupListModel.fromJson(response);
    listGroup.addAll(groupListModel.content!);
    isLoading=false;
    //showLoader(context);
    notifyListeners();

  }
  getGroupMember(int groupId)async{
    listAddedMember.clear();
    isLoading=true;
    //showLoader(context);
    APIHelper apiHelper=APIHelper();
    var response=await apiHelper.ApiGetData(AppConstants.GROUP_MEMBER_LIST+groupId!.toString());
    GroupMemberModel groupListModel=GroupMemberModel.fromJson(response);

    listAddedMember.addAll(groupListModel.content!);
    isLoading=false;
    //showLoader(context);
    notifyListeners();

  }
  removeMemberFromGroup(int memberId,int index)async{
    APIHelper apiHelper=APIHelper();
    int statusCode=await apiHelper.ApiDeleteData(AppConstants.GROUP_MEMBER_DELETE+memberId.toString());;
    if(statusCode==200){
      listAddedMember.removeAt(index);
      notifyListeners();
    }
  }

}