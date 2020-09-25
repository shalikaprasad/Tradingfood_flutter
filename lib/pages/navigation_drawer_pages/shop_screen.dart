import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/widget/card/post_list.dart';
import 'package:trendingfood_flutter/widget/search_file.dart';
import '../../widget/food_category.dart';
import '../../widget/zoom_scaffold.dart';


Screen restaurantScreen = new Screen(
    title: 'What would you like to eat?',
    contentBuilder: (BuildContext context){
      final lock = new Lock();
      return new ListView(
          children: [
            FoodCategory(),
            SearchField(),
            new Container(
              child: postWidget("shop", null),
            ),
          ]
      );
    }
);



