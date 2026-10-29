import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/getImage.dart';

class BuySellList extends StatefulWidget {
  final Organization organization;
  final buySellProvider = locator<CompBuySellProvider>();

  BuySellList(this.organization, {Key? key}) : super(key: key) {
    buySellProvider.getBuyVehicles(organization.id!);
  }

  @override
  _BuySellListState createState() => _BuySellListState();
}

class _BuySellListState extends State<BuySellList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.baground,
      body: Consumer<CompBuySellProvider>(
        builder: (context, model, child) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✅ TABS FOR BUY / SELL VEHICLE
                Container(
                  height: 50.h,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      getTabContainer("Buy Vehicle", model),
                      SizedBox(width: 10.w),
                      getTabContainer("Sell Vehicle", model),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                /// ✅ MAIN CARD OR NO DATA
                model.finalBuySellList.isEmpty
                    ? Container(
                    height: MediaQuery.of(context).size.height - 600,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: TextView(
                            title: "No Record Found",
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w900)))
                    : buildMainCard(context,model),

                SizedBox(height: 34.h),

                /// ✅ HEADER (All Trucks + View All)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      title: 'All Trucks',
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        filterIcon(model),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            model.getBuyVehicles(widget.organization.id!);
                          },
                          child: TextView(
                            title: 'View All',
                            color: ThemeColor.theme_blue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20.w),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10.h),

                /// ✅ GRID LIST
                model.finalBuySellList.isEmpty
                    ? SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                        child: Text(
                          "No Record Found",
                          style: Style.heading,
                        )))
                    : buildGridList(model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// -----------------------
  /// WIDGETS
  /// -----------------------

  Widget getTabContainer(String title, CompBuySellProvider model) {
    final isSelected = model.selectedBuySellTab == title;
    return InkWell(
      onTap: () {
        model.getFinalBuySellList(title);
      },
      child: Container(
        width: 200.w,
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: isSelected ? const Color(0xffC3262C) : Colors.white,
          border: Border.all(
            color:
            isSelected ? const Color(0xffC3262C) : Colors.white,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildMainCard(BuildContext context, CompBuySellProvider model) {
    final vehicle = model.finalBuySellList[0];

    return Container(
      width: 1100.w,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/org/logo_iveco.png', height: 28.h),
                  SizedBox(width: 12.w),
                  Text(
                    vehicle.vehicleRegistrationNumber ?? 'Unknown Vehicle',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text(
                        'Contact Number',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(vehicle.contactNumber.toString() ?? "-"),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.phone, size: 18),
                label: Text(
                  "Contact",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeColor.theme_blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          /// 🔹 DETAILS + IMAGE
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// VEHICLE DETAILS
              Expanded(
                child: Wrap(
                  spacing: 16.w,
                  runSpacing: 14.h,
                  children: [
                    _detailChip("Maker", vehicle.maker ?? ""),
                    _detailChip("Model", vehicle.model ?? ""),
                    _detailChip("MFG Year", vehicle.mfgYear ?? ""),
                    _detailChip("Location", vehicle.city ?? ""),
                  ],
                ),
              ),

              SizedBox(width: 20.w),

              /// VEHICLE IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: vehicle.image1 == null || vehicle.image1!.isEmpty
                    ? Image.asset(
                  'assets/org/cargo_truck.png',
                  height: 160.h,
                  width: 250.w,
                  fit: BoxFit.cover,
                )
                    : SizedBox(
                  height: 160.h,
                  width: 250.w,
                  child: Image.network(
                    vehicle.image1!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/org/cargo_truck.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Small reusable chip for details
  Widget _detailChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value.isNotEmpty ? value : "-",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }





  Widget buildGridList(CompBuySellProvider model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 39.w, vertical: 31.h),
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        physics: ScrollPhysics(),
        crossAxisCount: ResponsiveWidget.isDesktop(context) ? 2 : 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        itemCount: model.finalBuySellList.length,
        itemBuilder: (context, index) {
          final item = model.finalBuySellList[index];
          return Card(
            elevation: 4,
            color: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.image1 == null || item.image1!.isEmpty
                      ? Image.asset('assets/org/cargo_truck.png',
                      height: 120.h, width: 180.w)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PhotoView(
                        backgroundDecoration:
                        BoxDecoration(color: Colors.grey[100]),
                        imageProvider: NetworkImage(item.image1!)),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.vehicleRegistrationNumber ?? '',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w600)),
                        Text("${item.model ?? ''} | ${item.maker ?? ''}",
                            style: TextStyle(fontSize: 15.sp)),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 16),
                            SizedBox(width: 4),
                            Text(item.city ?? '',
                                style: TextStyle(fontSize: 15.sp)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text("Owner: ${item.ownerName ?? ''}",
                            overflow: TextOverflow.ellipsis),
                        Text("Agent: ${item.agentName ?? ''}",
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        shrinkWrap: true,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      ),
    );
  }

  Widget getCard(String title, String subtitle) {
    return Container(
      height: 80.h,
      width: 100.w,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: Color(0xffF7F7F7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
          Text(subtitle,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget filterIcon(CompBuySellProvider model) {
    return Container(
      width: 130.w,
      height: 43.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50.w, color: Color(0x332C363F)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            icon: SvgPicture.asset('assets/icons/filter.svg', height: 19.h),
            onSelected: (value) {},
            itemBuilder: (ctx) => [
              _buildPopupMenu('Sort By Name A to Z', 0, model),
              _buildPopupMenu('Sort By Name Z to A', 1, model),
            ],
          ),
          Text("Filter",
              style: TextStyle(
                  fontSize: 18.sp, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenu(String title, int id, CompBuySellProvider model) {
    return PopupMenuItem(
      child: Text(title,
          style:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
      onTap: () {
        if (id == 0) {
          model.orgBuySellList.sort((a, b) => a.ownerName!.compareTo(b.ownerName!));
        } else {
          model.orgBuySellList.sort((a, b) => b.ownerName!.compareTo(a.ownerName!));
        }
        setState(() {});
      },
    );
  }
}
