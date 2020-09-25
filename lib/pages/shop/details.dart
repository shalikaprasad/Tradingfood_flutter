import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/selection.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/report/bike_details.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/widget/card/post_list.dart';

class ShopDetailsCartPage extends StatefulWidget {
  Shop shop;
  ShopDetailsCartPage(this.shop);

  @override
  State<StatefulWidget> createState() {
    return _ShopDetailsCartPageState(this.shop);
  }
}

class _ShopDetailsCartPageState extends State<ShopDetailsCartPage> {

  Shop shop;
  _ShopDetailsCartPageState(this.shop);

  final TextStyle bold = TextStyle(fontWeight: FontWeight.bold);
  String image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = shop.imagePath;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: setPostImageWidget(shop.imagePath),
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
                      this.shop.name,
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
                    padding: const EdgeInsets.all(20.0),
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
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 20.0),
//                        visibilityAddFood(shop.role)? SizedBox(
//                          width: double.infinity,
//                          child: RaisedButton(
//                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                            color: Colors.purple,
//                            textColor: Colors.white,
//                            child: Text("Add Food Now", style: TextStyle(
//                                fontWeight: FontWeight.normal
//                            ),),
//                            padding: const EdgeInsets.symmetric(
//                              vertical: 16.0,
//                              horizontal: 32.0,
//                            ),
//                            onPressed: () {
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.addFood)),
//                              );
//                            },
//                          ),
//                        ): new Container(),
                        const SizedBox(height: 30.0),
                        visibilityFoodList(shop.role)? new Container(
                          child: postWidget("food", shop.id.toString()),
                        ): new Container(),
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

Widget setPostImageWidget(String headImageAssetPath){
  if(headImageAssetPath == null){
    return FadeInImage(
      placeholder: AssetImage(default_post),
      image: AssetImage(default_post),
      fit: BoxFit.cover,
      height: 400,
      alignment: Alignment.center,
    );
  }else{
    return FadeInImage(
      placeholder: NetworkImage(headImageAssetPath),
      image: NetworkImage(headImageAssetPath),
      fit: BoxFit.cover,
      height: 400,
      //if you use a larger image, you can set where in the image you like most
      //width alignment.centerRight, bottomCenter, topRight, etc...
      alignment: Alignment.center,
    );
  }
}