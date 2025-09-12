import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/more_provider.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'package:http/http.dart' as http;

import 'package:universal_html/html.dart' as html;

import '../../../locator.dart';
import '../../../pages/widget/card/base_widgets.dart';
import '../../../pages/widget/card/dashboard_cards.dart';
import '../../../utils/colors.dart';
import '../../base_widget/custom_textview.dart';
import '../../base_widget/getLoader.dart';
import '../../dialog/animated_custom_dialog.dart';
import '../../dialog/my_dialog.dart';
import '../../localization/language_constrants.dart';
import '../../model/my_job_list.dart';
import '../../model/truck_load_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/bid_provider.dart';
import '../../provider/buy_sell_provider.dart';
import '../../provider/dashboard_provider.dart';
import '../../provider/delete_interface.dart';
import '../../provider/general_post_provider.dart';
import '../../provider/localization_provider.dart';
import '../../util/ResponsiveWidget.dart';
import '../../util/color-resource.dart';
import '../../util/style.dart';
import '../../util/utils.dart';
import 'own_genral_post.dart';


class MoreScreen extends StatefulWidget {
  final MoreProvider moreProvider = locator<MoreProvider>();
  final AuthProvider authProvider = locator<AuthProvider>();
  final GeneralPostProvider generalPostProvider = locator<GeneralPostProvider>();
  final ConnectUser user;

