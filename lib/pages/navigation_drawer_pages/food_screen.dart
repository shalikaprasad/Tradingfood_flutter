import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/widget/card/post_list.dart';
import 'package:trendingfood_flutter/widget/search_file.dart';


class FoodScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final lock = new Lock();
    return new ListView(
        children: [
          SearchField(),
          Container(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 5.0, top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Frequently Bought Foods",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("I' pressed");
                  },
                  child: Text(
                    "View all",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: postWidget("food", null),
          ),
        ]
    );
  }

}
