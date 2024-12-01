import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/features/signUp/widgets/EmailandPasswordForSignUp.dart';

import '../../core/styles/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColros.white,
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Column(
          children: [
            Text(
              'Sign Up',
              style: AppTextStyles.font30blackTitle,
            ),
            Text(
              'Hi! create new account ',
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
                  height: 20.h,
                ),
                EmailandPasswordForSignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
