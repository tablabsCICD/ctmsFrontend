import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import '../../../utils/colors.dart';
import '../../base_widget/custom_textview.dart';
import '../../base_widget/getLoader.dart';
import '../../model/auth_api.dart';
import '../../util/color-resource.dart';
import '../../util/style.dart';
import '../company_provider/more_provider.dart';
import 'my_buy_sell.dart';
import 'my_general_post.dart';
import 'my_jobs.dart';
import 'my_load_post.dart';

class MoreScreen extends StatefulWidget {
  final ConnectUser user;

  const MoreScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String selectedTab = 'Load Post';
  late MoreProvider moreProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize provider from locator (you could also use context.read() here)
    moreProvider = locator<MoreProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted && !_isInitialized && widget.user.id != null) {
        _isInitialized = true;
        await moreProvider.getOwnPostList(widget.user.id!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('${widget.user.firstName} ${widget.user.lastName} Posts', style: const TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Consumer<MoreProvider>(
          builder: (context, model, child) {
            return Column(
              children: [
                Container(
                  height: 62,
                  width: screenSize.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                      getCircularContainer("Load Post", selectedTab == "Load Post"),
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
                    child: _buildSelectedTabContent(selectedTab, model),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent(String tab, MoreProvider model) {
    switch (tab) {
      case "Load Post":
        return MyRequirementCard(widget.user);

      case "Buy/Sell Vehicles":
        if (model.myBuyVehicleList.isEmpty) {
          return Center(child: Text("No Post", style: Style.heading));
        }
        return MyBuySellCard(model.myBuyVehicleList, widget.user);

      case "General Post":
        if (model.myBuyVehicleList.isEmpty) { // fixed wrong list usage
          return Center(child: Text("No Post", style: Style.heading));
        }
        return MyGeneralPostCard(widget.user);

      case "Jobs":
      default:
        if (model.myJobList.isEmpty) {
          return Center(child: CustomText("No Post", style: Style.heading));
        }
        return MyJobCard(model.myJobList, widget.user);
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
        margin: const EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: isSelected ? 4 : 1,
        child: Container(
          height: 36,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
          decoration: BoxDecoration(
            color: isSelected ? ColorResources.RED : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: const Color(0xffd1ccc4)),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: ColorResources.RED.withOpacity(0.3),
                offset: const Offset(0, 3),
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
