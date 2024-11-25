import 'package:flutter/material.dart';

import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/features/onboarding/view.dart';
import 'package:online_shopping/features/splash/screen.dart';

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
    return null;
  }
}
