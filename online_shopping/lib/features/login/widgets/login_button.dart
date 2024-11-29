import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

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
    return GestureDetector(
      onTap: () async {
        // Show a loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        try {
          // Get email and password
          String email = emailController.text.trim();
          String password = passwordController.text.trim();

          // Validate inputs
          if (email.isEmpty || password.isEmpty) {
            throw Exception('Please fill in all fields');
          }
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
            throw Exception('Please enter a valid email address');
          }

          // Call login function
          await AuthService().signInWithEmailandPassword(email, password);

          // Dismiss the loading dialog
          Navigator.of(context).pop();

          // Show success message or navigate
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );
          Navigator.pushReplacementNamed(context, Routes.home);
        } on FirebaseAuthException catch (e) {
          // Handle Firebase-specific errors
          Navigator.of(context).pop(); // Close the loading dialog

          String errorMessage;
          switch (e.code) {
            case 'user-not-found':
              errorMessage = 'No user found for this email.';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'invalid-email':
              errorMessage = 'Invalid email address. Please check your input.';
              break;
            default:
              errorMessage = 'An error occurred. Please try again later.';
          }

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        } catch (e) {
          // Handle other exceptions
          Navigator.of(context).pop(); // Close the loading dialog

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
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
  }
}
