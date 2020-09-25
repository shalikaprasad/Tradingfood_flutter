import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/onboarding_screen.dart';
import 'package:trendingfood_flutter/pages/splash_screen.dart';
import 'package:trendingfood_flutter/pages/login_screen.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/radial_menu_screen.dart';

var routes = <String, WidgetBuilder>{
  "/onboarding": (BuildContext context) => OnboardingScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/bottomnavigator": (BuildContext context) => BottomNavigatior(BottomScreen.home),
  "/radial_menu_screen":(BuildContext context) => RadialMenuApp(),
};

void main() {
  setupServiceLocator();
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
      home: SplashScreen(),
      routes: routes)
  );
}

//Future navigateToSubPage(context) async {
//  Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
//}