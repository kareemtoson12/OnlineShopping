import 'package:flutter/material.dart';

import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/services/auth_gate.dart';
import 'package:online_shopping/features/forgetPassword/view.dart';
import 'package:online_shopping/features/home/view.dart';
import 'package:online_shopping/features/login/view.dart';
import 'package:online_shopping/features/onboarding/view.dart';
import 'package:online_shopping/features/splash/view.dart';

class AppRoutes {
  Route? gnerateRoute(RouteSettings screen) {
    switch (screen.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
    switch (screen.name) {
      case Routes.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
    }
    switch (screen.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
    switch (screen.name) {
      case Routes.userCheacking:
        return MaterialPageRoute(builder: (context) => const AuthGate());
    }
    switch (screen.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const Homescreen());
    }
    switch (screen.name) {
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
    }
    return null;
  }
}
