import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/app_responsive.dart';
import '../../../locator.dart';
import '../../../pages/dashboard/widget/header_widget.dart';
import '../../../utils/colors.dart';
import '../../model/organization_model.dart';
import '../allNews.dart';
import '../company_provider/news_provider.dart';
import 'company_side_bar.dart';

class NewsScreen extends StatefulWidget {
  Organization? organization;
  NewsScreen(this.organization, {Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final newsProvider = locator<NewsProvider>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsProvider.getAllData(widget.organization!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CompanySideBar(),
      backgroundColor: ThemeColor.baground,
      body: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            Expanded(child: CompanySideBar()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                HeaderWidget(
                  scaffoldKey: _scaffoldKey,
                  isSearchVisible: true,
                  onSearchTap: (value) {
                    newsProvider.searchController.text = value;
                    newsProvider.getBySearchData(widget.organization!);
                  },
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: AllNewsScreen(widget.organization!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
