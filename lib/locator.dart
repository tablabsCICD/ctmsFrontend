
import 'package:flutter_hr_management/advertise_portal/provider/advertise_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/all_users_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/comp_buy_sell_provider.dart';
import 'package:flutter_hr_management/organization_portal/company/company_provider/news_provider.dart';
import 'package:flutter_hr_management/organization_portal/model/general_post_model.dart';
import 'package:flutter_hr_management/organization_portal/provider/Create_Org_Provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/general_post_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/job_list_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization_portal/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/buy_sell_provider.dart';

import 'package:flutter_hr_management/organization_portal/provider/fleet_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/gallery_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/job_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/localization_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/org_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/plan_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/pool_purchase_provider.dart';

import 'package:flutter_hr_management/organization_portal/provider/route_provider.dart';
import 'package:flutter_hr_management/organization_portal/provider/transport_provider.dart';

import 'organization_portal/company/company_provider/more_provider.dart';

//GetIt locator = GetIt.asNewInstance();
GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => MenuProvider());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => JobProvider());
  locator.registerLazySingleton(() => GalleryProvider());
  locator.registerLazySingleton(() => BuySellProvider());
  locator.registerLazySingleton(() => OrgUserProvider());
  locator.registerLazySingleton(() => MoreProvider());
  locator.registerLazySingleton(() => RouteProvider());
  locator.registerLazySingleton(() => BidProvider());
  locator.registerLazySingleton(() => OrgProvider());
  locator.registerLazySingleton(() => FleetProvider());
  locator.registerLazySingleton(() => JobListProvider());
  locator.registerLazySingleton(() => GeneralPostProvider());
  locator.registerLazySingleton(() => AdvProvider());
  locator.registerLazySingleton(() => NewsProvider());
  locator.registerLazySingleton(() => CompanyBidProvider());
  locator.registerLazySingleton(() => CompBuySellProvider());
  locator.registerLazySingleton(() => LocalizationProvider(sharedPreferences: locator()));


  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
