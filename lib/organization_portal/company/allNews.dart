import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../locator.dart';
import '../../constant/images.dart';
import '../../pages/widget/card/base_widgets.dart';
import '../../utils/colors.dart';
import '../model/organization/allNewsResponse.dart';
import '../util/ResponsiveWidget.dart';
import '../util/app_constant.dart';
import 'company_provider/news_provider.dart';


class AllNewsScreen extends StatefulWidget {
  Organization organization;
  AllNewsScreen(this.organization);

  @override
  State<StatefulWidget> createState() {
    return _AllNewsScreenState();
  }
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return Container(
            color: ThemeColor.baground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               /* top_bar(context, provider),
                SizedBox(
                  height: 16,
                ),*/
                provider.allNews.isEmpty && provider.isLoadDone
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("No Record found"),
                      ))
                    : const SizedBox(),
                allNewsData()
              ],
            ),
          );
        },
      ),
    );
  }

  allNewsData() {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: Container(
            padding:
            EdgeInsets.symmetric(horizontal: 33.w, vertical: 31.h),
            child: StaggeredGridView.countBuilder(
              physics: ScrollPhysics(),
              crossAxisCount: ResponsiveWidget.isDesktop(context) ? 3 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount:  provider.allNews.length,
              itemBuilder: (context, index) {
                return newsItem(provider.allNews[index]);
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            ),
          ),
        );
      },
    );
  }


  top_bar(BuildContext context, provider) {
    return Container(
      height: 60,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      child: serachBarFilter(),
    );
  }

  serachBarFilter() {
    return Consumer<NewsProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0x332C363F)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Stack(children: [
                                  SvgPicture.asset(Images.search_normal)
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            child: TextField(
                              controller: provider.searchController,
                              onChanged: (value) {
                                if (_debounce?.isActive ?? false) _debounce!.cancel();
                                _debounce = Timer(const Duration(milliseconds: 500), () {
                                  provider.getBySearchData(widget.organization);
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: "Search News",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: const Color(0x662C363F),
                                    fontSize: 14,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w400,
                                  )),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }



  newsItem(Content content)  {

    return Consumer<NewsProvider>(
      builder: (context, provider, child) {

        return Container(
          width: 375,
          //height: 67,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(color: Color(0x192C363F)),
              top: BorderSide(color: Color(0x192C363F)),
              right: BorderSide(color: Color(0x192C363F)),
              bottom: BorderSide(width: 1, color: Color(0x192C363F)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${content.topicName!}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                InkWell(
                    onTap: (){
                        showDeletePopup(content,provider);
                    },
                    child: SvgPicture.asset(Images.delete,),
                  )                ],
              ),
              Container(
                child: Text(
                  content.description!,
                  style: TextStyle(
                    color: const Color(0x99001E49),
                    fontSize: 10,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BaseWidget().image(image: content.image!),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (content.youtubeLink != null &&
                      content.youtubeLink!.isNotEmpty) {
                    _launchURL(content.youtubeLink!);
                  }
                },
                child: Container(
                  child: Text(
                    content.youtubeLink ?? "",
                    style: TextStyle(
                      color: const Color(0x99126CEE),
                      fontSize: 12.0,
                      // Replace `10.sp` if not using `flutter_screenutil`
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    // Ensure the URL has a scheme
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> showDeletePopup(Content content, NewsProvider provider) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Delete",style: TextStyle(fontFamily: AppConstant.FONTFAMILY,color: ThemeColor.theme_blue)),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure want to delete this news?",style: TextStyle(fontFamily: AppConstant.FONTFAMILY,color: ThemeColor.theme_blue),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text("Delete",style: TextStyle(fontFamily: AppConstant.FONTFAMILY,color: ThemeColor.red)),
              onPressed: () {
                provider.deletePost(content, context,widget.organization);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text("No",style: TextStyle(fontFamily: AppConstant.FONTFAMILY,color: ThemeColor.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
