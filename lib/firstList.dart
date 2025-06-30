import 'package:flutter/material.dart';
import 'auth_panel.dart';
import 'holiday_themes.dart';

class FirstListScreen extends StatefulWidget {
  const FirstListScreen({super.key});

  @override
  State<FirstListScreen> createState() => _FirstListScreenState();
}

class _FirstListScreenState extends State<FirstListScreen> {
  final AuthPanelController _authPanelController = AuthPanelController();
  bool _isAuthenticated = false;
  String _username = '';
  HolidayTheme _currentTheme = HolidayTheme.defaultTheme();

  @override
  void initState() {
    super.initState();
    _checkHoliday();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authPanelController.open();
    });
  }

  void _checkHoliday() {
    final now = DateTime.now();
    final theme = HolidayThemes.getThemeForDate(now);
    setState(() {
      _currentTheme = theme;
    });
  }

  void _onLoginSuccess(String username) {
    setState(() {
      _isAuthenticated = true;
      _username = username;
    });
    _authPanelController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentTheme.backgroundColor,
      appBar: AppBar(
        title: Text(_currentTheme.appBarTitle),
        backgroundColor: _currentTheme.appBarColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isAuthenticated)
                  Text(
                    'Добро пожаловать, $_username!',
                    style: TextStyle(
                      fontSize: 24,
                      color: _currentTheme.textColor,
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  _currentTheme.holidayName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _currentTheme.textColor,
                  ),
                ),
                const SizedBox(height: 20),
                Icon(
                  _currentTheme.icon,
                  size: 100,
                  color: _currentTheme.iconColor,
                ),
              ],
            ),
          ),
          AuthPanel(
            controller: _authPanelController,
            onLoginSuccess: _onLoginSuccess,
            theme: _currentTheme,
          ),
        ],
      ),
    );
  }
}