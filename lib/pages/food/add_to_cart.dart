
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/data/assets.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/cart_screen.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/utils/food_category.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';
import 'package:trendingfood_flutter/widget/images/network_image.dart';

class AddToCartPage extends StatefulWidget {
  Food food;
  AddToCartPage(this.food);

  @override
  State<StatefulWidget> createState() {
    return _AddToCartPageState(this.food);
  }
}

class _AddToCartPageState extends State<AddToCartPage> {

  Food food;
  _AddToCartPageState(this.food);


  Future<File> imageFile;
  File imageFiles;
  bool isSelectImageButton = false;
  final Color background = Color(0xff2f2f4f);
  final Color primary = Color(0xff7b7517);
  final Color overlay = Color(0xff212129);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FoodCategory selectedFoodCategory;
  FoodService foodService = locator<FoodService>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Screen Load',
      home: Scaffold(
        body: Stack(
            children: <Widget>[
              Container(
                height: 450,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(food.imagePath), fit: BoxFit.cover)),
              ),
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white,),
                    onPressed: (){},
                  )
                ],
              ),
              Positioned(
                  top: 345,
                  left: 0,
                  right: 0,
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0))
                  ),
                  child: showFoodDetails(food),
                ),
              ),
              Positioned(
                top: 325,
                right: 40,
                child: CircleAvatar(
                    radius: 20.0,
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.favorite_border)),
              ),
            ],
        ),
        ),
      );
  }

  Widget showFoodDetails(Food food) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            food.name,
            style:
            TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            "\$" + food.price.toString() +" / Kg",
            style: TextStyle(fontSize: 16.0),
          ),
          Row(
            children: <Widget>[
              Text(
                "100 gms for 1-2 pieces",
                style: TextStyle(color: Colors.grey.shade700),
              ),
              Spacer(),
              Icon(
                FontAwesomeIcons.fire,
                size: 14.0,
                color: Colors.pink.shade300,
              ),
              Text("160"),
            ],
          ),
          SizedBox(height: 20.0),
          Slider(
            onChanged: (value) {},
            min: 1,
            max: 5,
            value: 1.5,
          ),
          Row(
            children: <Widget>[
              Text("1.5 kg (12-14 pieces approx.)",
                  style: TextStyle(color: Colors.grey.shade700)),
              Spacer(),
              Text(
                "\$" + food.price.toString(),
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.pink.shade200,
                textColor: Colors.white,
                child: Text("Add to Cart"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.cart)),
                  );
                },
              )),
          SizedBox(height: 10.0),
          Center(child: Icon(Icons.keyboard_arrow_up)),
          Center(
            child: Text(
              "Know More",
              style: TextStyle(color: Colors.pink.shade300),
            ),
          ),
        ],
      );
  }

  Widget showFoodImage() {
    return Column(
      children: <Widget> [
        Container(
          height: 180,
          child: Row(
            children: <Widget>[
              Expanded(
                child: PNetworkImage(food.imagePath),
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add,color: Colors.white,),
                    onPressed: (){},
                  ),
                  CircleAvatar(
                    child: Text("1"),
                    backgroundColor: primary,
                  ),
                  IconButton(
                    icon: Icon(Icons.remove,color: Colors.white,),
                    onPressed: (){},
                  ),
                ],
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            width: double.infinity,
            child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: "\$84.", style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: "99", style: TextStyle(
                      color: Colors.white
                  ),)
                ]
            )
            )),
      ]
    );
  }

  Widget showFoodDesc() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: overlay,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Image(
                  image: AssetImage(eggs),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("4 Eggs", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
            VerticalDivider(color: Colors.grey,),
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Image(
                  image: AssetImage(vanilla),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("2 tsp vanilla", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
            VerticalDivider(color: Colors.grey,),
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Image(
                  image: AssetImage(sugar),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("1 cup sugar", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
          ],
        )
    );
  }

  Widget showFoodLocation() {
    return Column(
        children: <Widget> [
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0),
                Image(
                  image: AssetImage(map),
                  height: 75.0,
                  width: 75.0,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("DELIVERY", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0
                        ),),
                        Text("45, Amarlands", style: TextStyle(
                            color: Colors.grey.shade300
                        ),),
                        Text("Nr. Hamer Road, London",style: TextStyle(
                            color: Colors.grey.shade300
                        ),)
                      ]
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Text("Ratings", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
              ),),
              SizedBox(width: 20.0),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star_half, color: Colors.yellow,),
              Text("(55)", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0
              ),)
            ],
          ),
        ]
    );
  }
}

