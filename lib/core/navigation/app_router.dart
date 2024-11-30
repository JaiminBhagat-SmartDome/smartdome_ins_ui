import 'package:flutter/material.dart';
import '/app/main_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}
