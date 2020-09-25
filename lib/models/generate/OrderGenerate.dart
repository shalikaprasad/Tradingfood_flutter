import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/models/shop.dart';

OrderItem orderFromJson(Map<String, dynamic> json) {
  return OrderItem(
      id: json['id'] as int,
      qty: json['qty'] as int,
      userId: json['userId'] as int,
      foodId: json['foodId'] as int,
      food: json['food'] as Food,
  );
}


Map<String, dynamic> orderToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'qty': instance.qty,
  'userId': instance.userId,
  'foodId': instance.foodId,
  'food': instance.food
};