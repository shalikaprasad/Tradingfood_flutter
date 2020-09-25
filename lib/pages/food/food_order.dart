
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/data/assets.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/models/food.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/cart_screen.dart';
import 'package:trendingfood_flutter/pages/food/add_to_cart.dart';
import 'package:trendingfood_flutter/service/food_service.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/utils/food_category.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';
import 'package:trendingfood_flutter/widget/images/network_image.dart';

class FoodOrderPage extends StatefulWidget {
  Food food;
  FoodOrderPage(this.food);

  @override
  State<StatefulWidget> createState() {
    return _FoodOrderState(this.food);
  }
}

class _FoodOrderState extends State<FoodOrderPage> {

  Food food;
  _FoodOrderState(this.food);

  final foodName = TextEditingController();
  final foodDescription = TextEditingController();
  final foodPrice = TextEditingController();
  final foodDiscount = TextEditingController();
  final foodRatings = TextEditingController();

  List<FoodCategory> foodCategory = FoodCategory.getFoodCategory();
  List<DropdownMenuItem<FoodCategory>> dropDownMenuItems;

  Future<File> imageFile;
  File imageFiles;
  bool isSelectImageButton = false;
  final Color background = Color(0xff2f2f4f);
  final Color primary = Color(0xff7b7517);
  final Color overlay = Color(0xff212129);

  @override
  void initState() {
    dropDownMenuItems = buildDropDownMenuItems(foodCategory);
    selectedFoodCategory = dropDownMenuItems[0].value;

    // TODO: implement initState
    super.initState();
    foodName.text = food.name;
    foodDescription.text = food.description;
    foodPrice.text = food.price as String;
    foodDiscount.text = food.discount as String;
    foodRatings.text = food.ratings as String;
  }

  //Open gallery
  pickImageFromGallery(ImageSource source){
    final image = ImagePicker.pickImage(source: source);
    this.setState(() {
      imageFile = image;
    });
  }

  FoodCategory selectedFoodCategory;
  FoodService foodService = locator<FoodService>();

  onChangeDropdownItem(FoodCategory value) {
    this.setState(() {
      selectedFoodCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Screen Load',
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.white,),
              onPressed: (){},
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage(other_screen_bk),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: new ListView(
                children: <Widget>[
                  showWeightList(),
                  SizedBox(width: 10.0),
                  showFoodImage(),
                  SizedBox(width: 20.0),
                  showFoodDesc(),
                  SizedBox(width: 10.0),
                  showFoodLocation(),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddToCartPage(food)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 5),
                      width: 300.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        // child: ProgressButton()
                        child: new Text(
                          "Make Order",
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
                  GestureDetector(
                    onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.checkout)),
                        );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      width: 300.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        // child: ProgressButton()
                        child: new Text(
                          "Cancel Order",
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
            ),
        ),
        ),
      );
  }

  Widget showImage(){
    if(food.imagePath==null || isSelectImageButton){
      return showLocalImage();
    }else{
      return showInitImage();
    }
  }
  Widget showInitImage() {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Image.network(food.imagePath)
    );
  }

  Widget showLocalImage() {
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

  Widget showWeightList() {
    return Column(
      children: <Widget>[
        Text("Fruits Cake", style: Theme.of(context).textTheme.title.copyWith(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.normal
        ),),
        SizedBox(height: 10.0),
        Text("strawberry & kiwi special", style: TextStyle(
            color: primary,
            fontSize: 16.0
        ),),
        Container(
          height: 60.0,
          child: ListView(
            padding: EdgeInsets.only(bottom: 5.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 20.0),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                label: Text("1 Kg", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
                backgroundColor: background,
                selected: true,
                onSelected: (val){},
                selectedColor: primary,
              ),
              SizedBox(width: 20.0),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                label: Text("2 Kg", style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold
                ),),
                backgroundColor: background,
                selected: false,
                onSelected: (val){},
                selectedColor: primary,
              ),
              SizedBox(width: 20.0),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                label: Text("3 Kg", style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold
                ),),
                backgroundColor: background,
                selected: false,
                onSelected: (val){},
                selectedColor: primary,
              ),
              SizedBox(width: 20.0),
              ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                label: Text("4 Kg", style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold
                ),),
                backgroundColor: background,
                selected: false,
                onSelected: (val){},
                selectedColor: primary,
              ),
            ],
          ),
        ),
      ],

    );
  }

  Widget showFoodImage() {
    return Column(
      children: <Widget> [
        Container(
          height: 180,
          child: Row(
            children: <Widget>[
              Expanded(
                child: PNetworkImage(food.imagePath),
              ),
              Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add,color: Colors.white,),
                    onPressed: (){},
                  ),
                  CircleAvatar(
                    child: Text("1"),
                    backgroundColor: primary,
                  ),
                  IconButton(
                    icon: Icon(Icons.remove,color: Colors.white,),
                    onPressed: (){},
                  ),
                ],
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20.0),
            width: double.infinity,
            child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: "\$84.", style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold
                  ),),
                  TextSpan(text: "99", style: TextStyle(
                      color: Colors.white
                  ),)
                ]
            )
            )),
      ]
    );
  }

  Widget showFoodDesc() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: overlay,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Image(
                  image: AssetImage(eggs),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("4 Eggs", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
            VerticalDivider(color: Colors.grey,),
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Image(
                  image: AssetImage(vanilla),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("2 tsp vanilla", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
            VerticalDivider(color: Colors.grey,),
            Expanded(child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Image(
                  image: AssetImage(sugar),
                  height: 50.0,
                  width: 50.0,
                ),
                SizedBox(height: 10.0),
                Text("1 cup sugar", style: TextStyle(
                    color: Colors.white
                ),)
              ],
            ),),
          ],
        )
    );
  }

  Widget showFoodLocation() {
    return Column(
        children: <Widget> [
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 20.0),
                Image(
                  image: AssetImage(map),
                  height: 75.0,
                  width: 75.0,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("DELIVERY", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0
                        ),),
                        Text("45, Amarlands", style: TextStyle(
                            color: Colors.grey.shade300
                        ),),
                        Text("Nr. Hamer Road, London",style: TextStyle(
                            color: Colors.grey.shade300
                        ),)
                      ]
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Text("Ratings", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
              ),),
              SizedBox(width: 20.0),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star, color: Colors.yellow,),
              Icon(Icons.star_half, color: Colors.yellow,),
              Text("(55)", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0
              ),)
            ],
          ),
        ]
    );
  }
}

