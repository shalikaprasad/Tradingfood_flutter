import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';

import '../food_service.dart';

class FoodServiceImpl extends FoodService {

  AuthenticationService authenticationService = locator<AuthenticationService>();
  String basePath = azure + '/food';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  @override
  Future<String> createFood(Food food) async {

    final prefs = await SharedPreferences.getInstance();
    food.shopId = prefs.getString('shopId');
    food.role = prefs.getString('role');
    String url = basePath + "/createFood?access_token=" + prefs.getString("access_token");
    if(food.imageFile != null){
      final bytes = food.imageFile.readAsBytesSync();
      String img64 = base64Encode(bytes);
      food.base64Image = img64;
    }
    String bodyRequest = jsonEncode(food);
    String result = await post(url,headers: headers, body: bodyRequest).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var name = json.decode(response.body)['body'];
        return name;
      } else{
        return null;
      }
    });
    return result;
  }

  @override
  Future<Food> getFood(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String bodyRequest = jsonEncode(id);
    Food food = await post(basePath + "/getFood?access_token=" + prefs.getString("access_token"), body: bodyRequest).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        return json.decode(response.body)['body'];
      }else{
        return null;
      }
    });
    return food;
  }

  @override
  Future<List<Food>> getFoodList(String role, String shopId) async {
    final prefs = await SharedPreferences.getInstance();
    String url = azure + "/food/getAllFood?access_token=" + prefs.getString("access_token");
    List<Food> foodListResult = await get(azure + "/food/getAllFood?access_token=" + prefs.getString("access_token") + "&role=" + role + "&shopId=" + shopId).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var list = json.decode(response.body)['body'];
        List<Food> foodList = new List<Food>();
        for(int i = 0; i<list.length; i++){
          Food food = new Food();
          food.id = list[i]['id'];
          food.name = list[i]['name'];
          food.pictureId = list[i]['pictureId'];
          food.price = list[i]['price'];
          food.discount = list[i]['discount'];
          food.like = list[i]['like'];
          food.category = list[i]['category'];
          food.description = list[i]['description'];
          food.role = list[i]['role'];
          food.shopId = list[i]['shop_id'];
          foodList.add(food);
        }
        return foodList;
      }else{
        return null;
      }
    });
    return foodListResult;
  }
}