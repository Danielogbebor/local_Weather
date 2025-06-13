import 'package:flutter/material.dart';
import 'package:local_eather/pages/homepage.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Weather App',
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}