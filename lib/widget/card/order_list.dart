import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/environment.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/order_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';
import 'package:trendingfood_flutter/widget/card/order_card.dart';
import 'package:trendingfood_flutter/widget/card/post_card.dart';
import 'package:trendingfood_flutter/widget/card/post_list.dart';

Widget orderWidget() {

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
    future: getCartOrders(),
  );
}

final lock = new Lock();
List <Widget> gameCells = new List<Widget>();
Food food = new Food();
Shop shop = new Shop();

ShopService shopService = locator<ShopService>();
FoodService foodService = locator<FoodService>();
OrderService orderService = locator<OrderService>();

Future<List<Widget>> getCartOrders() async{
  final prefs = await SharedPreferences.getInstance();
  await orderService.getOrderList().then((orderList) {
    gameCells = new List<Widget>();
    double totalPrice = 0;
    for (OrderItem orderItem in orderList) {
      if(orderItem.pictureId != null)
        orderItem.image = baseImagePath + orderItem.pictureId + '.png';
      gameCells.add(
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: new OrderCard(
                    item: OrderItem(
                    title: orderItem.title,
                    qty: orderItem.qty,
                    price: orderItem.price,
                    bgColor: Colors.deepOrange,
                    image: orderItem.image,
                  ),
                ),
              ),
            ],
          ),
      );
      totalPrice += orderItem.qty* orderItem.price;
    }
    // prefs.setString("totalPrice", totalPrice.toString());
    prefs.setDouble("totalPrice", totalPrice);
    // cartPriceStorage.setItem('1', totalPrice);
    return gameCells;
  }
  );
}
