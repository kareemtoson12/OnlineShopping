import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

import 'package:online_shopping/features/adminPanel/widgets/login_for_admin.dart';

class EmailAndPasswordForAdmin extends StatefulWidget {
  const EmailAndPasswordForAdmin({super.key});

  @override
  State<EmailAndPasswordForAdmin> createState() =>
      _EmailAndPasswordForAdminState();
}

class _EmailAndPasswordForAdminState extends State<EmailAndPasswordForAdmin> {
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
              labelText: 'Admin Email',
              prefixIcon:
                  const Icon(Icons.email, color: CustomsColros.primaryColor),
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
              labelText: 'Admin Password',
              prefixIcon:
                  const Icon(Icons.lock, color: CustomsColros.primaryColor),
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
          SizedBox(height: 30.h),
          LoginButtonForAdmin(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ],
      ),
    );
  }
}
