import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization_portal/util/ResponsiveWidget.dart';
import 'package:flutter_hr_management/organization_portal/util/color-resource.dart';
import 'package:flutter_hr_management/organization_portal/base_widget/search_widget.dart';
import 'package:flutter_hr_management/organization_portal/localization/language_constrants.dart';

class DashboardHeader extends StatefulWidget {

  const DashboardHeader({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardHeaderState createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String dropdownValue = 'English';
  late TextEditingController search = TextEditingController();
  String value = 'All requirements';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          if (!ResponsiveWidget.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: context.read<MenuProvider>().controlMenu,
            ),
          if (!ResponsiveWidget.isMobile(context))
            Image.asset('assets/images/tkd.png',height: 500,width: 500,),
          if (!ResponsiveWidget.isMobile(context))
            Spacer(flex: ResponsiveWidget.isDesktop(context) ? 2 : 1),
          Expanded(
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: SearchWidget(
                      controller: search,
                      hintText: getTranslated('Search TKDost', context)!,
                      onSubmit: () {},
                      onClearPressed: () {},),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Amit Shah",style: TextStyle(color: Colors.black,),),
                      Text("Shree Translogistic Ltd.",style: TextStyle(color: Colors.black,),),
                    ],
                  ),
                  Icon(Icons.account_circle_rounded,size: 50,color: Colors.black,),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(onPressed: (){},
                        icon: Icon(Icons.message,color: Colors.black,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropdownValue,
                        hint: Text("English",style: TextStyle(color: Colors.black),),
                        items: ["English","Marathi","Hindi"]
                            .map((choosen) => DropdownMenuItem(
                          value: choosen,
                          child: Text('$choosen',style: TextStyle(color: Colors.black),),
                        ))
                            .toList(),
                        isExpanded: false,
                        onChanged: (value){
                          setState(() {
                            dropdownValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
          ),
          //ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16 / 2,
      ),
      decoration: BoxDecoration(
        color: ColorResources.CARD_COLOR,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.white54, size: 34,),
          if (!ResponsiveWidget.isMobile(context))
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16 / 2),
              child: Text("Kishor Navale"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: ColorResources.CHAT_ICON_COLOR,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16 * 0.75),
            margin: EdgeInsets.symmetric(horizontal: 16 / 2),
            decoration: BoxDecoration(
              color: ColorResources.PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(Icons.search, color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
