import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/company/more/own_genral_post.dart';
import 'package:flutter_hr_management/pages/widget/card/base_widgets.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../locator.dart';
import '../../base_widget/all_cards.dart';
import '../../base_widget/custom_textview.dart';
import '../../dialog/animated_custom_dialog.dart';
import '../../dialog/my_dialog.dart';
import '../../localization/language_constrants.dart';
import '../../model/auth_api.dart';
import '../../model/truck_load_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/buy_sell_provider.dart';
import '../../provider/delete_interface.dart';
import '../../provider/general_post_provider.dart';
import '../../provider/localization_provider.dart';
import '../../util/ResponsiveWidget.dart';
import '../../util/style.dart';
import '../../util/utils.dart';
import '../company_provider/more_provider.dart';

class MyGeneralPostCard extends StatefulWidget {
  final ConnectUser user;
  const MyGeneralPostCard(this.user, {Key? key}) : super(key: key);

  @override
  _MyGeneralPostCardState createState() => _MyGeneralPostCardState();
}

class _MyGeneralPostCardState extends State<MyGeneralPostCard>
    implements DeletePostInf {
  final moreProvider = locator<MoreProvider>();
  final generalPostProvider = locator<GeneralPostProvider>();
  final authProvider = locator<AuthProvider>();

  final ScrollController _scrollController = ScrollController();
  int selectedPageNumber = 1;

  @override
  void initState() {
    super.initState();

    // Add scroll listener safely
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        generalPostProvider.callGeneralPostApi(currentPage: selectedPageNumber);
        selectedPageNumber++;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralPostProvider>(
      builder: (context, model, child) => Container(
        margin: ResponsiveWidget.isDesktop(context)
            ? const EdgeInsets.symmetric(horizontal: 35, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            model.listOwnPost.isEmpty
                ? SizedBox(height: MediaQuery.of(context).size.height / 2.5)
                : Expanded(
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                crossAxisCount: ResponsiveWidget.isDesktop(context)
                    ? 3
                    : ResponsiveWidget.isMobile(context)
                    ? 1
                    : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: model.listOwnPost.length,
                itemBuilder: (context, index) {
                  return generalPost(
                      model.listOwnPost[index], context, index);
                },
                shrinkWrap: true,
                staggeredTileBuilder: (int index) =>
                const StaggeredTile.fit(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generalPost(
      GernralPostOwnData generalPostOwnData, BuildContext context, int index) {
    return Container(
      width: 335,
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x114A5568),
            blurRadius: 8,
            offset: Offset(0, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseWidget().heading(
            generalPostOwnData.title ?? '',
            generalPostOwnData.typeName ?? '',
            generalPostOwnData.description ?? '',
          ),
          const SizedBox(height: 8),
          BaseWidget().deleteMyPostButton((val) async {
            if (val == 10 || val == 1) {
              Future.delayed(
                Duration.zero,
                    () => deleteOwnPost(generalPostOwnData.id!, index),
              );
            }

            if (val == 3) {
              final user = authProvider.userDetailList[0];

              TruckLoad load = TruckLoad(
                id: 0,
                userId: user.id,
                type: generalPostOwnData.typeName,

                postingTime: '',

                companyName: user.companyName,
                nameOfPerson: "${user.firstName} ${user.lastName}",
                companyRating: "4.5",

                content: generalPostOwnData.description,
                topicName: generalPostOwnData.typeName,
                tableName: generalPostOwnData.typeName,

                companyLogo: '',
                partLoadOrNot: 0,
                privatePost: 0,
                mainTag: generalPostOwnData.typeName,

                mobileNumber: user.mobileNumber,
                source: '',
                destination: '',

                estPrice: '',
                association: '',
                alterativeNumber: '',
                companyDetailsName: '',
                deviceId: '',
                sharableLink: '',

                dnd: 0,
                isPaid: 0,

                isVerifiedByCompany:
                user.isUserVerifiedByCompany?.toString(),

                likes: '',
                makerName: '',
                modelName: '',
                mfgYear: '',
                vehicleSize: '',
                website: '',

                ratings: 4.5,
                reminderUserName: '',

                transporterOrAgent: user.transporterOrAgent,
                typeOfPayment: '',

                images: [],
                postImages: [],
                listOfFullLoadImages: [],

                cargoType: '',
                vehicleWeight: '',
                mobileOrLandline: '',
                category: '',
                isSharedInGroup: 0,

                isOpenForBid: 1,
                expireDate: null,

                isRepeat: 0,
                ispostOwnerVerifiedForTrack: 0,
                isQuoteOwnerVerifiedForTrack: 0,
                isCompleted: 0,

                experience: '',
                department: '',
                vehicleRegistrationNumber: '',
                emailId: '',

                isPaid99: false,
              );



            await Utils().callShareFunction('', load, context);
            }
          }),
        ],
      ),
    );
  }

  @override
  void deleteOwnPost(int postId, int index) {
    _showMyDialog(index, postId, generalPostProvider);
  }

  Future<void> _showMyDialog(
      int index, int id, GeneralPostProvider provider) async {
    return showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: CustomText(
          'Are you sure want to delete your post?',
          style: Style.title,
        ),
        actions: <Widget>[
          TextButton(
            child: CustomText(getTranslated('yes', context)!, style: Style.okButton),
            onPressed: () {
              provider.deleteGeneralPost(id, index, context).then((value) {
                showAnimatedDialog(
                  context,
                  MyDialog(
                    icon: Icons.check,
                    title: 'Post Completed',
                    description: 'Your post Completed successfully',
                    isFailed: false,
                    isFromPost: true,
                  ),
                  dismissible: false,
                  isFlip: false,
                );
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: CustomText('no', style: Style.cancelButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    _showRepostDialog(truckLoad, isCityInterchange);
  }

  Future<void> _showRepostDialog(
      TruckLoad truckLoad, bool isCityInterchange) async {
    return showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: CustomText(
          'Are you sure want to ${isCityInterchange ? "City Interchange and Re-submit" : "Re-submit"} your post?',
          style: Style.title,
        ),
        actions: <Widget>[
          TextButton(
            child: CustomText(getTranslated('yes', context)!, style: Style.okButton),
            onPressed: () {
              (isCityInterchange
                  ? moreProvider.interChnageSendPost(context, truckLoad)
                  : moreProvider.reSendPost(context, truckLoad))
                  .then((value) {
                showAnimatedDialog(
                  context,
                  MyDialog(
                    icon: Icons.check,
                    title: isCityInterchange
                        ? 'City Interchange Post'
                        : 'Re-submit Post',
                    description: 'Your post submitted successfully',
                    isFailed: false,
                    isFromPost: true,
                  ),
                  dismissible: false,
                  isFlip: false,
                );
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: CustomText('no', style: Style.cancelButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void getData() async {
    await generalPostProvider.callGeneralPostApi();
  }
}

