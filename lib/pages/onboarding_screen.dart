import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendingfood_flutter/pages/onloading_pages/page_dragger.dart';
import 'package:trendingfood_flutter/pages/onloading_pages/page_reveal.dart';
import 'package:trendingfood_flutter/pages/onloading_pages/pager_indicator.dart';
import 'package:trendingfood_flutter/pages/onloading_pages/pages.dart';
import 'package:trendingfood_flutter/pages/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  AnimationController animationController;
  Animation<double> _scaleAnim;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  bool lastPage = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _scaleAnim = Tween(begin: 0.2,end: 1.0).animate(animationController);
    setIsFirstOpen();
  }

  setIsFirstOpen() async {
//    SharedPreferences storage = await SharedPreferences.getInstance();
    Future<SharedPreferences> storage = SharedPreferences.getInstance();
    final SharedPreferences prefs  = await storage;
    await prefs.setBool("isOpen", false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }

  _MyHomePageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          print('Sliding ${event.direction} at ${event.slidePercent}');
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }

        } else if (event.updateType == UpdateType.doneDragging) {
          print('Done dragging.');
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
          if(nextPageIndex == 4){
            this.lastPage = true;
            animationController.forward();
          }else{
            this.lastPage = false;
          }

        } else if (event.updateType == UpdateType.animating) {
          print('Sliding ${event.direction} at ${event.slidePercent}');
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          print('Done animating. Next page index: $nextPageIndex');
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }


      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        // Create the SelectionButton widget in the next step.
        children: [
          new myPage(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new myPage(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
          Positioned(
            right: 15.0,
            bottom: 15.0,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: lastPage? FloatingActionButton(
                backgroundColor: Colors.deepOrange.shade500,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ): Container(
                width: 150.0,
                height: 150.0,

              ),
            ),
          ),

        ],
      ),
    );
  }
}