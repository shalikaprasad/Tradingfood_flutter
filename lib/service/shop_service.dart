import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/shop.dart';

abstract class ShopService {
  Future<String> createShop(Shop shop);
  Future<Shop> getShop(String id);
  Future<List<Shop>> getShopList(String location);
}