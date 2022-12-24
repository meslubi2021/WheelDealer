import 'package:bar2_banzeen/screens/login_screen.dart';
import 'package:bar2_banzeen/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    var routes = <String, WidgetBuilder>{
      LoginScreen.routeName: (context) => const LoginScreen(),
      SignupScreen.routeName: (context) => const SignupScreen(),
    };
    WidgetBuilder builder =
        routes[settings.name] ?? (context) => const LoginScreen();
    return MaterialPageRoute(builder: (ctx) => builder(ctx));
  }
}
