import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../provider/buy_sell_provider.dart';
import '../../provider/delete_interface.dart';
import '../../provider/localization_provider.dart';
import '../../util/style.dart';
import '../company_provider/more_provider.dart';

class MyBuySellCard extends StatefulWidget {
  final List<TruckLoad> buySellList;
  final ConnectUser user;

  const MyBuySellCard(this.buySellList, this.user, {Key? key}) : super(key: key);

  @override
  State<MyBuySellCard> createState() => _MyBuySellCardState();
}

class _MyBuySellCardState extends State<MyBuySellCard>
    implements DeletePostInf {
  final MoreProvider moreProvider = locator<MoreProvider>();

  late final ScrollController _scrollController;

  int selectedPageNumber = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 150 &&
        !isLoadingMore) {
      final userId = widget.user.id;
      if (userId != null) {
        isLoadingMore = true;

        moreProvider
            .getOwnPostList(
          userId,
          currentPage: selectedPageNumber,
        )
            .then((_) => isLoadingMore = false);

        selectedPageNumber++;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<MoreProvider>(
      builder: (context, model, child) {
        final isEmpty = widget.buySellList.isEmpty;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              if (isEmpty)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: const Center(child: Text("No data available")),
                )
              else
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    crossAxisCount: screenWidth > 900
                        ? 3
                        : screenWidth < 600
                        ? 1
                        : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    itemCount: widget.buySellList.length,
                    itemBuilder: (context, index) {
                      final item = widget.buySellList[index];
                      final userId = widget.user.id;

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: AllCards().cardSellBuyPost(
                          index,
                          context,
                          item,
                          this,
                          userId: userId ?? 0,
                        ),
                      );
                    },
                    staggeredTileBuilder: (_) =>
                    const StaggeredTile.fit(1),
                  ),
                ),

              /// PAGINATION LOADER
              if (model.isMoreLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void deleteOwnPost(int postId, int index) {
    _showMyDialog(index, postId, moreProvider);
  }

  Future<void> _showMyDialog(
      int index, int id, MoreProvider provider) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: CustomText(
          'Are you sure you want to delete your post?',
          style: Style.heading,
        ),
        actions: [
          TextButton(
            child: CustomText(
              getTranslated('yes', context) ?? 'Yes',
              style: Style.okButton,
            ),
            onPressed: () async {
              await provider.deleteBuySell(id, index);

              if (mounted) {
                Navigator.of(context).pop();
                showAnimatedDialog(
                  context,
                  MyDialog(
                    icon: Icons.check,
                    title: 'Post Deleted',
                    description:
                    'Your post was deleted successfully',
                    isFailed: false,
                    isFromPost: true,
                  ),
                  dismissible: false,
                  isFlip: false,
                );
              }
            },
          ),
          TextButton(
            child: CustomText('No', style: Style.cancelButton),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {}
}
