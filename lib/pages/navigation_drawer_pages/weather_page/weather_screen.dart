import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/widget/zoom_scaffold.dart';
import 'package:flutter/services.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/forecast/app_bar.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/forecast/forecast.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/forecast/forecast_list.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/forecast/radial_list.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/forecast/week_drawer.dart';
import 'package:trendingfood_flutter/pages/navigation_drawer_pages/weather_page/generic_widgets/sliding_drawer.dart';

final weatherScreen = new Screen(

    title: 'WEATHER SCREEN',
    background: new DecorationImage(
      image: new AssetImage('assets/other_screen_bk.jpg'),
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
    ),
    contentBuilder: (BuildContext context) {
      //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      return new Center(
         //child: Weather(),
        child: new Container(
            child: Weather(),
        ),
      );
    }
);

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => new _WeatherState();
}

class _WeatherState extends State<Weather> with TickerProviderStateMixin {

  String selectedDate = 'Thursday, August 27';
  OpenableController openableController;
  SlidingRadialListController listController;

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
        vsync: this,
        openDuration: const Duration(milliseconds: 250)
    )
      ..addListener(() => setState(() {}));

    listController = new SlidingRadialListController(
      itemCount: forecastRadialList.items.length,
      vsync: this,
    )
      ..open();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Forecast(
            list: forecastRadialList,
            listController: listController,
          ),

          // App Bar
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new ForecastAppBar(
              dateText: selectedDate,
              onDrawerArrowTap: openableController.open,
            ),
          ),

          // Right Drawer
          new SlidingDrawer(
            openableController: openableController,
            drawer: new WeekDrawer(
              onDaySelected: (String title) {
                setState(() => selectedDate = title.replaceAll('\n', ', '));
                openableController.close();
                listController
                    .close()
                    .then((_) {
                  listController.open();
                });
              },
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
