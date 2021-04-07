import 'package:flutter/material.dart';
import 'package:flutter_standard_app/routing/routes.dart';
import 'package:flutter_standard_app/screens/home_screen/home_screen.dart';
import 'package:flutter_standard_app/screens/login_screen/login_screen.dart';
import 'package:flutter_standard_app/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  GetPageRoute onGenerateRoute(RouteSettings setting) {
    final uri = Uri.parse(setting.name!);
    final param = uri.queryParameters;
    GetPageRoute page({required Widget child}) {
      return GetPageRoute(
          settings: setting, page: () => child, transition: Transition.fadeIn);
    }

    switch (uri.path) {
      case AppRoutes.login:
        return page(child: LoginScreen.newInstance());
      case AppRoutes.home:
        return page(child: HomeScreen());
      case AppRoutes.splashScreen:
        return page(child: SplashScreen());
      default:
        return page(child: SplashScreen());
    }
  }

  AppPages._();

  static AppPages instance = AppPages._();
}
