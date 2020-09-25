import 'package:trendingfood_flutter/models/food.dart';

Food foodFromJson(Map<String, dynamic> json) {
  return Food(
      id: json['id'] as double,
      name: json['name'] as String,
      pictureId: json['pictureId'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: json['price'] as double,
      discount: json['discount'] as double,
      ratings: json['ratings'] as int,
      like: json['like'] as int,
      base64Image: json['base64Image'] as String,
      role: json['role'] as String,
      shopId: json['shopId'] as String
  );
}


Map<String, dynamic> foodToJson(Food instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'pictureId': instance.pictureId,
  'description': instance.description,
  'category': instance.category,
  'price': instance.price,
  'discount': instance.discount,
  'ratings': instance.ratings,
  'like': instance.like,
  'base64Image': instance.base64Image,
  'role': instance.role,
  'shopId': instance.shopId,
};