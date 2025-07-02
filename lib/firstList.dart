import 'package:flutter/material.dart';
import 'auth_panel.dart';
import 'holiday_themes.dart';

class FirstListScreen extends StatefulWidget {
  const FirstListScreen({super.key});

  @override
  State<FirstListScreen> createState() => _FirstListScreenState();
}

class _FirstListScreenState extends State<FirstListScreen> {
  late AuthPanelController _authPanelController;
  late bool _isAuthenticated;
  late String _username;
  late HolidayTheme _currentTheme;
  bool _isThemeLoaded = false;

  @override
  void initState() {
    super.initState();
    _authPanelController = AuthPanelController();
    _isAuthenticated = false;
    _username = '';
    _currentTheme = HolidayTheme.defaultTheme();

    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final theme = await HolidayThemes.getThemeForDateAsync(DateTime.now());
    setState(() {
      _currentTheme = theme;
      _isThemeLoaded = true;
    });
    _authPanelController.open();
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
    if (!_isThemeLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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