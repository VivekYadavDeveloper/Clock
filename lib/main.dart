import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timer/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clock',
          theme: ThemeData.light(),
          home: MyHomePage(),
        );
      },
    );
  }
}
