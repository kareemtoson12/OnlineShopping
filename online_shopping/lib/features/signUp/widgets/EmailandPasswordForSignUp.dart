import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';

import 'package:online_shopping/core/styles/styles.dart';

import 'package:online_shopping/features/signUp/widgets/signUp_buttton.dart';

class EmailandPasswordForSignUp extends StatefulWidget {
  const EmailandPasswordForSignUp({super.key});

  @override
  State<EmailandPasswordForSignUp> createState() =>
      _EmailandPasswordForSignUpState();
}

class _EmailandPasswordForSignUpState extends State<EmailandPasswordForSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _LastNameController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: CustomsColros.primaryColor,
                    ),
                    labelStyle: AppTextStyles.fontForLabel,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: CustomsColros.gray, width: 1.4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10.w), // Add spacing between the fields
              Expanded(
                child: TextFormField(
                  controller: _LastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: CustomsColros.primaryColor,
                    ),
                    labelStyle: AppTextStyles.fontForLabel,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: CustomsColros.gray, width: 1.4),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              labelText: 'UserName',
              prefixIcon: const Icon(
                Icons.person,
                color: CustomsColros.primaryColor, // Corrected name
              ),
              labelStyle: AppTextStyles.fontForLabel,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4),
                borderRadius: BorderRadius.circular(20.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your userName';
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: _phoneNumberController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.phone,
                color: CustomsColros.primaryColor,
              ),
              labelText: 'PhoneNumber',
              labelStyle: AppTextStyles.fontForLabel,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4),
                borderRadius: BorderRadius.circular(20.0),
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
          SizedBox(height: 20.h),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(
                Icons.email,
                color: CustomsColros.primaryColor, // Corrected name
              ),
              labelStyle: AppTextStyles.fontForLabel,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4),
                borderRadius: BorderRadius.circular(20.0),
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
          SizedBox(height: 20.h),
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
                borderRadius: BorderRadius.circular(20.0),
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
          SizedBox(height: 20.h),

          SizedBox(height: 10.h),
          // Login button
          SignUpButtton(
            emailController: _emailController,
            firstNameController: _firstNameController,
            lastNameController: _LastNameController,
            passwordController: _passwordController,
            phoneNumberController: _phoneNumberController,
            userNameController: _userNameController,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: Text(
                  'Already have an account? Login now !',
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
