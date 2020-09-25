import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/service/authentication_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';

class ShopServiceImpl extends ShopService {

  String basePath = azure + '/shop';
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  AuthenticationService authenticationService = locator<AuthenticationService>();

  @override
  Future<String> createShop(Shop shop) async {
    final prefs = await SharedPreferences.getInstance();
    String url = basePath + "/createShop?access_token=" + prefs.getString("access_token");

    if(shop.imageFile != null){
      final bytes = shop.imageFile.readAsBytesSync();
      String img64 = base64Encode(bytes);
      shop.base64Image = img64;
    }
    shop.role = customerStorage.getItem('role');
    String bodyRequest = jsonEncode(shop);
    String result = await post(url,headers: headers, body: bodyRequest).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var shop = json.decode(response.body)['body'];
        prefs.setString('shopId', shop['id'].toString());
        prefs.setString('shopName', shop['name']);
        return shop['name'];
      } else{
        return null;
      }
    });
    return result;
  }

  @override
  Future<Shop> getShop(String id) async {
    final prefs = await SharedPreferences.getInstance();
    Shop shop =await get(basePath + "/getShop?access_token=" + prefs.getString("access_token") + "&id=" + id).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        return json.decode(response.body)['body'];
      }else{
        return null;
      }
    });
    return shop;
  }

//  @override
//  Future<String> getShopForUser() async {
//
//    String shopId =await get(basePath + "/getShop?access_token=" + authenticationService.getToken()).then((response){
//      int statusCode = response.statusCode;
//      if(statusCode == 200){
//        var shop = json.decode(response.body)['body'];
//        customerStorage.setItem('shopId', shop['id']);
//        customerStorage.setItem('shopName', shop['name']);
//        return shop['id'];
//      }else{
//        print('No Shop');
//        return null;
//      }
//    });
//
//    return shopId;
//
//  }

  @override
  Future<List<Shop>> getShopList(String location) async {
    final prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role');
    List<Shop> shopListResult = await get(basePath + "/getAllShop/?access_token=" + prefs.getString("access_token") + "&location=" + location + "&role=" + role).then((response){
      int statusCode = response.statusCode;
      if(statusCode == 200){
        var list = json.decode(response.body)['body'];
        List<Shop> shopList = new List<Shop>();
        for(int i = 0; i<list.length; i++){
          Shop shop = new Shop();
          shop.id = list[i]['id'];
          shop.name = list[i]['name'];
          shop.pictureId = list[i]['pictureId'];
          shop.location = list[i]['location'];
          shop.category = list[i]['category'];
          shop.description = list[i]['description'];
          shop.like = list[i]['like'];
          shop.ratings = list[i]['ratings'];
          shop.comment = list[i]['comment'];
          shop.role = list[i]['role'];
          shopList.add(shop);
        }
        return shopList;
      }else{
        return null;
      }
    });
    return shopListResult;
  }
}