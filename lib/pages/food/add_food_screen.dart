import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/utils/food_category.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';
import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';

final addFoodScreen = new Screen(
    title: 'ADD FOOD ITEM',
    background: new DecorationImage(
      image: new AssetImage('assets/other_screen_bk.jpg'),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
    ),
    contentBuilder: (BuildContext context) {
      List<FoodCategory> foodCategory = FoodCategory.getFoodCategory();
      List<DropdownMenuItem<FoodCategory>> dropDownMenuItems;

      final foodName = TextEditingController();
      final foodDescription = TextEditingController();
      final foodPrice = TextEditingController();
      final foodDiscount = TextEditingController();
      final foodRatings = TextEditingController();

      Future<File> imageFile;

//      //Open gallery
//      pickImageFromGallery(ImageSource source) {
//          imageFile = ImagePicker.pickImage(source: source);
//      }

      FoodCategory selectedFoodCategory;
      dropDownMenuItems = buildDropDownMenuItems(foodCategory);
      selectedFoodCategory = dropDownMenuItems[0].value;

      FoodService foodService = locator<FoodService>();

      onChangeDropdownItem(FoodCategory value) {
        selectedFoodCategory = value;
      }

      Widget showImage() {
        return FutureBuilder<File>(
          future: imageFile,
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Image.file(
                snapshot.data,
                width: 300,
                height: 300,
              );
            } else if (snapshot.error != null) {
              return const Text(
                'Error Picking Image',
                textAlign: TextAlign.center,
              );
            } else {
              return const Text(
                'No Image Selected',
                textAlign: TextAlign.center,
              );
            }
          },
        );
      }

      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: new ListView(
              children: <Widget>[
//                Center(
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        showImage(),
//                        RaisedButton(
//                          child: Text("Select Image from Gallery"),
//                          onPressed: () {
//                            pickImageFromGallery(ImageSource.gallery);
//                          },
//                        ),
//                      ],
//                    ),
//                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                      'Add Food Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white70
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: foodName,
                    style: TextStyle(color: Colors.black, height: 1),
                    decoration: InputDecoration(
                      fillColor:Colors.white,
                      filled:true,
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Food Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(32))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Add Food Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white70
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: foodDescription,
                    style: TextStyle(color: Colors.black, height: 1),
                    decoration: InputDecoration(
                      fillColor:Colors.white,
                      filled:true,
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Food Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(32))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Add Food Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white70
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).primaryColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: DropdownButton(
                      value: selectedFoodCategory,
                      items: dropDownMenuItems,
                      onChanged: onChangeDropdownItem,
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Add Food Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white70
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: foodPrice,
                    style: TextStyle(color: Colors.black, height: 1),
                    decoration: InputDecoration(
                      fillColor:Colors.white,
                      filled:true,
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Food Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(32))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Add Food Discount',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white70
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: foodDiscount,
                    style: TextStyle(color: Colors.black, height: 1),
                    decoration: InputDecoration(
                      fillColor:Colors.white,
                      filled:true,
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Food Discount',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(32))),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Food food = new Food();
                    food.name = foodName.text;
                    food.description = foodDescription.text;
                    food.category = selectedFoodCategory.type;
                    food.price = foodPrice.text as double;
                    food.discount = foodDiscount.text as double;
                    String foodname = await foodService.createFood(food);
                    if(foodname != null) {
                      showToast(foodname + " Create Successfully");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
                      );
                    }else{
                      DialogHelper.logFailure(context);
                    }
//                    String username = await customerService.getUser(customer);
//                    if(username != null) {
//                      showToast("Login Successfully");
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => BottomNavigatior()),
//                      );
//                    }else{
//                      DialogHelper.logFailure(context);
//                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 15),
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      // child: ProgressButton()
                      child: new Text(
                        "Login Account",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white70,
                            fontFamily: 'mermaid',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          ),
      );
    }
);


void showToast(String toastText){
  Fluttertoast.showToast(
      msg: toastText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

List<DropdownMenuItem<FoodCategory>> buildDropDownMenuItems(List foodCategoryList) {
  List<DropdownMenuItem<FoodCategory>> items = List();
  for(FoodCategory foodCategory in foodCategoryList) {
    items.add(
        DropdownMenuItem(
          value: foodCategory,
          child: Text(foodCategory.type),
        )
    );
  }
  return items;
}


