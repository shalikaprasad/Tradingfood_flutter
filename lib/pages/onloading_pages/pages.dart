import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/data/assets.dart';

final pages = [
  new PageViewModel(
      const Color(0xFF678FB4),
      farmer1,
      'ගොවියන්',
      'ගොවියන්ගේ අස්වනු සදහා සාධරණ මිලක් ලබා දී, සාධාරණ වෙළඳකරුවන් පහසුවෙන් සොයාගැනීමටත්, ඇණවුම වලට අනුව වගා කිරීමට හැකි වීමත්, ඔබගේ වගා ගැටලු සඳහා ඉක්මන් විසදුම් ලබා ගැනීමටත්, සහා ඔබ අවට සිටිනා වෙළඳකරුවන් පහසුවෙන් සොයාගැනීමටත් මෙය උපකාරී වේ.',
      'assets/key.png'
  ),
  new PageViewModel(
      const Color(0xFF65B0B4),
      market1,
      'වෙළඳකරුවන්',
      'වෙළඳකරුවන්ගේ අස්වනු සදහා සාධරණ මිලක් ලබා දී,පාරිභෝගිකයන් පහසුවෙන් සොයාගැනීමටත්, ඇණවුම් වලට අනුව අස්වනු මීලදී ගැනීමට හැකි වීමත්, ඔබගේ වෙළඳ ගැටලු සඳහා ඉක්මන් විසදුම් ලබා ගැනීමටත්, සහ ඔබ අවට සිටිනා පාරිභෝගිකයන් පහසුවෙන් සොයාගැනීමටත් මෙය උපකාරී වේ. ',
      'assets/wallet.png'
  ),
  new PageViewModel(
    const Color(0xFF9B90BC),
    buyer1,
    'පාරිභෝගිකයන්',
    'පාරිභෝගිකයන්ට අස්වනු සදහා සාධරණ මිලක් ලබා දී, සාධාරණ වෙළඳකරුවන් පහසුවෙන් සොයාගැනීමටත්, ඇණවුම් කිරීමට හැකි වීමත්, ඔබගේ ගැටලු සඳහා ඉක්මන් විසදුම් ලබා ගැනීමටත්, සහ ඔබ අවට සිටිනා වෙළඳකරුවන් පහසුවෙන් සොයාගැනීමටත් මෙය උපකාරී වේ. ',
    'assets/shopping_cart.png',
  ),
  new PageViewModel(
    Colors.green,
    transporter1,
    'ප්‍රවාහකයා',
    'නියෝජිතයන්, වෙළඳකරුවන් හා ගොවියන් ලබා දෙන අස්වනු ඉතා ඉක්මනින් හා විස්වාසයකින් අදාල පාර්ශවයන් වෙත දෙමින් ඉහල ලාබයක් උපයා ගැනීමටත්, ඇණවුම් පහසුවෙන් ලබා ගැනීමට හැකි වීමත්, ඔබගේ ගැටලු සඳහා ඉක්මන් විසදුම් ලබා ගැනීමටත්, සහ ඔබ අවට සිටිනා වෙළඳකරුවන් පහසුවෙන් සොයාගැනීමටත් මෙය උපකාරී වේ. ',
    truck,
  ),
  new PageViewModel(
    const Color(0xFF678FB4),
    representator1,
    'නියෝජිත',
    'පාරිභෝගිකයන් හා වෙළඳකරුවන් සොයා අස්වනු නියමිත කාලයට, නියමිත ස්ථානයට ලබා දී ලාබ ලැබීමට මේ හරහා හැකියාව ලැබේ. ගොවියන් සදහා සාධරණ මිලක් ලබා දී සාධාරණ වෙළඳකරුවන් සොයා ඔවුන් වෙත ඇණවුම් ලබා රටටත්, තමන්ටත් ලාබයක් ලබා ගැනීමට මෙය උපකාරී වේ. ',
    call,
  ),
];

class myPage extends StatelessWidget {

  final PageViewModel viewModel;
  final double percentVisible;

  myPage({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset(
                        viewModel.heroAssetPath,
                        width: 200.0,
                        height: 200.0
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      viewModel.title,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'FlamanteRoma',
                        fontSize: 34.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 75.0),
                    child: new Text(
                      viewModel.body,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
      this.color,
      this.heroAssetPath,
      this.title,
      this.body,
      this.iconAssetPath,
      );
}