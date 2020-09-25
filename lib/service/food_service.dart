import 'package:trendingfood_flutter/models/food.dart';

abstract class FoodService {
  Future<String> createFood(Food food);
  Future<Food> getFood(String id);
  Future<List<Food>> getFoodList(String role, String id);
}