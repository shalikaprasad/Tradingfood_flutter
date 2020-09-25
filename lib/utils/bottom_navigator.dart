import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/cart_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/gift_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/home_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/sell_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/store_screen.dart';
import 'package:trendingfood_flutter/pages/cart/checkout1.dart';
import 'package:trendingfood_flutter/pages/food/add_food.dart';
import 'package:trendingfood_flutter/pages/food_details_page.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/food_screen.dart';
import 'package:trendingfood_flutter/pages/report/bike_details.dart';
import 'package:trendingfood_flutter/pages/report/result.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';


class BottomNavigatior extends StatefulWidget  {
  BottomScreen bottomScreen;
  BottomNavigatior(this.bottomScreen);

  @override
  _BottomNavigatiorState createState() => _BottomNavigatiorState(this.bottomScreen);
}

class _BottomNavigatiorState extends State<BottomNavigatior> {
  int _pageIndex = 0;

  BottomScreen bottomScreen;
  _BottomNavigatiorState(this.bottomScreen);

  final HomeScreen _homeScreen = new HomeScreen();
  final GiftScreen _giftScreen = new GiftScreen();
  final CartScreen _cartScreen = new CartScreen();
  final StoreScreen _storeScreen = new StoreScreen();
  final SellScreen _sellScreen = new SellScreen();

  Widget _showPage = new HomeScreen();

  Widget setShowPage(){
    if(BottomScreen.cart == bottomScreen){
      _showPage = new CartScreen();
      _pageIndex = 2;
    }
    else if(BottomScreen.gift == bottomScreen){
      _showPage = new GiftScreen();
      _pageIndex = 1;
    }
    else if(BottomScreen.store == bottomScreen){
      _showPage = new StoreScreen();
      _pageIndex = 3;
    }
    else if(BottomScreen.sell == bottomScreen){
      _showPage = new SellScreen();
      _pageIndex = 4;
    }
    else if(BottomScreen.checkout == bottomScreen){
      _showPage = new CheckoutOnePage();
      _pageIndex = 2;
    }
    else if(BottomScreen.details == bottomScreen){
      _showPage = new FoodDetailsPage();
      _pageIndex = 1;
    }
    else if(BottomScreen.result == bottomScreen){
      _showPage = new BikeDetailsPage();
    }
    else if(BottomScreen.addFood == bottomScreen){
      _showPage = new AddFoodPage();
    }
    else if(BottomScreen.home == bottomScreen){
      _showPage = new HomeScreen();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setShowPage();
  }

  Widget _pageChooser(int page){
    switch(page){
      case 0:
        return _homeScreen;
        break;
      case 1:
        return _giftScreen;
        break;
      case 2:
        return _cartScreen;
        break;
      case 3:
        return _storeScreen;
        break;
      case 4:
        return _sellScreen;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              "No Page Found by page chooser",
              style: new TextStyle(fontSize: 30),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        accentColor: Colors.deepPurple,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Image.asset(logo),
              onPressed: () { },
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              _pageIndex == 0
                  ? "Fast Dash"
                  : _pageIndex == 1
                  ? "Gift Store"
                  : _pageIndex == 2
                  ? "Cart"
                  : _pageIndex == 3 ? "Store": "News",
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    // size: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {}),
              IconButton(
                icon: _buildShoppingCart(),
                onPressed: () {},
              )
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _pageIndex,
            height: 75.0,
            items: <Widget>[
              Icon(Icons.add, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.compare_arrows, size: 30),
              Icon(Icons.call_split, size: 30),
              Icon(Icons.live_tv, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (int tappedIndex) {
              setState(() {
                _pageIndex = tappedIndex;
                _showPage = _pageChooser(tappedIndex);
              });
            },
          ),
          body: Container(
            color: Colors.blueAccent,
            child: Center(
              //child: Text(_pageIndex.toString(), textScaleFactor: 10.0),
              child: _showPage,
            ),
          )
      )

    );
  }

  Widget _buildShoppingCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart,
          // size: 30.0,
          color: Theme.of(context).primaryColor,
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}