import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/category_data.dart';
import 'package:trendingfood_flutter/data/colors.dart';
import 'package:trendingfood_flutter/data/game_list.dart';
import 'package:trendingfood_flutter/models/category_model.dart';
import 'package:trendingfood_flutter/widget/food_card.dart';

class GiftScreen extends StatelessWidget {
  final Color primary = Color(0xffE20056);
  final Color border = Color(0xffE1DDDE);
  final Color bg = Color(0xfffefefe);
  final List<bool> toggleIsSelected = [true, false, false];
  final Color secondColor = Color(0xffE70F0B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 60,
          padding: const EdgeInsets.only(top: 0.0, bottom: 2.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: ListTile(
            title: Center(
              child: Text(
                "Funny Coupons",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
        preferredSize: Size.fromHeight(50.0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getDailyTask(),
            const SizedBox(height: 20.0),
            getGameList(),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(avatars[0]),
              ),
              title: Text(
                "Shakwat Shamim JD",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "New Delhi",
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                          height: 200.0,
                          color: primary.withOpacity(0.1),
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          child: Image.network(
                            cake,
                            fit: BoxFit.contain,
                          )
                      ),
                      Positioned(
                        right: 0,
                        top: 60.0,
                        child: MaterialButton(
                          elevation: 0,
                          textColor: Colors.white,
                          minWidth: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 10.0,
                          ),
                          child: Icon(Icons.keyboard_arrow_right),
                          color: primary,
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 60.0,
                        child: MaterialButton(
                          elevation: 0,
                          textColor: Colors.white,
                          minWidth: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 10.0,
                          ),
                          child: Icon(Icons.keyboard_arrow_left),
                          color: primary,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.solidThumbsUp,
                          color: primary,
                        ),
                        const SizedBox(width: 5.0),
                        Text("75631"),
                        Spacer(),
                        Container(height: 20.0,width: 1.0,color: Colors.grey,),
                        Spacer(),
                        Icon(FontAwesomeIcons.comment),
                        const SizedBox(width: 5.0),
                        Text("213"),
                        Spacer(),
                        Container(height: 20.0,width: 1.0,color: Colors.grey,),
                        Spacer(),
                        Icon(FontAwesomeIcons.calendarTimes),
                        Spacer(),
                        Container(height: 20.0,width: 1.0,color: Colors.grey,),
                        Spacer(),
                        Icon(Icons.location_on),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Birthday Party"),
                            Text("Event Name"),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("2019/3/4"),
                            Text("Event Date")
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("New Delhi"),
                            Text("Venue"),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[Text("14:33:00"), Text("Time")],
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, bool active) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: active
              ? Border(
            top: BorderSide(
              color: primary,
              width: 2.0,
            ),
          )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
              color: active ? primary : Colors.grey.shade600,
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget getGameList(){
    final List<Category> _categories = gameList;
    return Column(
      children: [
        Text(
          "Select Your Game",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
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
        ),
      ],
    );
  }

  Widget getDailyTask(){
    return Column(
        children: [
          Text(
            "Select Daily Tasks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
          ),
          const SizedBox(height: 20.0),
          ToggleButtons(
            fillColor: secondColor,
            hoverColor: secondColor,
            renderBorder: true,
            borderColor: Colors.grey.shade300,
            color: Colors.grey.shade800,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.coins),
                    const SizedBox(height: 16.0),
                    Text(
                      "Coin Exchange",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.store),
                    const SizedBox(height: 16.0),
                    Text("Follow Store"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.share),
                    const SizedBox(height: 16.0),
                    Text("Share"),
                  ],
                ),
              ),
            ],
            isSelected: [
              true,
              false,
              false,
            ],
            onPressed: (index) {},
          ),
        ],
    );
  }
}