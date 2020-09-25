import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/order_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';

class OrderServiceImpl extends OrderService {

  String basePath = azure + '/order';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  AuthenticationService authenticationService = locator<AuthenticationService>();

  @override
  Future<String> createOrder(OrderItem order) async {
    final prefs = await SharedPreferences.getInstance();
    String url = basePath + "/createOrder?access_token=" + prefs.getString("access_token");

    String bodyRequest = jsonEncode(order);
    String result = await post(url,headers: headers, body: bodyRequest).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var userId = json.decode(response.body)['body'];
        return userId.toString();
      } else{
        return null;
      }
    });
    return result;
  }

  @override
  Future<OrderItem> getOrder(String id) async {
    final prefs = await SharedPreferences.getInstance();
    OrderItem orderItem = await get(basePath + "/getOrder?access_token=" + prefs.getString("access_token") + id).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        return json.decode(response.body)['body'];
      }else{
        return null;
      }
    });
    return orderItem;

  }

  @override
  Future<List<OrderItem>> getOrderList() async {
    final prefs = await SharedPreferences.getInstance();
    List<OrderItem> orderItemListResult = await get(basePath + "/getAllOrder?access_token=" + prefs.getString("access_token")).then((response){
      Food food = new Food();
      double totalPrice = 0;
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var list = json.decode(response.body)['body'];
        List<OrderItem> orderItemList = new List<OrderItem>();
        for(int i = 0; i<list.length; i++){
          OrderItem orderItem = new OrderItem();
          orderItem.id = list[i]['id'];
          orderItem.qty = list[i]['qty'];
          orderItem.userId = list[i]['userId'];
          orderItem.foodId = list[i]['foodId'];
          orderItem.title = list[i]['food']['name'];
          orderItem.price = list[i]['food']['price'];
          orderItem.pictureId = list[i]['food']['pictureId'];
          food.name = orderItem.title;
          food.pictureId = orderItem.pictureId;
          food.price = orderItem.price;
          food.id = orderItem.foodId;
          orderItem.food = food;
          orderItemList.add(orderItem);
          totalPrice += orderItem.qty * orderItem.price;
        }
        prefs.setDouble("totalPrice", totalPrice);
        return orderItemList;
      }else{
        return null;
      }
    });
    return orderItemListResult;
  }
}