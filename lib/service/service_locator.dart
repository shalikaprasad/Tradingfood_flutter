import 'package:get_it/get_it.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/customer_service.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/impl/authentication_service_impl.dart';
import 'package:trendingfood_flutter/service/impl/customer_service_impl.dart';
import 'package:trendingfood_flutter/service/impl/food_service_impl.dart';
import 'package:trendingfood_flutter/service/impl/order_service_impl.dart';
import 'package:trendingfood_flutter/service/impl/shop_service_impl.dart';
import 'package:trendingfood_flutter/service/order_service.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<CustomerService>(() => CustomerServiceImpl());
  locator.registerLazySingleton<FoodService>(() => FoodServiceImpl());
  locator.registerLazySingleton<ShopService>(() => ShopServiceImpl());
  locator.registerLazySingleton<OrderService>(() => OrderServiceImpl());
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationServiceImpl());
}