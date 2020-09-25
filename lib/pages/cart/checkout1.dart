import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/widget/button/rounded_bordered_container.dart';

const TextStyle boldText = TextStyle(
  fontWeight: FontWeight.bold,
);

class CheckoutOnePage extends StatelessWidget {
  final couponId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Pay & Go",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    color: Colors.indigo,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Total Money",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Rs. 7150.0",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: RoundedContainer(
                //     margin: const EdgeInsets.symmetric(
                //       vertical: 8.0,
                //       horizontal: 8.0,
                //     ),
                //     child: Column(
                //       children: <Widget>[
                //         Text(
                //           "Total Money",
                //           style: boldText,
                //         ),
                //         const SizedBox(height: 5.0),
                //         Text(
                //           "ing()",
                //           style: TextStyle(
                //             color: Colors.grey,
                //             fontSize: 12.0,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: couponId,
                    style: TextStyle(color: Colors.white, height: 1),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.code),
                        hintText: 'Add Coupon Code ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32))
                        )
                    ),
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 16,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF8E24AA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          // child: ProgressButton()
                          child: new Text(
                            "Check Coupon Validity",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white70,
                                fontFamily: 'mermaid',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    )
              ],
            ),
            const SizedBox(height: 30.0),
            RoundedContainer(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.paypal,
                  color: Colors.indigo,
                ),
                title: Text("Paypal"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.googleWallet,
                  color: Colors.indigo,
                ),
                title: Text("Google Pay"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            RoundedContainer(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.applePay,
                  color: Colors.indigo,
                ),
                title: Text("Apple Pay"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: RaisedButton(
                elevation: 0,
                padding: const EdgeInsets.all(24.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text("Continue"),
                color: Colors.indigo,
                textColor: Colors.white,
                onPressed: () {

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<double> getTotalPrice() async {
  final prefs = await SharedPreferences.getInstance();
  double money = prefs.getDouble("money") ;
  return money;
}