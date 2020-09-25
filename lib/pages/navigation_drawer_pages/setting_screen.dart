import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/assets.dart';
import 'package:trendingfood_flutter/data/local_storage.dart';
import 'package:trendingfood_flutter/pages/login_screen.dart';
import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';

final TextStyle headerStyle = TextStyle(
  color: Colors.grey.shade800,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

final settingScreen = new Screen(
    title: 'OTHER SCREEN',
    background: new DecorationImage(
      image: new AssetImage('assets/other_screen_bk.jpg'),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
    ),
    contentBuilder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "ACCOUNT",
                style: headerStyle,
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 0.5,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(avatars[4]),
                      ),
                      title: Text("prasad"),
                      onTap: () {},
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: false,
                      title: Text("Dark Theme"),
                      onChanged: (val) {},
                    ),
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: true,
                      title: Text("Active Now"),
                      onChanged: (val) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "PUSH NOTIFICATIONS",
                style: headerStyle,
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: true,
                      title: Text("Received notification"),
                      onChanged: (val) {},
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: false,
                      title: Text("Received newsletter"),
                      onChanged: null,
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: true,
                      title: Text("Received Offer Notification"),
                      onChanged: (val) {},
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      activeColor: Colors.purple,
                      value: true,
                      title: Text("Received App Updates"),
                      onChanged: null,
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Logout"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      );
    }
    );

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade300,
  );
}

