import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/order_item.dart';

abstract class OrderService {
  Future<String> createOrder(OrderItem orderItem);
  Future<OrderItem> getOrder(String id);
  Future<List<OrderItem>> getOrderList();
}