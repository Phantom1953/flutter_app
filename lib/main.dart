import 'package:flutter/material.dart';
import 'firstList.dart';
import 'holiday_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Праздничное приложение',
      debugShowCheckedModeBanner: false,
      home: const FirstListScreen(),
    );
  }
}