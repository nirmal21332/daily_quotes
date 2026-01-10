import 'package:daily_quoates/utils/routes_name.dart';
import 'package:daily_quoates/view/auth_screens/forgot_pass.dart';
import 'package:daily_quoates/view/auth_screens/signup_screen.dart';
import 'package:daily_quoates/view/screens/home_screen.dart';
import 'package:daily_quoates/view/auth_screens/login_screen.dart';
import 'package:daily_quoates/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignupScreen());

      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgotPass());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    return MaterialPageRoute(builder: (context) => const SplashScreen());
  }
}
