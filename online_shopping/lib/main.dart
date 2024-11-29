import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:online_shopping/core/routing/routes.dart';
import 'package:online_shopping/firebase_options.dart';
import 'package:online_shopping/online_shopping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(OnlineShopping(
    appRouter: AppRoutes(),
  ));
}
