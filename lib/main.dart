import 'package:flutter/material.dart';
import 'package:technewsfeeder/newslist_screen.dart';

void main() {
  runApp(TechNewsFeeder());
}

class TechNewsFeeder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData.dark().copyWith(
//        textTheme: TextTheme(
//          body1: TextStyle(color: Colors.black54),
//        ),
//      ),
      initialRoute: NewsListScreen.id,
      routes: {
        NewsListScreen.id: (context) => NewsListScreen(),
      },
    );
  }
}