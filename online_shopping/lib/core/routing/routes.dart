import 'package:flutter/material.dart';

import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/services/auth_gate.dart';
import 'package:online_shopping/features/adminPanel/bestSelling/view.dart';
import 'package:online_shopping/features/adminPanel/categories/addCategories/view.dart';
import 'package:online_shopping/features/adminPanel/categories/deleteCategories/view.dart';
import 'package:online_shopping/features/adminPanel/categories/editCategories/view.dart';
import 'package:online_shopping/features/adminPanel/products/addProducts/view.dart';
import 'package:online_shopping/features/adminPanel/products/deleteProducts/view.dart';
import 'package:online_shopping/features/adminPanel/products/editProducts/view.dart';
import 'package:online_shopping/features/adminPanel/functionality/view.dart';
import 'package:online_shopping/features/adminPanel/login/view.dart';
import 'package:online_shopping/features/adminPanel/report/view.dart';
import 'package:online_shopping/features/forgetPassword/view.dart';
import 'package:online_shopping/features/home/view.dart';
import 'package:online_shopping/features/login/view.dart';
import 'package:online_shopping/features/naivBar/view.dart';
import 'package:online_shopping/features/onboarding/view.dart';
import 'package:online_shopping/features/product/ProductDetails.dart';
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
            builder: (context) => ProductDetails(
                  data: dummyData,
                ));
      case Routes.adminPanel:
        return MaterialPageRoute(builder: (context) => AdminPanel());
      case Routes.addProducts:
        return MaterialPageRoute(builder: (context) => AddProducts());
      case Routes.deleteProduct:
        return MaterialPageRoute(builder: (context) => DeleteProductScreen());
      case Routes.editProduct:
        return MaterialPageRoute(builder: (context) => EditProductScreen());
      case Routes.adminfunctionality:
        return MaterialPageRoute(builder: (context) => Adminfunctionality());
      case Routes.addCategory:
        return MaterialPageRoute(builder: (context) => AddCategoryScreen());
      case Routes.editCategory:
        return MaterialPageRoute(builder: (context) => EditCategoryScreen());
      case Routes.deleteCategory:
        return MaterialPageRoute(builder: (context) => DeleteCategoryScreen());
      case Routes.reportsScreen:
        return MaterialPageRoute(
            builder: (context) => TransactionsReportPage());
      case Routes.bestSellingScreen:
        return MaterialPageRoute(
            builder: (context) => BestSellingProductsChart());
      default:
        return null; // Handle unknown routes
    }
  }
}

Map<String, dynamic> dummyData = {
  'image': 'https://via.placeholder.com/250', // Sample image URL
  'rate': 4.5, // Rating out of 5
  'sale': 20, // Discount percentage
  'name': 'Sample Product', // Product name
  'stock': 15, // Number of items in stock
  'brand': 'Brand X', // Brand name
  'description':
      'This is a sample product description to test the layout.', // Product description
};
