import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/login/widgets/email_and_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.white,
      appBar: AppBar(
        toolbarHeight: 100.0.dg,
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.adminPanel);
              },
              child: Text(
                'Login ',
                style: AppTextStyles.font30blackTitle,
              ),
            ),
            Text(
              'Hi! welcom again have fun ',
              style: AppTextStyles.font25blacSubTitle,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                EmailAndPassword()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
