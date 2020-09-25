
import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/pages/food/details.dart';
import 'package:trendingfood_flutter/pages/shop/details.dart';

class PostCard extends StatelessWidget {

  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartCount;
  final Food food;
  final Shop shop;
  final String type;
  final String role;

  PostCard({
    this.headImageAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
    this.heartCount,
    this.food,
    this.shop,
    this.type,
    this.role
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        print(title);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => type == "food" || role == "Transporter"?FoodDetailsCartPage(food, shop):ShopDetailsCartPage(shop)),
        );
      },
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: new Card(
          elevation: 10.0,
          child: new Column(
            children: [
              setPostImageWidget(headImageAssetPath),
              new Row(
                children: [
                  new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: iconBackgroundColor,
                        borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                      ),
                      child: new Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(
                          title,
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'mermaid',
                          ),
                        ),
                        new Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'bebas-neue',
                            letterSpacing: 1.0,
                            color: const Color(0xFFAAAAAA),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    width: 2.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                          const Color(0xFFAAAAAA),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: new Column(
                      children: [
                        new Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                        new Text(
                          '$heartCount',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget setPostImageWidget(String headImageAssetPath){
  if(headImageAssetPath == null){
    return Image(
      image: AssetImage(default_post),
    );
  }else{
    return new Image.network(
      headImageAssetPath,
      width: double.infinity,
      height: 150.0,
      fit: BoxFit.cover,
    );
  }
}