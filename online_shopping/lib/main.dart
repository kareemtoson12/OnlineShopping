import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/core/routing/routes.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/features/login/cubit/login_cubit.dart';
import 'package:online_shopping/firebase_options.dart';
import 'package:online_shopping/online_shopping.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authService = AuthService();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(authService)),
        // BlocProvider(create: (context) => AnotherCubit()),
      ],
      child: OnlineShopping(
        appRouter: AppRoutes(),
      )));
}