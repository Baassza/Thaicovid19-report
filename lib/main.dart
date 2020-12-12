
import 'package:covit19_report/page/page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      home: Today(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
      
    );
  }
}

