import 'package:flutter/material.dart';

// DAta
import 'package:trendingfood_flutter/data/category_data.dart';
// Model
import '../models/category_model.dart';
import 'food_card.dart';

class FoodCategory extends StatelessWidget{

  final List<Category> _categories = categories;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index){
          return FoodCard(
            categoryName: _categories[index].categoryName,
            imagePath: _categories[index].imagePath,
            numberOfItems: _categories[index].numberOfItems,
          );
        },
      ),
    );
  }
}