import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/models/order_item.dart';
import 'package:trendingfood_flutter/pages/bottom_pages/cart_screen.dart';

class OrderCard extends StatelessWidget {
  final OrderItem item;

  const OrderCard({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: setPostImageWidget(item.image),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 40.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 18.0,
                          padding: const EdgeInsets.all(2.0),
                          icon: Icon(Icons.remove),
                          onPressed: () {},
                        ),
                        Text(
                          "${item.qty}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        IconButton(
                          iconSize: 18.0,
                          padding: const EdgeInsets.all(2.0),
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              "Rs.${item.price * item.qty}",
              style: priceTextStyle,
            ),
          ],
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