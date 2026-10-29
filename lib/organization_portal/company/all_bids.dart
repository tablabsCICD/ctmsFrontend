// Optimized BidList.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_colors.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/pages/widget/datepicker.dart';
import 'package:flutter_hr_management/pages/widget/show_toast.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../model/my_bids.dart';
import '../../utils/colors.dart';
import '../model/organization/org_quote_model.dart';
import 'more/post_details_new.dart';

class BidList extends StatefulWidget {
  final Organization organization;
  final bidProvider = locator<CompanyBidProvider>();

  BidList(this.organization, {Key? key}) : super(key: key);

  @override
  _BidListState createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  final ScrollController _scrollController = ScrollController();
  int selectedPageNumber = 0;
  bool _isInitCalled = false;
  String selectedFromDate = '';
  String selectedToDate = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitCalled) {
        _isInitCalled = true;
        selectedPageNumber = 0;
        _fetchCurrentTab();
      }

      _scrollController.addListener(_onScroll);
    });
  }

  void _fetchCurrentTab() {
    final model = widget.bidProvider;
    if (model.selectedQuoteTab == "Received Quotes") {
      model.getReceivedQuoteList(widget.organization.id!,
          currentPage: selectedPageNumber);
    } else {
      model.getPlacedQuoteList(widget.organization.id!,
          currentPage: selectedPageNumber);
    }
  }

  void _onScroll() {
    final model = widget.bidProvider;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !model.isLoading &&
        !model.isPaginating) {
      selectedPageNumber++;
      _fetchCurrentTab();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33.0.w, vertical: 20.h),
      child: Consumer<CompanyBidProvider>(
        builder: (context, model, child) {
          return Column(
            children: [
              // Tab Buttons
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    _getCircularContainer("Received Quotes",
                        model.selectedQuoteTab == "Received Quotes", model),
                    SizedBox(width: 10.w),
                    _getCircularContainer("Placed Quotes",
                        model.selectedQuoteTab == "Placed Quotes", model),
                  ],
                ),
              ),
              SizedBox(height: 26.h),

              // Quote Count + Filter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    title:
                        'Total Quote: ${model.selectedQuoteTab == "Placed Quotes" ? model.placedQuoteCount : model.receivedQuoteCount}',
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  _filterIcon(model)
                ],
              ),
              SizedBox(height: 32.h),

              // ListView
              Expanded(
                child: model.isLoading && model.orgBigingList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : model.orgBigingList.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.h),
                              child: Text(
                                "No Record Found",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: model.orgBigingList.length +
                                (model.isPaginating ? 1 : 0),
                            itemBuilder: (context, i) {
                              if (i == model.orgBigingList.length &&
                                  model.isPaginating) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final item = model.orgBigingList[i];
                              final biding = item.bidingList?.isNotEmpty == true
                                  ? item.bidingList!.last.bidings
                                  : null;
                              if (biding == null)
                                return const SizedBox.shrink();
                              return _buildBidCard(item, biding);
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBidCard(QuoteWithPostDetailList item, Bid biding) {
    DateTime date =
    DateTime.fromMillisecondsSinceEpoch(biding.loggedTime!);

    String formatted =
        "${date.day}-${date.month}-${date.year}  ${date.hour}:${date.minute.toString().padLeft(2, '0')}";

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 90.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(20.r)),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(20.r)),
              child: Image.asset(
                'assets/org/container.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.genericCardsDto?.nameOfPerson ?? '-',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900])),
                  SizedBox(height: 2.h),
                  Text(item.genericCardsDto?.companyName ?? '-',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900])),
                  SizedBox(height: 4.h),
                  Text("TKD${item.genericCardsDto?.id.toString()}",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900])),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16.sp, color: Colors.blueGrey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          "${item.genericCardsDto?.source ?? '-'} → ${item.genericCardsDto?.destination ?? '-'}",
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.blueGrey[600]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _infoChip("📞", biding.mobileNumber.toString() ?? '-'),
                      _infoChip(
                          "📊", item.bidingList?.length.toString() ?? '-'),
                      _infoChip("✉️", biding.emailId ?? '-'),
                      _infoChip("👤",
                          "${item.bidingList!.last.firstName ?? '-'} ${item.bidingList!.last.lastName ?? '-'}"),
                      _infoChip("💰", biding.amount ?? '-'),
                      _infoChip("🕒", formatted?? '-'),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton.icon(
                    onPressed: () => _showPostDetailsDialog(item),
                    icon: Icon(Icons.visibility, size: 18.sp),
                    label: const Text("View"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPostDetailsDialog(QuoteWithPostDetailList item) {
    final post = item.genericCardsDto;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 900,
          height: 600,
          child: Column(
            children: [
              /// HEADER BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Post & Bidding Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Colors.white),
                    )
                  ],
                ),
              ),

              /// BODY
              Expanded(
                child: Container(
                  color: const Color(0xfff3eef6),
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// POST CARD
                        PostDetailsCard(post: post!),

                        const SizedBox(height: 18),

                        /// BIDDING HEADER
                        Row(
                          children: const [
                            Icon(Icons.groups_rounded),
                            SizedBox(width: 6),
                            Text(
                              "Bidding List",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// BIDDING LIST
                        item.bidingList!.isEmpty
                            ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("No bids received yet"),
                          ),
                        )
                            : Column(
                          children: item.bidingList!
                              .map((bidder) =>
                              BidderCard(bidder: bidder))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _getCircularContainer(
      String title, bool isSelected, CompanyBidProvider model) {
    return InkWell(
      onTap: () {
        selectedPageNumber = 0;
        model.selectedQuoteTab = title;
        model.orgBigingList.clear();
        _fetchCurrentTab();
      },
      child: Container(
        width: 200.w,
        height: 150.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? const Color(0xffC3262C) : Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 14.sp)),
          SizedBox(width: 4.w),
          Text(text,
              style: TextStyle(fontSize: 13.sp, color: Colors.blueGrey[700])),
        ],
      ),
    );
  }

  Widget _filterIcon(CompanyBidProvider model) {
    return Container(
      width: 130.w,
      height: 43.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50.w, color: const Color(0x332C363F)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            icon: SvgPicture.asset(Images.filter, height: 19.h, width: 20.w),
            onSelected: (value) {},
            itemBuilder: (ctx) {
              bool isPlaced = model.selectedQuoteTab == "Placed Quotes";
              return [
                _buildPopupMenu(
                    'Sort By Company Name A to Z', 0, model, isPlaced),
                _buildPopupMenu(
                    'Sort By Company Name Z to A', 1, model, isPlaced),
                _buildPopupMenu('Sort By Date', 2, model, isPlaced),
              ];
            },
          ),
          Text(
            "Filter",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenu(
      String title, int? id, CompanyBidProvider model, bool isPlacedQuote) {
    return PopupMenuItem(
      child: Text(title,
          style: TextStyle(
              fontSize: 14.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
      onTap: () {
        if (id == 0 || id == 1) {
          model.sortBids(id!);
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                insetAnimationDuration: const Duration(milliseconds: 200),
                insetAnimationCurve: Curves.easeOutExpo,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return _showDateWiseDialog(
                        context, setState, model, isPlacedQuote);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _showDateWiseDialog(BuildContext context, StateSetter stateSetter,
      CompanyBidProvider model, bool isPlacedQuote) {
    return Container(
      width: 350.w,
      height: 350.h,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close_rounded, size: 20),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  child: _buildText(
                      context, selectedFromDate, "Select From Date", () async {
                    selectedFromDate = await DateTimePickerDialog()
                            .pickBeforeDateDialog(context) ??
                        "Select From Date";
                    stateSetter(() {});
                  }),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 200.w,
                  child: _buildText(context, selectedToDate, "Select To Date",
                      () async {
                    selectedToDate =
                        await DateTimePickerDialog().pickDateDialog(context) ??
                            "Select To Date";
                    stateSetter(() {});
                  }),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: ThemeColor.red),
                  onPressed: () {
                    if (selectedFromDate.isNotEmpty &&
                        selectedToDate.isNotEmpty) {
                      isPlacedQuote
                          ? model.getPlacedQuoteListByDate(selectedFromDate,
                              selectedToDate, widget.organization.id!)
                          : model.getRecievedQuoteListByDate(selectedFromDate,
                              selectedToDate, widget.organization.id!);
                      Navigator.of(context).pop();
                    } else {
                      showCustomToast(context, "Please select date",
                          Icons.clear, Colors.red);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Search",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: GoogleFonts.poppins().fontFamily)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(
      BuildContext context, String label, String label1, Function onClick) {
    return InkWell(
      onTap: () => onClick(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Text(label1,
                style: TextStyle(
                    color: const Color(0xff1B1B1B),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300)),
          ),
          SizedBox(height: 10.h),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 52.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Center(
                  child: Text(label,
                      style: TextStyle(
                          color: const Color(0xff1B1B1B),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300))),
            ),
          ),
        ],
      ),
    );
  }
}
