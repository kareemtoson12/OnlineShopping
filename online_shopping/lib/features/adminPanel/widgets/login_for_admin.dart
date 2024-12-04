import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

import 'package:online_shopping/features/adminPanel/cubit/admin_login_cubit.dart';

class LoginButtonForAdmin extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButtonForAdmin({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminLoginCubit, AdminLoginState>(
      listener: (context, state) {
        if (state is AdminLoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AdminLoginSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Admin Login Successful')),
          );
          Navigator.pushNamed(context, Routes.forgetPassword);
        } else if (state is AdminLoginError) {
          Navigator.of(context).pop(); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();
            if (_validateFields(context, email, password)) {
              context.read<AdminLoginCubit>().loginAdmin(email, password);
            }
          },
          child: Container(
            width: 190.w,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: CustomsColros.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Login',
                style: AppTextStyles.font30blackTitle.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _validateFields(BuildContext context, String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }
    return true;
  }
}
