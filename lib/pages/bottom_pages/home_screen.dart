import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/selection.dart';
import 'package:trendingfood_flutter/models/scoped-model/main_model.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/shop_screen.dart';
import 'package:trendingfood_flutter/pages/shop/add_shop.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';
import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/weather_screen.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/profile_screen.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/setting_screen.dart';
import 'package:trendingfood_flutter/widget/menu_screen.dart';

class HomeScreen extends StatefulWidget {

  final MainModel model;

  HomeScreen({this.model});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MenuScreen menuScreen = new MenuScreen();

  final menu = new Menu(items: [
    MenuItem(
        id: 'home',
        title: 'HOME',
      ),
      new MenuItem(
        id: 'weather',
        title: 'WEATHER',
      ),
      new MenuItem(
        id: 'profile',
        title: 'PROFILE',
      ),
      new MenuItem(
        id: 'setting',
        title: 'SETTINGS',
      ),
    ],
  );


  var selectedMenuItemId = 'restaurant';
  var activeScreen = restaurantScreen;

  Future<bool> onBackPress (){
    return DialogHelper.exit(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ZoomScaffold(
              menuScreen: new MenuScreen(
                menu: menu,
                selectedItemId: selectedMenuItemId,
                onMenuItemSelected: (String itemId) {
                  selectedMenuItemId = itemId;
                  if (itemId == 'home') {
                    setState(() => activeScreen = restaurantScreen);
                  }else if(itemId == 'weather') {
                    setState(() => activeScreen = weatherScreen);
                  }else if(itemId == 'profile') {
                    setState(() => activeScreen = profileScreen);
                  }else if(itemId == 'setting') {
                    setState(() => activeScreen = settingScreen);
                  }
                },
              ),
              contentScreen: activeScreen,
            ),
            Positioned(
              right: 15.0,
              bottom: 15.0,
              child: FloatingActionButton(
                  backgroundColor: Colors.deepOrange.shade500,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddShopPage()),
                    );
                  },
                )
              ),

          ],
        ),

      ),
    );
  }
}

/////////////////////////////////////////////////
////////////////////////////////////////////////
///////////////////////////////////////////////



