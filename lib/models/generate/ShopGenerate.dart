import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/shop.dart';

Shop shopFromJson(Map<String, dynamic> json) {
  return Shop(
      id: json['id'] as double,
      name: json['name'] as String,
      location: json['location'] as String,
      pictureId: json['pictureId'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      ratings: json['ratings'] as int,
      like: json['like'] as int,
      comment: json['comment'] as String,
      role: json['role'] as String,
      userId: json['userId'] as String,
      base64Image: json['base64Image'] as String
  );
}


Map<String, dynamic> shopToJson(Shop instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': instance.location,
  'pictureId': instance.pictureId,
  'description': instance.description,
  'category': instance.category,
  'like': instance.like,
  'ratings': instance.ratings,
  'comment': instance.comment,
  'role': instance.role,
  'userId': instance.userId,
  'base64Image': instance.base64Image,
};