import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:trendingfood_flutter/models/generate/FoodGenerate.dart';

@JsonSerializable(nullable: false)
class Food {
  int id;
  String name;
  String pictureId;
  String role;
  String description;
  String category;
  double price;
  double discount;
  int ratings;
  int like;
  File imageFile;
  String base64Image;
  String imagePath;
  String shopId;


  Food({double id, String name, String pictureId,String description,String category,double price, double discount, int ratings,int like, String base64Image, String role, String shopId});

  factory Food.fromJson(Map<String, dynamic> json) => foodFromJson(json);
  Map<String, dynamic> toJson() => foodToJson(this);
}