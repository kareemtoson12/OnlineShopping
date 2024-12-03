import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/forgetPassword/cubit/forget_password_cubit.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Text(
          'Forget Password',
          style: AppTextStyles.font30blackTitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 38.0.dg, horizontal: 10.dg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your email, and we will send you a password reset link.',
                  style: AppTextStyles.font18gray,
                ),
                SizedBox(height: 20.h),
                Form(
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
                            borderSide: const BorderSide(
                              color: CustomsColros.gray,
                              width: 1.4,
                            ),
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
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      // Button with Cubit Integration
                      BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                        listener: (context, state) {
                          if (state is ForgetPasswordSucess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password reset link sent successfully!')),
                            );
                          } else if (state is ForgetPasswordError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ForgetPasswordLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                final email = _emailController.text.trim();
                                context
                                    .read<ForgetPasswordCubit>()
                                    .sendPasswordResetEmail(email);
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
                                  'Submit',
                                  style: AppTextStyles.font30blackTitle
                                      .copyWith(fontSize: 20.sp),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
