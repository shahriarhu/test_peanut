import 'package:get_it/get_it.dart';
import 'package:test_peanut/core/services/authorization_api.dart';
import 'package:test_peanut/core/services/dashboard_api.dart';
import 'package:test_peanut/core/services/promo_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/core/view_models/dashboard_view_model.dart';
import 'package:test_peanut/core/view_models/home_view_model.dart';
import 'package:test_peanut/core/view_models/promo_view_model.dart';
import 'package:test_peanut/core/view_models/sign_in_view_model.dart';
import 'package:test_peanut/core/view_models/trade_list_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BaseViewModel());
  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => DashboardViewModel());
  locator.registerFactory(() => TradeListViewModel());
  locator.registerFactory(() => PromoViewModel());

  locator.registerLazySingleton(() => AuthorizationAPI());
  locator.registerLazySingleton(() => DashboardAPI());
  locator.registerLazySingleton(() => PromoAPI());
}
