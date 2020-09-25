import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/data/selection.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/food/add_food_screen.dart';
import 'package:trendingfood_flutter/pages/food/edit_food.dart';
import 'package:trendingfood_flutter/pages/report/bike_details.dart';
import 'package:trendingfood_flutter/pages/shop/details.dart';
import 'package:trendingfood_flutter/service/order_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';

class FoodDetailsCartPage extends StatefulWidget {
  Food food;
  Shop shop;
  FoodDetailsCartPage(this.food, this.shop);

  @override
  State<StatefulWidget> createState() {
    return _FoodDetailsCartPageState(this.food, this.shop);
  }
}

class _FoodDetailsCartPageState extends State<FoodDetailsCartPage> {

  Food food;
  Shop shop;
  _FoodDetailsCartPageState(this.food, this.shop);

  final TextStyle bold = TextStyle(fontWeight: FontWeight.bold);
  String image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = food.imagePath==null?shop.imagePath:food.imagePath;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: setPostImageWidget(food.imagePath==null?shop.imagePath:food.imagePath),
          ),
          Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16.0,bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:16.0),
                    child: Text(
                      this.food.name==null?shop.name:food.name,
                      style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 16.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "8.4/85 reviews",
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("Rs. " + (this.food.price==null?1:food.price).toString(), style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),),
                                    Text("/per kg",style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.purple,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 5.0),
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                          child: Text(
                            "Key Specs",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SpecsBlock(
                                label: "Braised",
                                value: "80 `C",
                                icon: Icon(
                                  Icons.apps,
                                ),
                              ),
                              SpecsBlock(
                                label: "Broiled",
                                value: "A grill",
                                icon: Icon(
                                  Icons.apps,
                                ),
                              ),
                              SpecsBlock(
                                label: "Charred",
                                value: "Smoky",
                                icon: Icon(
                                  Icons.apps,
                                ),
                              ),
                              SpecsBlock(
                                label: "Smoked",
                                value: "12",
                                icon: Icon(
                                  Icons.apps,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        visibilityFoodEditButton(food.role==null?shop.role:food.role) ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: Text("Edit Now", style: TextStyle(
                                fontWeight: FontWeight.normal
                            ),),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditFoodPage(food)),
                              );
                            },
                          ),
                        ): new Container(),
                        visibilityFoodDetailsButton(food.role==null?shop.role:food.role) ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: Text("Book Now", style: TextStyle(
                                fontWeight: FontWeight.normal
                            ),),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            onPressed: () {
                              createOrder(context, food);
                            },
                          ),
                        ): new Container(),
                        visibilityFoodRequestButton(food.role==null?shop.role:food.role) ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: Text("Add Request Now", style: TextStyle(
                                fontWeight: FontWeight.normal
                            ),),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            onPressed: () {
                              showToast("Request SuccessFully");
                            },
                          ),
                        ): new Container(),
                        const SizedBox(height: 30.0),
                        Text("Description".toUpperCase(), style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0
                        ),),
                        const SizedBox(height: 10.0),
                        Text(
                          "Colorful, crunchy and very sweet! ", textAlign: TextAlign.justify, style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0
                        ),),
                        const SizedBox(height: 10.0),
                        Text(
                          "Food that is cooked by submerging partially or fully into hot oil. Often results in a crispy or crunchy texture and golden color.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                "Free Gifts",
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text("If you must cook them, do it quickly — their colors fade the longer you cook…"),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                              child: Text(
                                "Specification",
                                style: Theme.of(context).textTheme.title,
                              ),
                            ),
                            BorderedContainer(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text("Delivery Date"),
                                trailing: Text(
                                  "2019/12/02",
                                  style: bold,
                                ),
                              ),
                            ),
                            BorderedContainer(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text("Number (Lot)"),
                                trailing: Text(
                                  "20 kg",
                                  style: bold,
                                ),
                              ),
                            ),
                            BorderedContainer(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text("Category"),
                                trailing: Text(
                                  "Organic",
                                  style: bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("DETAIL",style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal
              ),),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton.icon(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              icon: Icon(Icons.message),
              label: Text("Message Seller"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}

void createOrder(BuildContext context, Food food) async{
  OrderItem orderItem = new OrderItem();
  orderItem.food = food;
  orderItem.qty = 1;
  orderItem.foodId = food.id;
  OrderService orderService = locator<OrderService>();
  await orderService.createOrder(orderItem).then((value) {
    if(value != null) {
      showToast(food.name + " Create Successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.cart)),
      );
    }else{
      DialogHelper.logFailure(context);
    }
  });
}