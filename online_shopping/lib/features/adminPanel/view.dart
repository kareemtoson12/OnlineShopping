import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/adminPanel/widgets/email_password_for_admin.dart';
import 'package:online_shopping/features/login/widgets/email_and_password.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

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
              'Admin Panel ',
              style: AppTextStyles.font30blackTitle,
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
                EmailAndPasswordForAdmin()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
