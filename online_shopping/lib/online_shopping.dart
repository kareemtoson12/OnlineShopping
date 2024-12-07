import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/routing/routes.dart';

class OnlineShopping extends StatelessWidget {
  final AppRoutes appRouter;
  const OnlineShopping({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online shopping',
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splash,
      ),
    );
  }
}
