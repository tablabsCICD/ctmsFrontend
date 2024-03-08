
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/locator.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/util/style.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/custom_textview.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

typedef StringValue = Function(String);
const Company_Dashboard = 'Dashboard';
const All_Users = 'All Users';
const Full_Load = 'Full Load';
const CPool_Purchase = 'Pool Purchase';
const Buy_Sell = 'Buy Sell Vehicles';
const Bids = 'Quote';
const Chat = 'Chat';

// ignore: must_be_immutable
class CompanyDrawerMenu extends StatefulWidget {
  StringValue callBack;
  CompanyDrawerMenu({Key? key, required this.callBack}) : super(key: key);

  @override
  _CompanyDrawerMenuState createState() => _CompanyDrawerMenuState();
}
class _CompanyDrawerMenuState extends State<CompanyDrawerMenu>{
  final authProvider = locator<AuthProvider>();
  var selectedTab = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: 50,
        width: 270,
        color: Colors.white,
        child: ListView(
          children: [
            getTile('assets/images/navigation_image/icn_board_on.png', Company_Dashboard, context, (selectedTab == Company_Dashboard)),
            getDivider(),
            getTile('assets/images/navigation_image/icn_account_off.png', All_Users, context, (selectedTab == All_Users)),
            getDivider(),
            getTile('assets/images/navigation_image/icn_discussion_off.png', Full_Load, context, (selectedTab == Full_Load)),
            getDivider(),
            getTile('assets/images/navigation_image/icn_vehicles_off.png', Buy_Sell, context, (selectedTab == Buy_Sell)),
            getDivider(),
            getTile('assets/images/navigation_image/icn_pool_off.png', CPool_Purchase, context, (selectedTab == CPool_Purchase)),
            getDivider(),
            getTile('assets/images/bid.png', Bids, context, (selectedTab == Bids)),
            getDivider(),
          ],
        ),
      ),
    );
  }

  getDivider(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(height: 1,thickness: 1,),
    );
  }

  getTile(String img,String value,BuildContext context, bool isSelected){
    return Container(
      height: img=='assets/images/navigation_image/icn_bullet_01.png'?35:50,
      color: isSelected ? ColorResources.SELECTED_MENU : Colors.white,
      child: InkWell(
        onTap: (){
          widget.callBack(value);
          setState(() {
            selectedTab = value;
          });
        },
        child: Row(
          children: [
            Container(
              height: img=='assets/images/navigation_image/icn_bullet_01.png'?35:50,
              width: 5,
              color: isSelected ? ColorResources.PRIMARY_COLOR : Colors.transparent,
            ),
            SizedBox(width: 20,),
            Row(
              children: [
                Image.asset(img,width: img=='assets/images/navigation_image/icn_bullet_01.png'? 14 : 20,height: img=='assets/images/navigation_image/icn_bullet_01.png'?12:20,color: isSelected ? ColorResources.PRIMARY_COLOR : Colors.grey),
                SizedBox(width: 16,),
                CustomText(value,
                  style: img == 'assets/images/navigation_image/icn_bullet_01.png'
                      ? isSelected ? Style.selectedArrowMenuHeading :Style.menuArrowHeading
                      : isSelected ? Style.selectedMenuHeading : Style.menuHeading,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