  MoreScreen(this.user, {Key? key}) : super(key: key) {
    moreProvider.getOwnPostList(user.id.toString());
    moreProvider.getGalleryList(user.id.toString());
  }

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String selectedTab = 'Full Load';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: ThemeColor.baground,
        appBar: AppBar(
          backgroundColor: ColorResources.RED,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('More Posts', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Consumer<MoreProvider>(
          builder: (context, model, child) {
            if (model.isMoreLoading) {
              return getLoader(true);
            }
            return Column(
              children: [
                Container(
                  height: 62,
                  width: screenSize.width,
                  padding: ResponsiveWidget.isDesktop(context)
                      ? EdgeInsets.symmetric(horizontal: 35, vertical: 15)
                      : EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      getCircularContainer("Full Load", selectedTab == "Full Load"),
                      getCircularContainer("Part Load", selectedTab == "Part Load"),
                      if (widget.user.transporterOrAgent != 2 &&
                          widget.user.transporterOrAgent != 3)
                        getCircularContainer("Buy/Sell Vehicles", selectedTab == "Buy/Sell Vehicles"),
                      getCircularContainer("General Post", selectedTab == "General Post"),
                      getCircularContainer("Jobs", selectedTab == "Jobs"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: ColorResources.HOME_BG,
                    child: _buildSelectedTabContent(selectedTab, model, screenSize),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent(String tab, MoreProvider model, Size screenSize) {
    switch (tab) {
      case "Full Load":
        if (model.myFullLoadTypeList.isEmpty) {
          return Center(child: Text("No Post", style: Style.heading));
        }
        return ResponsiveWidget(
          desktop: MyRequirementCard(model.myFullLoadTypeList),
          mobile: MyRequirementCard(model.myFullLoadTypeList),
          tablet: MyRequirementCard(model.myFullLoadTypeList),
        );

      case "Part Load":
        if (model.myPartLoadTypeList.isEmpty) {
          return Center(child: Text("No Post", style: Style.heading));
        }
        return ResponsiveWidget(
          desktop: MyRequirementCard(model.myPartLoadTypeList),
          mobile: MyRequirementCard(model.myPartLoadTypeList),
          tablet: MyRequirementCard(model.myPartLoadTypeList),
        );

      case "Buy/Sell Vehicles":
        if (model.myBuyVehicleList.isEmpty) {
          return Center(child: Text("No Post", style: Style.heading));
        }
        return ResponsiveWidget(
          desktop: MyBuySellCard(model.myBuyVehicleList),
          mobile: MyBuySellCard(model.myBuyVehicleList),
          tablet: MyBuySellCard(model.myBuyVehicleList),
        );

      case "General Post":
        if (model.myBuyVehicleList.isEmpty) {
          return Center(child: Text("No Post", style: Style.heading));
        }
        return ResponsiveWidget(
          desktop: MyGeneralPostCard(),
          mobile: MyGeneralPostCard(),
          tablet: MyGeneralPostCard(),
        );

      case "Jobs":
      default:
        if (model.myJobList.isEmpty) {
          return Center(child: CustomText("No Post", style: Style.heading));
        }
        return ResponsiveWidget(
          desktop: MyJobCard(model.myJobList),
          mobile: MyJobCard(model.myJobList),
          tablet: MyJobCard(model.myJobList),
        );
    }
  }

  Widget getCircularContainer(String title, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isSelected ? 4 : 1,
        child: Container(
          height: 36,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
          decoration: BoxDecoration(
            color: isSelected ? ColorResources.RED : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? null
                : Border.all(color: Color(0xffd1ccc4)),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: ColorResources.RED.withOpacity(0.3),
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ]
                : [],
          ),
          child: CustomText(
            title,
            style: isSelected
                ? Style.filterHeading.copyWith(color: Colors.white)
                : Style.filterHeading.copyWith(color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}



class MyBuySellCard extends StatefulWidget {
  List<TruckLoad> buySellList;

  MyBuySellCard(this.buySellList);

  @override
  _MyBuySellCardState createState() => _MyBuySellCardState();
}

class _MyBuySellCardState extends State<MyBuySellCard>
    implements DeletePostInf {
  final buySellProvider = locator<BuySellProvider>();
  final authProvider = locator<AuthProvider>();
  final langProvider = locator<LocalizationProvider>();
  String? langCode;
  ScrollController _scrollController = ScrollController();
  var selectedPageNumber = 1;

  @override
  void initState() {
    super.initState();
    langCode = langProvider.selectedlangCode;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        moreProvider.getOwnPostList(authProvider.userDetailList[0].id.toString(),currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoreProvider>(
      builder: (context, model, child) => Container(
        margin: ResponsiveWidget.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            widget.buySellList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                  )
                : Expanded(
                    child: StaggeredGridView.countBuilder(
                    crossAxisCount: ResponsiveWidget.isDesktop(context)
                        ? 3
                        : ResponsiveWidget.isMobile(context)
                            ? 1
                            : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: widget.buySellList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                           /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => BuySellDetailsScreen(
                                        widget.buySellList[index])));*/
                          },
                          child: AllCards().cardSellBuyPost(
                              index, context, widget.buySellList[index], this,
                              userId: authProvider.userDetailList[0].id!));
                    },
                    //  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  )),
          ],
        ),
      ),
    );
  }

  final moreProvider = locator<MoreProvider>();

  @override
  void deleteOwnPost(
    int postId,
    int index,
  ) {
    _showMyDialog(index, postId, moreProvider);
  }

  Future<void> _showMyDialog(int index, int id, MoreProvider provider) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: CustomText(
                'Are you sure want to deleted your post?',
                style: Style.heading,
              ),
              actions: <Widget>[
                TextButton(
                  child: CustomText(getTranslated('yes', context)!,
                      style: Style.okButton),
                  onPressed: () {
                    provider.deleteBuySell(id, index).then((value) => {
                          showAnimatedDialog(
                              context,
                              MyDialog(
                                icon: Icons.check,
                                title: 'Post Delete',
                                description: 'Your post deleted successfully',
                                isFailed: false, isFromPost: true,
                              ),
                              dismissible: false,
                              isFlip: false)
                        });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: CustomText('no', style: Style.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // TODO: implement rePost
  }
}

class MyRequirementCard extends StatefulWidget {
  List<TruckLoad> loadTypeList;

  MyRequirementCard(this.loadTypeList);

  @override
  _MyRequirementCardState createState() => _MyRequirementCardState();
}

class _MyRequirementCardState extends State<MyRequirementCard>
    implements DeletePostInf {
  final bidProvider = locator<BidProvider>();
  final authProvider = locator<AuthProvider>();
  final dashboardProvider = locator<DashboardProvider>();
  final moreProvider = locator<MoreProvider>();
  TextEditingController bidAmtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController filterController = TextEditingController();


  final langProvider = locator<LocalizationProvider>();
  String? langCode;
  ScrollController _scrollController = ScrollController();
  var selectedPageNumber = 1;


  @override
  void initState() {
    super.initState();
    langCode = langProvider.selectedlangCode;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        moreProvider.getOwnPostList(authProvider.userDetailList[0].id.toString(),currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<MoreProvider>(
      builder: (context, model, child) => Container(
        margin: ResponsiveWidget.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            widget.loadTypeList.isEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            )
                : Expanded(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: ResponsiveWidget.isDesktop(context)
                      ? 3
                      : ResponsiveWidget.isMobile(context)
                      ? 1
                      : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: widget.loadTypeList[0].partLoadOrNot==0?model.myFullLoadTypeList.length:model.myPartLoadTypeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          print("Card on tap call repeat post");

                        },
                        child: AllCards().cardLoadHome(
                            index,
                            context,
                            widget.loadTypeList[0].partLoadOrNot==0?model.myFullLoadTypeList[index]:model.myPartLoadTypeList[index],
                            authProvider.userDetailList[0].id!,
                            this,
                            dashboardProvider,
                            true));
                  },
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                )),
            widget.loadTypeList.isEmpty? SizedBox.shrink():getLoader(model.isMoreLoading)
          ],
        ),
      ),
    );
  }

  Set<int>? selectedValues = [
    1,
  ].toSet();

  @override
  void deleteOwnPost(
      int postId,
      int index,
      ) {
    _showMyDialog(index, postId, moreProvider);
  }

  Future<void> _showMyDialog(int index, int id, MoreProvider provider) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: CustomText(
            'Are you sure want to deleted your post?',
            style: Style.title,
          ),
          actions: <Widget>[
            TextButton(
              child: CustomText(getTranslated('yes', context)!,
                  style: Style.okButton),
              onPressed: () {
                provider.deleteFullLoad(id, index).then((value) => {
                  showAnimatedDialog(
                      context,
                      MyDialog(
                        icon: Icons.check,
                        title: 'Post Delete',
                        description: 'Your post deleted successfully',
                        isFailed: false, isFromPost: true,
                      ),
                      dismissible: false,
                      isFlip: false)
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: CustomText('no', style: Style.cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // TODO: implement rePost
    _showRepostDialog(truckLoad, isCityInterchange);
  }

  Future<void> _showRepostDialog(
      TruckLoad truckLoad, bool isCityInterchange) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: CustomText(
            'Are you sure want to ${isCityInterchange ? "City Interchange and Re-submit" : "Re-submit"} your post?',
            style: Style.title,
          ),
          actions: <Widget>[
            TextButton(
              child: CustomText(getTranslated('yes', context)!,
                  style: Style.okButton),
              onPressed: () async{
                bool res =  isCityInterchange?  await moreProvider.interChnageSendPost(context, truckLoad)
                    :await moreProvider.reSendPost(context, truckLoad);

                if(res){

                  isCityInterchange? showAnimatedDialog(
                      context,
                      MyDialog(
                        icon:
                        Icons.check,
                        title:
                        'City Interchange Post',
                        description:
                        'Your post submitted successfully',
                        isFailed:
                        false, isFromPost: true,
                      ),
                      dismissible:
                      false,
                      isFlip:
                      false) : showAnimatedDialog(
                      context,
                      MyDialog(
                        icon:
                        Icons.check,
                        title:
                        'Re Submit Post',
                        description:
                        'Your post submitted successfully',
                        isFailed:
                        false, isFromPost: true,
                      ),
                      dismissible:
                      false,
                      isFlip:
                      false);

                  Navigator.of(context)
                      .pop();}else{

                }
              },
            ),
            TextButton(
              child: CustomText('no', style: Style.cancelButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}


class MyGeneralPostCard extends StatefulWidget {

  final moreProvider = locator<MoreProvider>();
  final generalPostProvider = locator<GeneralPostProvider>();
  ScrollController _scrollController = ScrollController();
  var selectedPageNumber = 1;

  MyGeneralPostCard({Key? key}) : super(key: key) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        generalPostProvider.callGeneralPostApi(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  @override
  _MyGeneralPostCardState createState() => _MyGeneralPostCardState();
}

class _MyGeneralPostCardState extends State<MyGeneralPostCard>
    implements DeletePostInf {
  final authProvider = locator<AuthProvider>();
  final dashboardProvider = locator<DashboardProvider>();
  final moreProvider = locator<MoreProvider>();


  @override
  void initState() {
    super.initState();
 // getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<GeneralPostProvider>(
      builder: (context, model, child) => Container(
        margin: ResponsiveWidget.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            model.listOwnPost.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                  )
                : Expanded(
                    child: StaggeredGridView.countBuilder(
                    crossAxisCount: ResponsiveWidget.isDesktop(context)
                        ? 3
                        : ResponsiveWidget.isMobile(context)
                            ? 1
                            : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: model.listOwnPost.length,
                    itemBuilder: (context, index) {
                      return generalPost(model.listOwnPost[index], context,index);
                    },
                    //physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  )),
          ],
        ),
      ),
    );
  }

  generalPost(GernralPostOwnData generalPostOwnData,BuildContext context,int index) {
    return Container(
      width: 335,

      padding: EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:BaseWidget()
                .heading(generalPostOwnData.title!,generalPostOwnData.typeName!,generalPostOwnData.description!) ,),
          SizedBox(
            height: 5,
          ),
          SizedBox(height: 8,),
          BaseWidget().deleteMyPostButton((val) async{
            if (val == 10) {
              Future.delayed(
                  Duration.zero,
                      () => this.deleteOwnPost(generalPostOwnData.id!, index)//_showMyDialog(index)
              );

            }
            if(val==1){

              Future.delayed(
                  Duration.zero,
                      () => this.deleteOwnPost(generalPostOwnData.id!, index)
              );


            }
            if(val==3){
              TruckLoad load = new TruckLoad(
                  id: 0,
                  userId: authProvider.userDetailList[0].id,
                  nameOfPerson:"${authProvider.userDetailList[0].firstName} ${authProvider.userDetailList[0].lastName}",
                companyName: authProvider.userDetailList[0].companyName,
                type:generalPostOwnData.typeName,
                postingTime: generalPostOwnData.typeName,
                tableName: generalPostOwnData.typeName,
                topicName: generalPostOwnData.typeName,
                content: generalPostOwnData.description,
                partLoadOrNot: 0,
                privatePost: 0,
                mainTag: generalPostOwnData.typeName,
                mobileNumber:authProvider.userDetailList[0].mobileNumber,
                source: '',
                deviceId: '',
                destination: '',
                estPrice: '',
                association: '',
                alterativeNumber: '',
                companyDetailsName: '',
                companyLogo: '',
                comment: '',
                companyRating: "4.5",
                dnd: 0,
                isPaid: 0,
                isVerifiedByCompany: authProvider.userDetailList[0].isUserVerifiedByCompany.toString(),
                likes: '',
                makerName: '',
                loadWeight: '',
                mfgYear: '',
                modelName: '',
                otherDetails: '',
                postImages: [],
                ratings: 4.5,
                reminderUserName: '',
                sharableLink: '',
                transporterOrAgent: authProvider.userDetailList[0].transporterOrAgent,
                typeOfCargo: '',
                typeOfPayment: '',
                userList: '',
                vehicleSize: '', website: '',


              );

              await Utils().callShareFunction('',load,context);
            }
          })

        ],
      ),
    );
  }

  final generalPostProvider = locator<GeneralPostProvider>();
  @override
  void deleteOwnPost(
    int postId,
    int index,
  ) {
    _showMyDialog(index, postId, generalPostProvider);
  }

  Future<void> _showMyDialog(int index, int id, GeneralPostProvider provider) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: CustomText(
                'Are you sure want to deleted your post?',
                style: Style.title,
              ),
              actions: <Widget>[
                TextButton(
                  child: CustomText(getTranslated('yes', context)!,
                      style: Style.okButton),
                  onPressed: () {
                    provider.deleteGeneralPost(id, index,context).then((value) => {
                          showAnimatedDialog(
                              context,
                              MyDialog(
                                icon: Icons.check,
                                title: 'Post Completed',
                                description: 'Your post Completed successfully',
                                isFailed: false, isFromPost: true,
                              ),
                              dismissible: false,
                              isFlip: false)
                        });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: CustomText('no', style: Style.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // TODO: implement rePost
    _showRepostDialog(truckLoad, isCityInterchange);
  }

  Future<void> _showRepostDialog(
      TruckLoad truckLoad, bool isCityInterchange) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: CustomText(
                'Are you sure want to ${isCityInterchange ? "City Interchange and Re-submit" : "Re-submit"} your post?',
                style: Style.title,
              ),
              actions: <Widget>[
                TextButton(
                  child: CustomText(getTranslated('yes', context)!,
                      style: Style.okButton),
                  onPressed: () {
                    isCityInterchange
                        ? moreProvider
                            .interChnageSendPost(context, truckLoad)
                            .then((value) => {
                                  showAnimatedDialog(
                                      context,
                                      MyDialog(
                                        icon: Icons.check,
                                        title: 'City Interchange Post',
                                        description:
                                            'Your post submitted successfully',
                                        isFailed: false, isFromPost: true,
                                      ),
                                      dismissible: false,
                                      isFlip: false)
                                })
                        : moreProvider
                            .reSendPost(context, truckLoad)
                            .then((value) => {
                                  showAnimatedDialog(
                                      context,
                                      MyDialog(
                                        icon: Icons.check,
                                        title: 'Re-submit Post',
                                        description:
                                            'Your post submitted successfully',
                                        isFailed: false, isFromPost: true,
                                      ),
                                      dismissible: false,
                                      isFlip: false)
                                });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: CustomText('no', style: Style.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void getData() async {
   await generalPostProvider.callGeneralPostApi();
  }
}



class MyJobCard extends StatefulWidget {
  MyJobCard(this.jobList);

  List<MyJobData> jobList;

  @override
  _MyJobCardState createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard> implements DeletePostInf {
  final authProvider = locator<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MoreProvider>(
      builder: (context, model, child) => Container(
        margin: ResponsiveWidget.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 35, vertical: 10)
            : EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: StaggeredGridView.countBuilder(
                physics: ScrollPhysics(),
                crossAxisCount: ResponsiveWidget.isDesktop(context)
                    ? 3
                    : ResponsiveWidget.isMobile(context)
                        ? 1
                        : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: widget.jobList.length,
                itemBuilder: (context, index) {
                  return cardMyJobPost(
                      index, context, widget.jobList[index], this, model,
                      userId: authProvider.userDetailList[0].id!);
                },
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  cardMyJobPost(int index, BuildContext context, MyJobData myJobPost,
      DeletePostInf postDelete, MoreProvider model,
      {int userId = 0}) {
    return Container(
      width: 335,
      // height: 255,
      padding: EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 18,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: Color(0xFFd35e61),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: Center(
                child: Text(
                  myJobPost.postJob!.type!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          BaseWidget().heading(
              myJobPost.postJob!.jobDescription!.isEmpty
                  ? ""
                  : myJobPost.postJob!.topicName!,myJobPost.postJob!.jobType!,
              myJobPost.postJob!.jobDescription!),
          SizedBox(height: 8),
          BaseWidget().deleteMyPostButton((val) async {
            if (val == 10) {
              Future.delayed(
                  Duration.zero, () => _showMyDialog(index, myJobPost, model));
            }
            if (val == 1) {
              Future.delayed(
                  Duration.zero, () => _showMyDialog(index, myJobPost, model));
            }
            if (val == 3) {
              String description =
                  "'Type : ${myJobPost.postJob!.type!}, \nSubject : ${myJobPost.postJob!.jobDescription}, \nPost Title : ${myJobPost.postJob!.jobDescription}, \nLink : https://api.tkdost.com/postJob/?id=${myJobPost.postJob!.id}'";
              // await Utils().callShareFunction(description);
            }
          })
        ],
      ),
    );
  }

  @override
  void deleteOwnPost(
    int postId,
    int index,
  ) {}

  Future<void> _showMyDialog(
      int index, MyJobData myJobData, MoreProvider provider) async {
    return showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: CustomText(
                'Are you sure want to deleted your post?',
                style: Style.title,
              ),
              actions: <Widget>[
                TextButton(
                  child: CustomText(getTranslated('yes', context)!,
                      style: Style.okButton),
                  onPressed: () {
                    provider.deleteJob(myJobData).then((value) => {
                          showAnimatedDialog(
                              context,
                              MyDialog(
                                icon: Icons.check,
                                title: 'Post Delete',
                                description: 'Your post deleted successfully',
                                isFailed: false, isFromPost: true,
                              ),
                              dismissible: false,
                              isFlip: false)
                        });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: CustomText('no', style: Style.cancelButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // TODO: implement rePost
  }
}

