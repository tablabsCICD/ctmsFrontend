
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_hr_management/organization/provider/auth_provider.dart';
import 'package:flutter_hr_management/organization/provider/bid_provider.dart';
import 'package:flutter_hr_management/organization/provider/buy_sell_provider.dart';
import 'package:flutter_hr_management/organization/provider/dashboard_provider.dart';
import 'package:flutter_hr_management/organization/provider/fleet_provider.dart';
import 'package:flutter_hr_management/organization/provider/gallery_provider.dart';
import 'package:flutter_hr_management/organization/provider/group/groupChatProvider.dart';
import 'package:flutter_hr_management/organization/provider/group/groupListProvider.dart';
import 'package:flutter_hr_management/organization/provider/job_provider.dart';
import 'package:flutter_hr_management/organization/provider/localization_provider.dart';
import 'package:flutter_hr_management/organization/provider/menu_provider.dart';
import 'package:flutter_hr_management/organization/provider/more_provider.dart';
import 'package:flutter_hr_management/organization/provider/org_provider.dart';
import 'package:flutter_hr_management/organization/provider/plan_provider.dart';
import 'package:flutter_hr_management/organization/provider/pool_purchase_provider.dart';
import 'package:flutter_hr_management/organization/provider/repeatProvider.dart';
import 'package:flutter_hr_management/organization/provider/route_provider.dart';
import 'package:flutter_hr_management/organization/provider/transport_provider.dart';

//GetIt locator = GetIt.asNewInstance();
GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => MenuProvider());
  locator.registerLazySingleton(() => AuthProvider());
  locator.registerLazySingleton(() => DashboardProvider());
  locator.registerLazySingleton(() => TransportProvider());
  locator.registerLazySingleton(() => JobProvider());
  locator.registerLazySingleton(() => GalleryProvider());
  locator.registerLazySingleton(() => BuySellProvider());
  locator.registerLazySingleton(() => PoolPurchaseProvider());
  locator.registerLazySingleton(() => MoreProvider());
  locator.registerLazySingleton(() => RouteProvider());
  locator.registerLazySingleton(() => BidProvider());
  locator.registerLazySingleton(() => OrgProvider());
  locator.registerLazySingleton(() => FleetProvider());
  locator.registerLazySingleton(() => PlanProvider());
  locator.registerLazySingleton(() => RepeatProvider());
  locator.registerLazySingleton(() => GroupListProvider());
  locator.registerLazySingleton(() => GroupChatProvider());
  locator.registerLazySingleton(() => LocalizationProvider(sharedPreferences: locator()));

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
