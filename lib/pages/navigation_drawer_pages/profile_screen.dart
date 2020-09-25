import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/data/selection.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/food/add_food.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/widget/card/post_list.dart';
import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';

class SharedPrefUtils {

  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) == null ?'prasad': pref.getString(key);
  }

}

final profileScreen = new Screen(
    title: 'OTHER SCREEN',
    background: new DecorationImage(
      image: new AssetImage('assets/other_screen_bk.jpg'),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
    ),
    contentBuilder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: 380,
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
              ),
            ),
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(pancake), fit: BoxFit.cover),
                ),
                foregroundDecoration:
                BoxDecoration(color: Colors.pink.withOpacity(0.8)),
              ),
            ),
            ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                const SizedBox(height: 90),
                _buildAvatar(avatars[4]),
                const SizedBox(height: 10.0),
                Text(
                  customerStorage.getItem('username') != null? customerStorage.getItem('username') : 'prasad',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Flutter & Full Stack Developer",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 32.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "25",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                "Followers",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "10",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline4,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                "Following",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Favorite",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline5,
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFavoriteCard(context, "Vegetables", vegetable),
                      const SizedBox(width: 10.0),
                      _buildFavoriteCard(context, "Fruits", fruit),
                      const SizedBox(width: 10.0),
                      _buildFavoriteCard(context, "Grains", grain),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      visibilityAddFood(customerStorage.getItem('role'))? SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.purple,
                          textColor: Colors.white,
                          child: Text("Add Food Now", style: TextStyle(
                              fontWeight: FontWeight.normal
                          ),),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddFoodPage()),
                            );
                          },
                        ),
                      ): new Container(),
                      const SizedBox(height: 30.0),
                      visibilityFoodList(customerStorage.getItem('role'))? new Container(
                        child: postWidget("food", null),
                      ): new Container(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
);

CircleAvatar _buildAvatar(String image, {double radius = 80}) {
  return CircleAvatar(
    backgroundColor: Colors.white,
    radius: radius,
    child: CircleAvatar(
      radius: radius - 2,
      backgroundImage: NetworkImage(image),
    ),
  );
}


Widget _buildFavoriteCard(BuildContext context, String title, String imagePath) {
  return Container(
    width: 150,
    height: 150,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4.0,
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10.0)),
          foregroundDecoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0)),
        ),
        Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}


