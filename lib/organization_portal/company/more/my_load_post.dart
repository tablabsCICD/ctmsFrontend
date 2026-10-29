
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/dialog/received_bids_dialog.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../constant/images.dart';
import '../../../locator.dart';
import '../../../model/my_bids.dart';
import '../../../pages/widget/button.dart';
import '../../../pages/widget/card/base_widgets.dart';
import '../../../pages/widget/toast.dart';
import '../../../utils/colors.dart';
import '../../base_widget/all_cards.dart';
import '../../base_widget/custom_button.dart';
import '../../base_widget/custom_textfeild.dart';
import '../../base_widget/custom_textview.dart';
import '../../base_widget/getLoader.dart';
import '../../dialog/animated_custom_dialog.dart';
import '../../dialog/my_dialog.dart';
import '../../localization/language_constrants.dart';
import '../../model/auth_api.dart';
import '../../model/truck_load_model.dart';
import '../../provider/bid_provider.dart';
import '../../provider/buy_sell_provider.dart';
import '../../provider/delete_interface.dart';
import '../../provider/localization_provider.dart';
import '../../util/app_constant.dart';
import '../../util/style.dart';
import '../../util/utils.dart';
import '../company_provider/more_provider.dart';
import '../post_details.dart';


class MyRequirementCard extends StatefulWidget {
  final ConnectUser user;
  const MyRequirementCard(this.user, {Key? key}) : super(key: key);

  @override
  _MyRequirementCardState createState() => _MyRequirementCardState();
}

class _MyRequirementCardState extends State<MyRequirementCard> implements DeletePostInf {
  late MoreProvider _provider;
  final ScrollController _scrollController = ScrollController();

  bool _isInitialLoadDone = false;
  bool _isFetchingMore = false;
  int selectedPageNumber = 1;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _provider = context.read<MoreProvider>();

      if (widget.user.id != null) {
        await _fetchInitial();

        if (mounted) {
          setState(() {
            _isInitialLoadDone = true;
          });
        }
      }
    });

    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchInitial() async {
    await _provider.getOwnPostList(
      widget.user.id!,
      currentPage: selectedPageNumber,
    );
  }


  void _onScroll() async {
    if (_isFetchingMore || _provider.isMoreLoading) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      selectedPageNumber++;
      await _provider.getOwnPostList(
        widget.user.id!,
        currentPage: selectedPageNumber,
      );
      _isFetchingMore = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoreProvider>(
      builder: (context, model, child) {
        final bool isEmpty = model.myFullLoadTypeList.isEmpty;

        if (!_isInitialLoadDone && model.myFullLoadTypeList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              if (isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text("No posts available"),
                  ),
                )
              else
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    crossAxisCount: MediaQuery.of(context).size.width > 900
                        ? 3
                        : MediaQuery.of(context).size.width < 600
                        ? 1
                        : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: model.myFullLoadTypeList.length,
                    itemBuilder: (context, index) {
                      final item = model.myFullLoadTypeList[index];
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => buildPostBidDialog(context, item.id!),
                          );
                        },
                        child: itemMyPost(item, index),
                      );
                    },
                    shrinkWrap: true,
                    staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
                  ),
                ),
              if (model.isMoreLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }



  itemMyPost(TruckLoad truckLoad, int index) {
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
          /// TOP ROW (Valid + Tag)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: truckLoad.expireDate != null &&
                    truckLoad.expireDate!.isNotEmpty,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      width: 0.6,
                      color: ThemeColor.red,
                    ),
                  ),
                  child: Text(
                    "Valid till: ${truckLoad.expireDate ?? "-"}",
                    style: TextStyle(
                      color: ThemeColor.black,
                      fontSize: 9,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: ShapeDecoration(
                  color: const Color(0xFF2C8FEA),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(
                  truckLoad.mainTag ?? "-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// TITLE + CONTENT
          BaseWidget().headingWithoutDate(
            truckLoad.topicName ?? "-",
            truckLoad.content ?? "-",
          ),

          const SizedBox(height: 8),

          /// ROUTE
          BaseWidget().routes(
            truckLoad.source ?? "-",
            truckLoad.destination ?? "-",
          ),

          const SizedBox(height: 10),

          /// EXTRA DATA ROW (Cargo + Weight)
          Row(
            children: [
              _infoChip(
                Icons.inventory_2_outlined,
                truckLoad.cargoType ?? "-",
              ),
              const SizedBox(width: 8),
              _infoChip(
                Icons.local_shipping_outlined,
                "${truckLoad.vehicleWeight ?? "-"} T",
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// FOOTER ROW (Date + Bids + Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _footerItem(
                Icons.calendar_today_outlined,
                truckLoad.postingTime.toString(),
              ),
              _statusBadge(_getStatusText(truckLoad.isCompleted)),
            ],
          ),
        ],
      ),
    );
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return "Completed";
      case 0:
        return "Pending";
      default:
        return "In Progress";
    }
  }

  Widget _statusBadge(String status) {
    Color color;

    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  /// ---------------- SMALL INFO CHIP ----------------
  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// ---------------- FOOTER ITEM ----------------
  Widget _footerItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  labelText(String label) {
    return SizedBox(
      width: 332,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deleteOwnPost(int postId, int index) {
    // TODO: implement deleteOwnPost
  }

  @override
  void rePost(TruckLoad truckLoad, bool isCityInterchange) {
    // TODO: implement rePost
  }

}
