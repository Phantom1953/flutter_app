import 'package:flutter/material.dart';

class HolidayTheme {
  final String holidayName;
  final Color backgroundColor;
  final Color appBarColor;
  final Color textColor;
  final Color iconColor;
  final Color panelColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final IconData icon;
  final String appBarTitle;

  HolidayTheme({
    required this.holidayName,
    required this.backgroundColor,
    required this.appBarColor,
    required this.textColor,
    required this.iconColor,
    required this.panelColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.icon,
    required this.appBarTitle,
  });

  factory HolidayTheme.defaultTheme() {
    return HolidayTheme(
      holidayName: 'Текущие праздники',
      backgroundColor: Colors.grey[200]!,
      appBarColor: Colors.blue,
      textColor: Colors.black,
      iconColor: Colors.blue,
      panelColor: Colors.white,
      buttonColor: Colors.blue,
      buttonTextColor: Colors.white,
      icon: Icons.calendar_today,
      appBarTitle: 'Праздничное приложение',
    );
  }
}

class HolidayThemes {
  static final Map<HolidayChecker, HolidayTheme Function()> _holidayThemes = {
    _isNewYear: _newYearTheme,
    _isVictoryDay: _victoryDayTheme,
    _isRussiaDay: _russiaDayTheme,
  };

  static bool _isNewYear(DateTime date) {
    return date.month == 12 && date.day >= 25 && date.day <= 31;
  }

  static bool _isVictoryDay(DateTime date) {
    return date.month == 5 && date.day == 9;
  }

  static bool _isRussiaDay(DateTime date) {
    return date.month == 6 && date.day == 12;
  }

  static HolidayTheme _newYearTheme() {
    return HolidayTheme(
      holidayName: 'С Новым Годом!',
      backgroundColor: Colors.green[50]!,
      appBarColor: Colors.red,
      textColor: Colors.red[900]!,
      iconColor: Colors.yellow[700]!,
      panelColor: Colors.blue[50]!,
      buttonColor: Colors.red,
      buttonTextColor: Colors.white,
      icon: Icons.ac_unit,
      appBarTitle: 'Новогоднее приложение',
    );
  }

  static HolidayTheme _victoryDayTheme() {
    return HolidayTheme(
      holidayName: 'День Победы - 9 Мая',
      backgroundColor: Colors.orange[50]!,
      appBarColor: const Color(0xFFD50000),
      textColor: const Color(0xFF212121),
      iconColor: const Color(0xFFD50000),
      panelColor: Colors.orange[100]!,
      buttonColor: const Color(0xFFD50000),
      buttonTextColor: Colors.white,
      icon: Icons.star,
      appBarTitle: 'День Победы',
    );
  }

  static HolidayTheme _russiaDayTheme() {
    return HolidayTheme(
      holidayName: 'День России',
      backgroundColor: Colors.blue[50]!,
      appBarColor: const Color(0xFF0039A6),
      textColor: const Color(0xFFD52B1E),
      iconColor: const Color(0xFFD52B1E),
      panelColor: Colors.white,
      buttonColor: const Color(0xFF0039A6),
      buttonTextColor: Colors.white,
      icon: Icons.flag,
      appBarTitle: 'День России',
    );
  }

  static Future<HolidayTheme> getThemeForDateAsync(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 50));

    for (final entry in _holidayThemes.entries) {
      if (entry.key(date)) {
        return entry.value();
      }
    }

    return HolidayTheme.defaultTheme();
  }
}

typedef HolidayChecker = bool Function(DateTime date);