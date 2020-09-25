
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendingfood_flutter/models/shop.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/service/service_locator.dart';
import 'package:trendingfood_flutter/service/shop_service.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/utils/shop_category.dart';
import 'package:trendingfood_flutter/widget/dialogs/dialog_helper.dart';

class AddShopPage extends StatefulWidget {
  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends State<AddShopPage> {

  final shopName = TextEditingController();
  final shopDescription = TextEditingController();
  final shopComment = TextEditingController();
  final shopRatings = TextEditingController();
  final shopLocation = TextEditingController();
  final shopLikes = TextEditingController();

  List<ShopCategory> shopCategory = ShopCategory.getShopCategory();
  List<DropdownMenuItem<ShopCategory>> dropDownMenuItems;

  Future<File> imageFile;

  @override
  void initState() {
    dropDownMenuItems = buildDropDownMenuItems(shopCategory);
    selectedShopCategory = dropDownMenuItems[0].value;

    // TODO: implement initState
    super.initState();
  }

  //Open gallery
  pickImageFromGallery(ImageSource source){
    final image = ImagePicker.pickImage(source: source);
    this.setState(() {
      imageFile = image;
    });
  }

  ShopCategory selectedShopCategory;
  ShopService shopService = locator<ShopService>();

  onChangeDropdownItem(ShopCategory value) {
    this.setState(() {
      selectedShopCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Screen Load',
    home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/other_screen_bk.jpg'),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
              ),
            ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
              child: new ListView(
                children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      showImage(),
                      RaisedButton(
                        child: Text("Select Image from Gallery"),
                        onPressed: () {
                          pickImageFromGallery(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Add Shop Name',
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
                      controller: shopName,
                      style: TextStyle(color: Colors.black, height: 1),
                      decoration: InputDecoration(
                        fillColor:Colors.white,
                        filled:true,
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Shop Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(32))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Add Shop Description',
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
                      controller: shopDescription,
                      style: TextStyle(color: Colors.black, height: 1),
                      decoration: InputDecoration(
                        fillColor:Colors.white,
                        filled:true,
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Shop Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(32))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Add Shop Category',
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
                        value: selectedShopCategory,
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
                      'Add Shop Location',
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
                      controller: shopLocation,
                      style: TextStyle(color: Colors.black, height: 1),
                      decoration: InputDecoration(
                        fillColor:Colors.white,
                        filled:true,
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Shop Location',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(32))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Add Shop Comment',
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
                      controller: shopComment,
                      style: TextStyle(color: Colors.black, height: 1),
                      decoration: InputDecoration(
                        fillColor:Colors.white,
                        filled:true,
                        prefixIcon: Icon(Icons.vpn_key),
                        hintText: 'Shop Comment',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(32))),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Shop shop = new Shop();
                      shop.name = shopName.text;
                      shop.location = shopLocation.text;
                      shop.description = shopDescription.text;
                      shop.category = selectedShopCategory.type;
                      shop.imageFile = await imageFile;
                      String shopname = await shopService.createShop(shop);
                      if(shopname != null) {
                        showToast(shopname + " Create Successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
                        );
                      }else{
                        DialogHelper.logFailure(context);
                      }
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
                          "Add Shop Item",
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
                          MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.home)),
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
                          "Cancel",
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

  List<DropdownMenuItem<ShopCategory>> buildDropDownMenuItems(List shopCategoryList) {
    List<DropdownMenuItem<ShopCategory>> items = List();
    for(ShopCategory shopCategory in shopCategoryList) {
      items.add(
          DropdownMenuItem(
            value: shopCategory,
            child: Text(shopCategory.type),
          )
      );
    }
    return items;
  }
}

