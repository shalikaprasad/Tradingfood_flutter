import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trendingfood_flutter/models/generate/OrderGenerate.dart';

@JsonSerializable(nullable: false)
class OrderItem {
  int id;
  int qty;
  Color bgColor;
  int userId;
  int foodId;
  Food food;
  String title;
  String image;
  double price;
  String pictureId;

  OrderItem({this.id, this.qty, this.bgColor, this.userId, this.foodId, this.food, this.title, this.image, this.price, this.pictureId});

  factory OrderItem.fromJson(Map<String, dynamic> json) => orderFromJson(json);
  Map<String, dynamic> toJson() => orderToJson(this);
}