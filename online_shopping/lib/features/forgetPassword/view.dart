import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/forgetPassword/cubit/forget_password_cubit.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  // Form key for validating the input form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController to manage the email input field
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg, // Dynamic height for responsiveness
        leading: IconButton(
          onPressed: () {
            // Navigate back to the login screen
            Navigator.pushReplacementNamed(context, Routes.login);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white, // White color for visibility
            size: 30, // Large size for better accessibility
          ),
        ),
        centerTitle: true, // Centers the title in the AppBar
        backgroundColor: CustomsColros.primaryColor, // Custom primary color
        title: Text(
          'Forget Password',
          style: AppTextStyles.font30blackTitle, // Custom title style
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 38.0.dg, horizontal: 10.dg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructional text for users
                Text(
                  'Enter your email, and we will send you a password reset link.',
                  style: AppTextStyles.font18gray, // Custom text style
                ),
                SizedBox(height: 20.h), // Vertical spacing
                Form(
                  key: _formKey, // Link the form with the validator
                  child: Column(
                    children: [
                      // Email input field with validation
                      TextFormField(
                        controller: _emailController, // Controller for input management
                        decoration: InputDecoration(
                          labelText: 'Email', // Input field label
                          prefixIcon: const Icon(
                            Icons.email, // Email icon for clarity
                            color: CustomsColros.primaryColor,
                          ),
                          labelStyle: AppTextStyles.fontForLabel, // Custom label style
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: CustomsColros.gray, // Border color
                              width: 1.4, // Border width
                            ),
                            borderRadius: BorderRadius.circular(20.0), // Rounded border
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r), // Dynamic rounding
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress, // Email-specific keyboard
                        validator: (value) {
                          // Validation for email input
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'; // Error for empty field
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address'; // Error for invalid format
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h), // Vertical spacing
                      // BlocConsumer for handling state changes in ForgetPasswordCubit
                      BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                        listener: (context, state) {
                          if (state is ForgetPasswordSucess) {
                            // Display success message if email is sent successfully
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password reset link sent successfully!')),
                            );
                          } else if (state is ForgetPasswordError) {
                            // Display error message if an error occurs
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ForgetPasswordLoading) {
                            // Show loading indicator while processing
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              // Validate form and initiate password reset
                              if (_formKey.currentState?.validate() ?? false) {
                                final email = _emailController.text.trim(); // Trim leading/trailing spaces
                                context
                                    .read<ForgetPasswordCubit>()
                                    .sendPasswordResetEmail(email); // Trigger Cubit method
                              }
                            },
                            child: Container(
                              width: 190.w, // Responsive width for the button
                              padding: EdgeInsets.symmetric(vertical: 15.h), // Padding for better UX
                              decoration: BoxDecoration(
                                color: CustomsColros.primaryColor, // Button color
                                borderRadius: BorderRadius.circular(15.r), // Rounded corners
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26, // Shadow color
                                    blurRadius: 5, // Shadow blur effect
                                    offset: Offset(0, 3), // Shadow offset
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Submit', // Button text
                                  style: AppTextStyles.font30blackTitle
                                      .copyWith(fontSize: 20.sp), // Custom button style
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
