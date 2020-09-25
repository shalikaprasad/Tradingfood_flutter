import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:trendingfood_flutter/models/generate/FoodGenerate.dart';
import 'package:trendingfood_flutter/models/generate/ShopGenerate.dart';

@JsonSerializable(nullable: false)
class Shop {
  int id;
  String name;
  String location;
  String pictureId;
  String description;
  String category;
  int ratings;
  int like;
  String comment;
  File imageFile;
  String base64Image;
  String imagePath;
  String role;
  String userId;


  Shop({double id, String name, String location, String pictureId,String description,String category,int ratings,int like, String comment,String role,String userId, String base64Image});

  factory Shop.fromJson(Map<String, dynamic> json) => shopFromJson(json);
  Map<String, dynamic> toJson() => shopToJson(this);
}