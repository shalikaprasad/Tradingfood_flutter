import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';
import 'package:trendingfood_flutter/widget/card/post_card.dart';

Widget postWidget(String type, String id) {

  return FutureBuilder(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return Container(
        child: Wrap(
          children: gameCells,
        ),
      );
    },
    future: type =="shop"?getShopCategory():getFoodCategory(id),
  );
}

final lock = new Lock();
List <Widget> gameCells = new List<Widget>();
Food food = new Food();
Shop shop = new Shop();

ShopService shopService = locator<ShopService>();
FoodService foodService = locator<FoodService>();

Future<List<Widget>> getShopCategory() async{
  final prefs = await SharedPreferences.getInstance();
  String baseImagePath = "https://cpsstorage.blob.core.windows.net/assets/";
  await shopService.getShopList('Horana').then((shopList) {
    gameCells = new List<Widget>();
    if(shopList != null){
      customerStorage.setItem('shopRole', shopList.first.role);
      prefs.setString('shopRole', shopList.first.role);
      for (Shop shop in shopList) {
        if(shop.pictureId != null)
          shop.imagePath = baseImagePath + shop.pictureId + '.png';
        gameCells.add(
            new PostCard(
              headImageAssetPath: shop.imagePath,
              icon: Icons.shop,
              iconBackgroundColor: Colors.orange,
              title: shop.name,
              subtitle: shop.description + ' Quality',
              heartCount: shop.like,
              food: food,
              shop: shop,
              type: "shop",
              role: shop.role,
            )
        );
      }
    }
    return gameCells;
  }
  );
}

Future<List<Widget>> getFoodCategory(String id2) async{
  final prefs = await SharedPreferences.getInstance();
  String baseImagePath = "https://cpsstorage.blob.core.windows.net/assets/";
  // String role = customerStorage.getItem('role');
  String role = prefs.getString('role');
  if(id2 == null)
    id2 = prefs.getString('shopId');

  await foodService.getFoodList(role, id2).then((foodList) {
    gameCells = new List<Widget>();
    if(foodList != null){
      for (Food food in foodList) {
        if(food.pictureId != null){
          food.imagePath = baseImagePath + food.pictureId + '.png';
        }
        gameCells.add(
            new PostCard(
                headImageAssetPath: food.imagePath,
                icon: Icons.shop,
                iconBackgroundColor: Colors.orange,
                title: food.name,
                subtitle: food.description + ' Quality',
                heartCount: food.like==null?0:food.like,
                food: food,
                shop: shop,
                type: "food",
                role: food.role,
            )
        );
      }
    }
    return gameCells;
  }
  );
}
