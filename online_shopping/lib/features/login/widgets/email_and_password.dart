import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/login/widgets/login_button.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(
                Icons.email,
                color: CustomsColros.primaryColor,
              ),
              labelStyle: AppTextStyles.fontForLabel,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4),
                borderRadius: BorderRadius.circular(20.0), // Rounded border
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }

              return null;
            },
          ),
          SizedBox(
            height: 50.h,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock,
                color: CustomsColros.primaryColor,
              ),
              labelText: 'Password',
              labelStyle: AppTextStyles.fontForLabel,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4),
                borderRadius: BorderRadius.circular(20.0), // Rounded border
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(
            height: 50.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.forgetPassword);
                },
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.fontForLabel,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          //login button
          LoginButton(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.home);
                },
                child: Text(
                  'Don’t haven an account ? Signup',
                  style: AppTextStyles.fontForLabel,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
