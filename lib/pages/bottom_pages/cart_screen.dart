import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/bottom_screen.dart';
import 'package:trendingfood_flutter/utils/bottom_navigator.dart';
import 'package:trendingfood_flutter/widget/card/order_card.dart';
import 'package:trendingfood_flutter/widget/card/order_list.dart';

final priceTextStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

class CartScreen extends StatefulWidget{
  @override
  _CartScreenState createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: 80,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              16.0,
            ),
            children: [
              Text(
                "My Order",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              new Container(
                child: orderWidget(),
              ),
              const SizedBox(height: 20.0),
              _buildDivider(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const SizedBox(width: 40.0),
                  Text(
                    "Transport(25 per kg)",
                    style: priceTextStyle,
                  ),
                  Spacer(),
                  getVAT(),
                  const SizedBox(width: 20.0),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildDivider(),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const SizedBox(width: 40.0),
                  Text(
                    "Total",
                    style: priceTextStyle.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  getTotalPrice(),
                  const SizedBox(width: 20.0),
                ],
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.yellow.shade700,
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigatior(BottomScreen.checkout)),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      height: 2.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }


}

Widget getVAT(){
  return FutureBuilder(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Text(
          "Rs. 0",
          style: priceTextStyle,
        );
      }
      return Container(
        child: vatWidget
      );
    },
    future: calVATWidget(),
  );

}
Widget vatWidget;

Future<Widget> calVATWidget() async{
  await catVat().then((vat) {
    vatWidget = Text(
      "Rs. " + (vat).toString(),
      style: priceTextStyle,
      );
    return vatWidget;
    }
  );
}

Future<double> catVat() async {
  final prefs = await SharedPreferences.getInstance();
  return (85*25).toDouble();
}

Widget getTotalPrice(){
  return FutureBuilder(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Text(
          "Rs. 0",
          style: priceTextStyle.copyWith(color: Colors.indigo),
        );
      }
      return Container(
          child: totalPriceWidget
      );
    },
    future: calTotalPriceWidget(),
  );

}
Widget totalPriceWidget;

Future<Widget> calTotalPriceWidget() async{
  await calTotalPrice().then((total) {
    totalPriceWidget = Text(
      "Rs. " + (total).toString(),
      style: priceTextStyle.copyWith(color: Colors.indigo),
    );
    return totalPriceWidget;
  }
  );
}

Future<double> calTotalPrice() async {
  final prefs = await SharedPreferences.getInstance();
  double total = prefs.getDouble("totalPrice") ;
  double money = total*0.1 + total;
  prefs.setDouble("money", money);
  return money;
}
