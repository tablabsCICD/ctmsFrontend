import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/common/app_responsive.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_side_bar.dart';
import 'package:flutter_hr_management/pages/dashboard/widget/header_widget.dart';
import 'package:flutter_hr_management/pages/widget/side_bar_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_hr_management/organization/auth/login_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu/all_users.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_buy_sell.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_full_load.dart';
import 'package:flutter_hr_management/organization/company/company_menu/comp_pool_purchase_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu/company_bids.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:flutter_hr_management/organization/dialog/animated_custom_dialog.dart';
import 'package:flutter_hr_management/organization/dialog/custom-dialogBox.dart';
import 'package:flutter_hr_management/organization/dialog/my_dialog.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization/model/organization_model.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization/util/color-resource.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/star_display.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_button.dart';
import 'package:flutter_hr_management/organization/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization/base_widget/getImage.dart';
import 'package:flutter_hr_management/organization/base_widget/getLoader.dart';
import 'package:flutter_hr_management/organization/localization/language_constrants.dart';

class CompanyDashboard extends StatefulWidget {
  Organization organization;
  final orgProvider = locator<OrgProvider>();

  CompanyDashboard(this.organization, {Key? key}) : super(key: key) {
    orgProvider.getUsersByCompanyId(organization.id!);
    orgProvider.getStaticData(organization.id!);
  }

  @override
  _CompanyDashboardState createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  final authProvider = locator<AuthProvider>();
  final orgProvider = locator<OrgProvider>();
  late Widget container ;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    container = CompLoadScreen(widget.organization);
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      body: Consumer<OrgProvider>(
          builder: (context, model, child) => Row(
            children: [
              if (AppResponsive.isDesktop(context))
                Expanded(
                  child: CompanySideBar(),
                ),

              /// Main Body Part
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    HeaderWidget(),
                   /* Container(
                      height: 430,
                      child: Stack(
                        children: [
                          Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: ColorResources.HOME_APPBAR,
                              )
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: getContainer("All Users", 0,model.userCount.toString(), Colors.blue[100]!,"assets/images/navigation_image/my_profile.png"),
                              )

                          ),
                          Positioned(
                            top: 225,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  getContainer("Load Post",1,model.fullLoadPostCount.toString(), Colors.pink[100]!,'assets/images/navigation_image/insurance.png'),
                                  getContainer("Pool Purchase Post",2,model.poolPurchasePostCount.toString(), Colors.green[100]!,'assets/images/navigation_image/pool_purchase.png'),
                                  getContainer("Buy Sell Post",3, model.buySellPostCount.toString(), Colors.deepOrange[100]!,'assets/images/navigation_image/vehicle.png'),
                                  getContainer("All Bids",4,model.bidCont.toString(), Colors.indigo[100]!,'assets/images/bid.png'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 500,
                        child: container)
                    */
                  ],
                ),
              ),

            ],
          )),
    );
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

  Future<void> logoutFunction(OrgProvider authProvider) async {
    await authProvider.setCompanyVisitingFlag(false);
    await authProvider.setCompanyOrgId(0);
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => Login_Screen()));
  }

  getContainer(String title, int value,String count, Color bgColor, String img) {
    return InkWell(
      onTap: (){
        switch(value){
          case 0:
            container = AllUsers(widget.organization);
          //Navigator.push(context, MaterialPageRoute(builder: (builder)=>AllUsers(widget.organization)));
            break;
          case 1:
            container = CompLoadScreen(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompLoadScreen()));
            break;
          case 2:
            container = CompanyPoolPurchesScreen(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompanyPoolPurchesScreen()));
            break;
          case 3:
            container = CompBuySell(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompBuySell()));
            break;
          case 4:
            container = CompBuySell(widget.organization);
           // Navigator.push(context, MaterialPageRoute(builder: (builder)=>CompanyBidsScreen()));
            break;
          default:
            container = AllUsers(widget.organization);
        }
      },
      child: Card(
        elevation: 5,
        child: Container(
          height: 150,
          width: title == "All Users"?400:250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(5)),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[100],
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              img)))),
              SizedBox(height: 10,),
              CustomText(count,style: Style.heading,),
              SizedBox(height: 10,),
              CustomText(title,style: Style.heading1,),
            ],
          )
          /*child: ListTile(
            leading: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            img)))),
            title: CustomText(title,style: Style.title,),
            subtitle: CustomText(count,style: Style.subtitle,),
          ),*/
        ),
      ),
    );
  }
}
