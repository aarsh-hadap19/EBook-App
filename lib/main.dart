import 'package:flutter/material.dart';

import 'Home_Page.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Audio Reading",
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
