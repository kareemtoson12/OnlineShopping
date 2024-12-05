import 'package:flutter/material.dart';

import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/services/auth_gate.dart';
import 'package:online_shopping/features/adminPanel/addProducts/view.dart';
import 'package:online_shopping/features/adminPanel/deleteProducts/view.dart';
import 'package:online_shopping/features/adminPanel/editProducts/view.dart';
import 'package:online_shopping/features/adminPanel/login/view.dart';
import 'package:online_shopping/features/forgetPassword/view.dart';
import 'package:online_shopping/features/home/view.dart';
import 'package:online_shopping/features/login/view.dart';
import 'package:online_shopping/features/naivBar/view.dart';
import 'package:online_shopping/features/onboarding/view.dart';
import 'package:online_shopping/features/product/view.dart';
import 'package:online_shopping/features/profile/view.dart';
import 'package:online_shopping/features/signUp/view.dart';
import 'package:online_shopping/features/splash/view.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings screen) {
    switch (screen.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.userCheacking:
        return MaterialPageRoute(builder: (context) => const AuthGate());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const Homescreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case Routes.customNaivBar:
        return MaterialPageRoute(builder: (context) => CustomNavBar());
      case Routes.signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => Profile());
      case Routes.cart:
        return MaterialPageRoute(builder: (context) => Profile());
      case Routes.productInfo:
        return MaterialPageRoute(
            builder: (context) => ProductInformationScreen());
      case Routes.adminPanel:
        return MaterialPageRoute(builder: (context) => AdminPanel());
      case Routes.addProducts:
        return MaterialPageRoute(builder: (context) => AddProducts());
      case Routes.deleteProduct:
        return MaterialPageRoute(builder: (context) => DeleteProductScreen());
      case Routes.editProduct:
        return MaterialPageRoute(builder: (context) => EditProductScreen());
      default:
        return null; // Handle unknown routes
    }
  }
}
