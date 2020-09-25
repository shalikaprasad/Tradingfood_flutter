//import 'package:flutter/material.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:trendingfood_flutter/models/scoped-model/main_model.dart';
//import 'package:trendingfood_flutter/pages/navigation_drawer_pages/profile_screen.dart';
//import 'package:trendingfood_flutter/pages/navigation_drawer_pages/setting_screen.dart';
//import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/weather_screen.dart';
//import 'package:trendingfood_flutter/widget/menu_screen.dart';
//import 'package:trendingfood_flutter/widget/shop_screen.dart';
//import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';
//
//import '../food_details_page.dart';
//
//// Model
//
//class HomePage extends StatefulWidget {
//  // final FoodModel foodModel;
//
//  // HomePage(this.foodModel);
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  // List<Food> _foods = foods;
//
//  @override
//  void initState() {
//    // widget.foodModel.fetchFoods();
//    super.initState();
//  }
//
//  final menu = new Menu(items: [
//    MenuItem(
//      id: 'home',
//      title: 'HOME',
//    ),
//    new MenuItem(
//      id: 'weather',
//      title: 'WEATHER',
//    ),
//    new MenuItem(
//      id: 'profile',
//      title: 'PROFILE',
//    ),
//    new MenuItem(
//      id: 'setting',
//      title: 'SETTINGS',
//    ),
//  ],
//  );
//
//
//  var selectedMenuItemId = 'restaurant';
//  var activeScreen = restaurantScreen;
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: ListView(
//        padding: EdgeInsets.only(left: 20.0, right: 20.0),
//        children: <Widget>[
//          HomeTopInfo(),
//          FoodCategory(),
//          SizedBox(
//            height: 20.0,
//          ),
//          SearchField(),
//          SizedBox(
//            height: 20.0,
//          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                "Frequently Bought Foods",
//                style: TextStyle(
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//              GestureDetector(
//                onTap: () {
//                  print("I' pressed");
//                },
//                child: Text(
//                  "View all",
//                  style: TextStyle(
//                    color: Colors.orangeAccent,
//                    fontWeight: FontWeight.bold,
//                    fontSize: 18.0,
//                  ),
//                ),
//              ),
//            ],
//          ),
//          SizedBox(height: 20.0),
//          ScopedModelDescendant<MainModel>(
//            builder: (BuildContext context, Widget child, MainModel model) {
//              return Column(
//                children: model.foods.map(_buildFoodItems).toList(),
//              );
//            },
//          ),
//          ZoomScaffold(
//            menuScreen: new MenuScreen(
//              menu: menu,
//              selectedItemId: selectedMenuItemId,
//              onMenuItemSelected: (String itemId) {
//                selectedMenuItemId = itemId;
//                if (itemId == 'home') {
//                  setState(() => activeScreen = restaurantScreen);
//                }else if(itemId == 'weather') {
//                  setState(() => activeScreen = weatherScreen);
//                }else if(itemId == 'profile') {
//                  setState(() => activeScreen = profileScreen);
//                }else if(itemId == 'setting') {
//                  setState(() => activeScreen = settingScreen);
//                }
//              },
//            ),
//            contentScreen: activeScreen,
//          ),
//          Positioned(
//              right: 15.0,
//              bottom: 15.0,
//              child: FloatingActionButton(
//                backgroundColor: Colors.deepOrange.shade500,
//                child: Icon(
//                  Icons.add,
//                  color: Colors.white,
//                ),
//                onPressed: (){
////                  Navigator.push(
//////                    context,
//////                    MaterialPageRoute(builder: (context) => RadialMenu()),
//////                  );
//                },
//              )
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildFoodItems(Food food) {
//    return GestureDetector(
//      onTap: (){
//        Navigator.of(context).push(MaterialPageRoute(
//          builder: (BuildContext context) => FoodDetailsPage(
//            food: food,
//          ),
//        ));
//      },
//      child: Container(
//        margin: EdgeInsets.only(bottom: 20.0),
//        child: BoughtFood(
//          id: food.id,
//          name: food.name,
//          imagePath: "assets/images/lunch.jpeg",
//          category: food.category,
//          discount: food.discount,
//          price: food.price,
//          ratings: food.ratings,
//        ),
//      ),
//    );
//  }
//}
