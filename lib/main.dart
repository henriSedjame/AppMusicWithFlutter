import 'package:app_music/views/home/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange
      ),
      home: HomePage('MUSIC APP'),
      debugShowCheckedModeBanner: false
    );
  }
}
