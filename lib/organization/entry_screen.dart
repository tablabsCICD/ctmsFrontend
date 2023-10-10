import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hr_management/organization/auth/login_screen.dart';
import 'package:flutter_hr_management/organization/company/company_menu_page.dart';

import 'package:flutter_hr_management/organization/model/shared_post_model.dart';
import 'package:flutter_hr_management/organization/model/truck_load_model.dart';
import 'package:flutter_hr_management/organization/model/version.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/util/app_constants.dart';
import 'package:flutter_hr_management/organization/util/custom_text_style.dart';
import 'package:flutter_hr_management/organization/util/style.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uni_links/uni_links.dart';
import '../locator.dart';
import 'model/auth_api.dart';
import 'model/organization_model.dart';
import 'network/api_call.dart';

class EntryScreen extends StatefulWidget {
  @override
  EntryState createState()=> EntryState();

}

class EntryState extends State<EntryScreen> {

  bool visitingFlag = true;
  List<User> userDetailList = [];
  final authProvider = locator<AuthProvider>();
  final dashboardProvider = locator<DashboardProvider>();
  final orgProvider = locator<OrgProvider>();
  bool companyLogin = false, userLogin = true;
  List<Organization> orgList = [];
  bool isDebug=true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS){
        if(isDebug==true){
          versionControllApi();
        }else {
          //loginOrHome();
          initUniLinks();
        }
      }else {
        loginOrHome();
      }
    });
  }

  versionControllApi() async{
    APIHelper api=APIHelper();
    var result=await api.ApiGetData(AppConstants.GET_CURRENT_VERSION);
    Version version=Version.fromJson(result);
    print('the version is ${version.version}');
    if(version.version! == AppConstants.APP_VERSION){
     // loginOrHome();
      await initUniLinks();
    }else{
      upDateDailog();
    }
  }


  loginOrHome() async {
    visitingFlag = (await authProvider.getVisitingFlag())!;
    bool companyVisitingFlag = (await orgProvider.getCompanyVisitingFlag())!;
    if (visitingFlag == true) {


    }
    else if( companyVisitingFlag == true){
      int? OrgId = await orgProvider.getCompanyOrgId();
      List<Organization> organization = await orgProvider.getCompanyDetails(OrgId!);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  CompanyMenuPage(organization[0])));
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  Login_Screen()));
    }

   /* visitingFlag = (await authProvider.getVisitingFlag())!;
    if (visitingFlag == true) {
      int? empid = await authProvider.getEmpId();

      if (empid != null) {
        userDetailList = await authProvider.getUserDetails(empid);
        AppConstants.USER_OBJECT=authProvider.userDetailList[0];
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    MenuPage(userDetailList: userDetailList)));
      }else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    Login_Screen()));
      }
    }else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  Login_Screen()));
    }*/
  }

  SharedPostModel? truckLoad;
  loginOrDetails(String postId) async {
    visitingFlag = (await authProvider.getVisitingFlag())!;
    if (visitingFlag == true) {

    }else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  Login_Screen()));
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold (
      backgroundColor: Colors.white,
    body: Center(
      child:CircularProgressIndicator() ,
    ),
    );

  }
  void upDateDailog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('TKDost Update',style: appbarTextStyle,),
        content: const Text('New application update is available on play store please update the app.',style: titleTextStyle,),
        actions: <Widget>[
          TextButton(
            onPressed:(){
              redirectionUrl();
            } ,
            child: const Text('Update',style:titleTextStyle,),
          ),
        ],
      ),
    );
  }
  void redirectionUrl() {
    launchUrlString("https://play.google.com/store/apps/details?id=com.pdk.tkd");
  }

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    String postId='';
    try {
      final initialLink = await getInitialLink();
      final initialUri = await getInitialUri();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.

      debugPrint('LINK::::$initialLink');
      debugPrint('$initialUri');
      if(initialLink==null){
        loginOrHome();
      }else
      {
        debugPrint("App open using Shared link............");
        var uri = Uri.parse(initialLink);
        uri.queryParameters.forEach((k, v) {
          print('key: $k - value: $v');
          if(k=='id'){
            postId = v;
          }
        });

        loginOrDetails(postId);
      }

    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }

    StreamSubscription _sub = uriLinkStream.listen((Uri? uri) {
      // Use the uri and warn the user, if it is not correct
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }
}


