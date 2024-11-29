import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

import '../cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pop(); // Close the loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is LoginError) {
          Navigator.of(context).pop(); // Close the loading dialog
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
            if (email.isNotEmpty && password.isNotEmpty) {
              context.read<LoginCubit>().login(email, password);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in all fields')),
              );
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
}
