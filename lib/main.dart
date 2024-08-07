import 'package:flutter/material.dart';
import 'package:reels/module.dart';
import 'package:reels/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reels Viewer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreLoad(),
    );
  }
}
