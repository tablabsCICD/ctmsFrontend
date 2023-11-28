import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_management/constant/images.dart';
import 'package:flutter_hr_management/model/response/login_data.dart';
import 'package:flutter_hr_management/pages/widget/editText_email.dart';
import 'package:flutter_hr_management/pages/widget/getImage.dart';
import 'package:flutter_hr_management/pages/widget/textview.dart';
import 'package:flutter_hr_management/route/app_routes.dart';
import 'package:flutter_hr_management/utils/colors.dart';
import 'package:flutter_hr_management/utils/sharepreferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../constant/constants.dart';

class HeaderWidget extends StatefulWidget {

  Function? onSearchTap;
  bool? isSearchVisible;
   HeaderWidget({Key? key, this.onSearchTap, required this.isSearchVisible}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getLoginDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true?SizedBox(height: 60.h,width: 60.h,child: CircularProgressIndicator(),):Container(
        color: Colors.white,
        height: 111.h,
        child: Row(
            children: [
            if (!AppResponsive.isDesktop(context))
    IconButton(
      icon: Icon(
        Icons.menu,
        color: AppColor.black,
      ),
      onPressed: () {

      },
    ),

    widget.isSearchVisible==true?searchBar():SizedBox.shrink(),
    if (!AppResponsive.isMobile(context)) ...{
    Spacer(),
    Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    // navigationIcon(icon: Icons.search),
    // navigationIcon(icon: Icons.send),
    //navigationIcon(icon: Icons.notifications_none_rounded),

      Builder(builder: (context) {
        return InkWell(
          onTap: () {
            showAlignedDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return _notificationDialogBuilder(context,setState);}
                  );
                },
                followerAnchor: Alignment.topLeft,
                targetAnchor: Alignment.bottomLeft,
                barrierColor: Colors.transparent);
          },
          child: Container(
              width: 50.w,
              height: 50.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(Images.notification,color: Colors.black,height: 30.h,width: 30.w,),
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:ThemeColor.baground)),);
      }),

      SizedBox(width: 27.w,),
      Builder(builder: (context) {
        return InkWell(
            onTap: () {
              showAlignedDialog(
                  context: context,
                  builder: (BuildContext context) {
                return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                   return _settingDialogBuilder(context,setState);}
                );
              },
                  followerAnchor: Alignment.topLeft,
                  targetAnchor: Alignment.bottomLeft,
                  barrierColor: Colors.transparent);
            },
            child: Container(
                width: 50.w,
                height: 50.h,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.settings,color: Colors.black,size: 30.h),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:ThemeColor.baground)),);
      }),

      SizedBox(width: 27.w,),
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: getImage(details!.data!.image==null?'':details!.data!.image!,height: 50.h,width: 50.w),
      ),
      SizedBox(width: 18.w,),
      InkWell(
        onTap: (){
          Navigator.restorablePushReplacementNamed(context, AppRoutes.profile);
        },
        child: Text('${Constants.LOGIN_NAME}', style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontFamily: GoogleFonts.poppins().fontFamily)),
      ),
      SizedBox(width: 20.w,)




    ],
    )
    }
    ]
    ,
    )
    ,
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }


  searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 121.w, top: 23.h, bottom: 25.h),
      width: 414.w,
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(43),
          color: Color(0xfff6f6f6)),
      child: edittext(),
    );
  }


  edittext() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        width: 414.w,
        height: 60.h,
        alignment: Alignment.center,
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            widget.onSearchTap!(value);
          },

          decoration: InputDecoration(
              hintText: "Search",


              border: InputBorder.none,

              suffixIcon: Icon(CupertinoIcons.search, color: Color(0xff7F7E7E))
              ,
              hintStyle: TextStyle(
                color: Color(0x662C363F),
                fontSize: 18.sp,
                fontFamily: GoogleFonts
                    .poppins()
                    .fontFamily,
                fontWeight: FontWeight.w400,


              )
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontFamily: GoogleFonts
                .poppins()
                .fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
  LoginDeatils? details;
  bool isLoading = false;
  void getLoginDetails() async{
    isLoading = true;
    setState(() {

    });
  details = await LocalSharePreferences().getLoginData();
  Constants.LOGIN_NAME=details!.data!.firstName!+" "+details!.data!.lastName!;
  isLoading = false;
  setState(() {

  });

  }

  bool notificationSwitchValue=false;
  bool rrSwitchValue=false;
  final MaterialStateProperty<Color?> trackColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return ThemeColor.theme_blue;
      }
      return null;
    },
  );
  final MaterialStateProperty<Color?> overlayColor =
  MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return ThemeColor.theme_blue.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.white;
      }
      return null;
    },
  );

  Widget _settingDialogBuilder(BuildContext context,StateSetter stateSetter) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Card(
          elevation: 7,
          margin: EdgeInsets.only(top: 35.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          child: Container(
            height: 200.h,
            width: 220.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h,),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            child: DefaultTextStyle(
              style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notification"),
                        Switch(
                          // This bool value toggles the switch.
                          value: notificationSwitchValue,
                          overlayColor: overlayColor,
                          trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
                          onChanged: (bool value) {
                            print("switch value: ${value}");
                            stateSetter(() {
                              notificationSwitchValue = value;
                            });
                          },
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("RoundRobin"),
                        Switch(
                          // This bool value toggles the switch.
                          value: rrSwitchValue,
                          /*activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          focusColor: Colors.white,
                          hoverColor: Colors.white,*/
                          overlayColor: overlayColor,
                          trackColor: trackColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
                          onChanged: (bool value) {
                            print("switch value: ${value}");
                            stateSetter(() {
                              rrSwitchValue = value;
                            });
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget _notificationDialogBuilder(BuildContext context,StateSetter stateSetter) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Card(
        elevation: 7,
        margin: EdgeInsets.only(top: 35.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Container(
          height: 900.h,
          width: 300.w,
          padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 16.h,),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Notifications",
                      style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
                    Text("Mark all as read",
                      style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),

                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            dense: true,
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: getImage("",height: 50.h,width: 50.h),
                            title: Text("Parag Sir",
                              style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
                            subtitle: Text("Commented in Teams",
                            style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70,right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index==1?SizedBox.shrink():Container(
                                  height: 135.h,
                                  width: 200.w,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Container(
                                      height: 57.h,
                                      width: 2.w,
                                      color: ThemeColor.red,
                                    ),
                                    SizedBox(width: 10.w,),
                                    Expanded(
                                      child: Text("dsnkdsj sdc dsfjodfjeo fdjf eofjewof skjdskjf dsk vcjdsjvcdsli dscj dsvcldsefj efoejf ",
                                        style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Text("11 min ago",
                                  style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
                              ],
                            ),
                          ),
                         Divider()
                        ],
                      )
                    );
                  },
                ),
              ),
              /*Divider(),
              Center(
                child: Text("See More",
                  style: TextStyle(fontWeight: FontWeight.w400, color: AppColor.black,fontFamily: GoogleFonts.poppins().fontFamily,fontSize: 14.sp),),
              ),
*/
            ],
          ),
        ),
      ),
    );
  }
}
