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
      home: FutureBuilder<HolidayTheme>(
        future: HolidayThemes.getThemeForDateAsync(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FirstListScreen(initialTheme: snapshot.data!);
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}