import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trendingfood_flutter/data/assets.dart';

class SellScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);
    final Color primaryColor = Color(0xffE70F0B);

    var titleTextStyle = TextStyle(
      color: Colors.black87,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    var teamNameTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
    );
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ToggleButtons(
            fillColor: primaryColor,
            hoverColor: primaryColor,
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
                    Icon(FontAwesomeIcons.ring),
                    const SizedBox(height: 16.0),
                    Text(
                      "Food",
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
                    Icon(FontAwesomeIcons.laravel),
                    const SizedBox(height: 16.0),
                    Text("Travel"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 32.0, 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.home),
                    const SizedBox(height: 16.0),
                    Text("Law"),
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
//          const SizedBox(height: 16.0),
//          Card(
//            elevation: 4.0,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10.0),
//            ),
//            child: Padding(
//              padding: const EdgeInsets.all(16.0),
//              child: Row(
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundImage: NetworkImage(avatars[0]),
//                  ),
//                  Spacer(),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.end,
//                    children: <Widget>[
//                      Text(
//                        "Libertad",
//                        style: teamNameTextStyle,
//                      ),
//                      const SizedBox(height: 5.0),
//                      Text(
//                        "0",
//                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 18.0,
//                        ),
//                      ),
//                    ],
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(
//                        top: 20.0, left: 20.0, right: 20.0),
//                    child: Text(
//                      ":",
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),
//                    ),
//                  ),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        "Gremio",
//                        style: teamNameTextStyle,
//                      ),
//                      const SizedBox(height: 5.0),
//                      Text(
//                        "2",
//                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 18.0,
//                        ),
//                      ),
//                    ],
//                  ),
//                  Spacer(),
//                  CircleAvatar(
//                    backgroundImage: NetworkImage(avatars[2]),
//                  ),
//                ],
//              ),
//            ),
//          ),
          const SizedBox(height: 16.0),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(images[1]),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Govt vegetable purchase programme successfully",
                        style: titleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Yesterday, 9:24 PM",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Football",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
                Positioned(
                  top: 190,
                  left: 20.0,
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Divider(),
          const SizedBox(height: 10.0),
          ListTile(
            title: Text(
              "Government has purchased 400,000 kg of vegetables from farmers",
              style: titleTextStyle,
            ),
            subtitle: Text("Yesterday, 7:02 PM | Dambulla"),
            trailing: Container(
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRwmXNj2j62Luyc-SHgXO89HiME9ZpQaEsazQ&usqp=CAU"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          const SizedBox(height: 10.0),
          ListTile(
            title: Text(
              "Thirty five lorries will be deployed to distribute this produce to the following local government authority areas",
              style: titleTextStyle,
            ),
            subtitle: Text("Yesterday, 7:02 PM | Kalutara"),
            trailing: Container(
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(images[1]),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}