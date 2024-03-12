import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hr_management/organization_portal/auth/login_screen.dart';
import 'package:flutter_hr_management/organization_portal/company/company_drawer_menu.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/comp_discussion_screen.dart';
import 'package:flutter_hr_management/organization_portal/company/company_menu/company_bids.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/model/auth_api.dart';
import 'package:flutter_hr_management/organization_portal/model/organization_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/app_constants.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';
import 'company_menu/all_users.dart';
import 'company_menu/comp_buy_sell.dart';
import 'company_menu/comp_full_load.dart';
import 'company_menu/company_dashboard.dart';

class CompanyMenuPage extends StatefulWidget {
  Organization? organization;
  final orgProvider = locator<OrgProvider>();
  List<User>? userDetailList;

  CompanyMenuPage(
    this.organization, {
    Key? key,
    this.userDetailList,
  }) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization!.id!);
  }

  @override
  _CompanyMenuPageState createState() => _CompanyMenuPageState();
}

class _CompanyMenuPageState extends State<CompanyMenuPage> {
  late Widget container;
  String dropdownValue = 'English';
  final companyProvider = locator<OrgProvider>();
  List<String> _valueList = ["English", "हिंदी"];
  late TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    container = CompanyDashboard(widget.organization!);
    AppConstants.languages
        .forEach((language) => _valueList.add(language.languageName!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuProvider>().scaffoldKey,
      appBar: ResponsiveWidget.isMobile(context)
          ? AppBar(
              leading: ResponsiveWidget.isDesktop(context)
                  ? Image.asset(
                      'assets/images/tkd.png',
                      height: 500,
                      width: 500,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: context.read<MenuProvider>().controlMenu,
                    ),
              title: CustomText(
                getTranslated('All Users', context)!,
                style: appbarTextStyle,
              ),
              backgroundColor: ColorResources.APPBAR_COLOR,
            )
          : AppBar(
              toolbarHeight: 60,
              leading: ResponsiveWidget.isDesktop(context)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/tkd.png',
                                ))),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: context.read<MenuProvider>().controlMenu,
                    ),
              backgroundColor: ColorResources.APPBAR_COLOR,
              actions: [
                Consumer<OrgProvider>(
                  builder: (context, model, child) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => new CupertinoAlertDialog(
                                  title: Text('Are you sure want to logout?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                          getTranslated('yes', context)!,
                                          style: TextStyle(
                                              color: ColorResources.RED)),
                                      onPressed: () {
                                        getLogoutFunction(model);
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        getTranslated('no', context)!,
                                        style: TextStyle(
                                            color: ColorResources.GREEN),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 3,
                      ),
                      child: Text(
                        'Logout',
                        style: Style.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      drawer: CompanyDrawerMenu(callBack: menuCallBack),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isDesktop(context))
              Expanded(
                  flex: 1,
                  child: CompanyDrawerMenu(
                    callBack: menuCallBack,
                  )),
            Expanded(flex: 5, child: container)
          ],
        ),
      ),
    );
  }

  menuCallBack(String value) {
    print(value);
    switch (value) {
      case Company_Dashboard:
        container = CompanyDashboard(widget.organization!);
        break;
      case All_Users:
        container = AllUsers(widget.organization!);
        break;
      case Full_Load:
        container = CompLoadScreen(widget.organization!);
        break;
      case Buy_Sell:
        container = CompBuySell(widget.organization!);
        break;
      case CPool_Purchase:
        container = CompDiscussionScreen(widget.organization!); //BuySellVehicles();
        break;
      case Bids:
        container = CompanyBidsScreen(widget.organization!);
        break;
      default:
        container = CompanyDashboard(widget.organization!);
    }
    if (!ResponsiveWidget.isDesktop(context)) Navigator.pop(context);
    setState(() {});
  }

  void getLogoutFunction(OrgProvider orgProvider) {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: Text(getTranslated('log_out', context)!),
              actions: <Widget>[
                TextButton(
                  child: Text(getTranslated('yes', context)!,
                      style: TextStyle(color: ColorResources.RED)),
                  onPressed: () {
                    logoutFunction(orgProvider);
                  },
                ),
                TextButton(
                  child: Text(
                    getTranslated('no', context)!,
                    style: TextStyle(color: ColorResources.GREEN),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Future<void> logoutFunction(OrgProvider orgProvider) async {
    await orgProvider.setCompanyVisitingFlag(false);
    await orgProvider.setCompanyOrgId(0);
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => Login_Screen()));
  }
}
