import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageNavigator {
  static bool isFirstRun;
  static Future<bool> getIsOpen() async {
    Future<SharedPreferences> storage = SharedPreferences.getInstance();
    final SharedPreferences prefs  = await storage;
    isFirstRun = prefs.getBool("isOpen")??true;
    return isFirstRun;
  }

  static void goToIntro(BuildContext context) {
    getIsOpen().then((value){
      if(value){
        Navigator.pushNamed(context, "/onboarding");
      }else{
        Navigator.pushNamed(context, "/login");
      }
    });
  }

  static void goToHome (BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }
}