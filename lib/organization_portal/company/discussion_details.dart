import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/appbar.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/comment_text_field.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/model/comments_model.dart';
import 'package:flutter_hr_management/organization_portal/model/discussion_model.dart';
import 'package:flutter_hr_management/organization_portal/network/api_call.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
class DiscussionDetails extends StatefulWidget {
  DiscussionContent _discussionContent;
  List<DiscussionContent> discussionList = [];

  DiscussionDetails(this._discussionContent, {Key? key}) : super(key: key) {
    getDiscussion(_discussionContent.id!);
  }

  @override
  State<DiscussionDetails> createState() => _DiscussionDetailsState();

  void getDiscussion(int i) async {
    APIHelper api = APIHelper();
    var result = await api.ApiGetData(AppConstants.GET_DISCUSSION + "/${i}");
    DiscussionModel discussion = DiscussionModel.fromJson(result);
    discussionList.addAll(discussion.content!);
    // isLoading=false;

  }

}


class _DiscussionDetailsState extends State<DiscussionDetails> {
  List<CommentsContent> commentsList = [];
  TextEditingController commentHere = TextEditingController();
  ScrollController _scrollController = ScrollController();
  var selectedPageNumber = 0;
  bool isFocused=false;

  final authProvider = locator<AuthProvider>();
  @override
  void initState() {
    getComments(widget._discussionContent.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(context, title: "Discussions").appBar(),
      body: Container(
        color: ColorResources.HOME_BG,
      //  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Container(
              color: ColorResources.WHITE,
              child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: discussionCard(),
              ),
            ),
            Container(
              color: ColorResources.WHITE,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 20, 0),
                child: getComment(),
              ),
            ),
            Container(
              color: ColorResources.WHITE,
                child: callButton()),
            commentBox(),
            commentList()
          ],
        ),
      ),
      bottomNavigationBar: reportThisCard(),
    );
  }

  Widget reportThisCard(){
    return Container(
      height:59 ,

      decoration: BoxDecoration(
        border:Border() ,
        color: ColorResources.BOTTOM_BAR,


      ),
      child: Center(
        child:  RichText(text:
        TextSpan(
            text: 'Report this post',style: Style.newheadingappbar,
            recognizer: TapGestureRecognizer()
              ..onTap = () {

              }
        ),
        ),
      ),
    );
  }


  Widget discussionCard() {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: 5),
              horizontalTitleGap: 5,
              minVerticalPadding: 0,
              leading: getImage(
                  widget._discussionContent.profilePicture.toString(), height: 35,
                  width: 35),
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0,0),
                child: CustomText('${widget._discussionContent.firstName.toString().toUpperCase()} ${widget._discussionContent.lastName.toString().toUpperCase()}',
                    style: Style.title),
              ),
              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomText(widget._discussionContent.companyName.toString().toUpperCase(),
                      style: Style.subtitle),
                ],
              ),
              trailing: Text(widget._discussionContent.loggedTime.toString(),textAlign: TextAlign.center,style: Style.date,),
            ),

          ),
          /*  ),*/ //card end

        ],
      ),


    );
  }

  Widget getComment() {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: 0),
                child: Wrap(
                  children: [
                    Text(widget._discussionContent.topic.toString(),
                      style: Style.title, overflow: TextOverflow.ellipsis,

                      softWrap: true,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,
                    left: 0.0, bottom: 15, right: 0),
                child: CustomText(
                  widget._discussionContent.description.toString(),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Style.content,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
            child: Divider(

              height: 1.5,
              thickness: 1.5,

            ),
          ),
        ],
      ),
    );

  }
  Widget callButton(){
    return Container(
      height: 44,
      child: Center(
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset("assets/images/call.svg"),SizedBox(width:5),Text("Call")],
          ),
        ),
      ),
    );
  }

  Widget commentBox(){
    return  Container(

      color: ColorResources.HOME_BG,
      child: Stack(
        children: [
          CommentTextField(

            hintText: 'Enter your comment here',
            textInputType: TextInputType.text,
            controller: commentHere,
            isFocused: isFocused,
            onTap: (){
              isFocused=true;
              setState(() {

              });
              //sendComment();
            },
            onValueChange: (){
              if(isFocused){
                sendComment();
              }

            },
          ),

        ],
      ),

    );
  }

  Widget commentList(){
    return Expanded(
        child: ListView.builder(
          controller: _scrollController,
          physics: ScrollPhysics(),

          itemCount: commentsList.length,
          itemBuilder: (context, index) {
            return Container(

              decoration: BoxDecoration(
                  color: ColorResources.HOME_BG,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: CustomText(
                        '${commentsList[index].firstName
                            .toString()} ${commentsList[index]
                            .lastName.toString()}',
                        style: Style.title),
                    trailing: Text(
                        commentsList[index].date.toString()),
                     subtitle:  CustomText(
                       commentsList[index].comment
                           .toString(),
                       overflow: TextOverflow.ellipsis,
                       style: Style.content,
                     ),
                  ),

                 // SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Divider(
                      height: 1.5,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
            );
          },
          shrinkWrap: true,
        )

    );
  }

  void getComments(int i) async {
    APIHelper api = APIHelper();
    var result = await api.ApiGetData(
        AppConstants.GET_COMMENTS + "/discussionId/${i}");
    print(result);

    CommentModel comments = CommentModel.fromJson(result);
    commentsList.addAll(comments.content!);
    setState(() {

    });
    // isLoading=false;
  }

  void sendComment()async{
    APIHelper apiHelper=APIHelper();
    Map<String,dynamic>parameter={
      'comment':commentHere.text.toString(),
      'discussionId':widget._discussionContent.id,
      'firstName':authProvider.userDetailList[0].firstName,
      "lastName": authProvider.userDetailList[0].lastName,
      "userId":authProvider.userDetailList[0].id

    };
    if(isFocused==false){
      return;
    }
   if(commentHere.text.isEmpty==true){

   }else{
     int result = await apiHelper.ApiAddPostDataMapRequest(AppConstants.GET_COMMENTS,parameter);
      if(result==200){
        CommentsContent commentsContent =CommentsContent();
        commentsContent.firstName=authProvider.userDetailList[0].firstName;
        commentsContent.lastName=authProvider.userDetailList[0].lastName;
        commentsContent.comment=commentHere.text;
        var now = new DateTime.now();
        var formatter = new DateFormat('dd-MM-yyyy');
        String formattedDate = formatter.format(now);
        commentsContent.date=formattedDate;
        commentsContent.id=201;
        commentsList.add(commentsContent);
        commentHere.clear();
        FocusScope.of(context).unfocus();
        setState(() {
          isFocused=false;
        });
      }else{

      }
   }

  }
}
