import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_assessment/views/screens/home_screen.dart';
import 'package:flutter_assessment/views/screens/login_screen.dart';
import 'package:flutter_assessment/views/screens/register_screen.dart';

const String HomeRoute = '/home';
const String LoginRoute = '/login';
const String RegisterRoute = '/register';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return GetRoute(
          page: LoginScreen(),
          settings: settings,
        );
      case LoginRoute:
        return GetRoute(settings: settings, page: LoginScreen());
      case RegisterRoute:
        return GetRoute(settings: settings, page: RegisterScreen());
      case HomeRoute:
        return GetRoute(
          settings: settings,
          page: HomeScreen(),
        );

      default:
        return GetRoute(
            settings: settings,
            page: Scaffold(
              appBar: AppBar(),
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
