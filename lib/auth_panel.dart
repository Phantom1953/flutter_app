import 'package:flutter/material.dart';
import 'holiday_themes.dart';

class AuthPanelController extends ChangeNotifier {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void open() {
    _isOpen = true;
    notifyListeners();
  }

  void close() {
    _isOpen = false;
    notifyListeners();
  }
}

class AuthPanel extends StatelessWidget {
  final AuthPanelController controller;
  final Function(String) onLoginSuccess;
  final HolidayTheme theme;

  const AuthPanel({
    super.key,
    required this.controller,
    required this.onLoginSuccess,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: controller.isOpen ? 0 : -MediaQuery.of(context).size.height * 0.5,
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 5) {
            controller.close();
          } else if (details.primaryDelta! < -5) {
            controller.open();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.panelColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Вход в приложение',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  onLoginSuccess('Пользователь');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.buttonColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Войти',
                  style: TextStyle(
                    color: theme.buttonTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}