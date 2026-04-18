import 'package:flutter/material.dart';
import 'package:monitor_ambiente/screens/home_screen.dart';
import 'package:monitor_ambiente/screens/login_Screen.dart';
import 'package:monitor_ambiente/screens/profile_screen.dart';

import '../screens/splash_screen.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String loginScreen = '/login';
  static const String profileScreen = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default: return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('Nenhuma rota definida para ${settings.name}'),
          ),
        ),
      );
    }
  }
}