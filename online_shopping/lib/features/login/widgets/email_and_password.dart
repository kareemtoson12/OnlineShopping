import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/login/widgets/login_button.dart';

// Stateful widget for email and password login form
class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  // Global key for the form to enable validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to manage email and password input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Associating the form key for validation
      child: Column(
        children: [
          // Email input field
          TextFormField(
            controller: _emailController, // Controller for email input
            decoration: InputDecoration(
              labelText: 'Email', // Label for the input field
              prefixIcon: const Icon(
                Icons.email,
                color: CustomsColros.primaryColor, // Custom primary color
              ),
              labelStyle: AppTextStyles.fontForLabel, // Custom font style
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4), // Border styling
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r), // Adaptable border radius
              ),
            ),
            keyboardType: TextInputType.emailAddress, // Email input type
            validator: (value) {
              // Validation logic for email
              if (value == null || value.isEmpty) {
                return 'Please enter your email'; // Error message for empty email
              }
              return null; // Input is valid
            },
          ),
          SizedBox(
            height: 50.h, // Vertical spacing
          ),
          // Password input field
          TextFormField(
            controller: _passwordController, // Controller for password input
            obscureText: true, // Hides text for password input
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock,
                color: CustomsColros.primaryColor, // Custom primary color
              ),
              labelText: 'Password', // Label for the input field
              labelStyle: AppTextStyles.fontForLabel, // Custom font style
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: CustomsColros.gray, width: 1.4), // Border styling
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
              ),
            ),
            validator: (value) {
              // Validation logic for password
              if (value == null || value.isEmpty) {
                return 'Please enter your password'; // Error for empty password
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long'; // Error for short password
              }
              return null; // Input is valid
            },
          ),
          SizedBox(
            height: 50.h, // Vertical spacing
          ),
          // "Forgot Password?" link
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align to the right
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to forgot password page
                  Navigator.pushReplacementNamed(
                      context, Routes.forgetPassword);
                },
                child: Text(
                  'Forgot Password?', // Text for the link
                  style: AppTextStyles.fontForLabel, // Custom font style
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h, // Vertical spacing
          ),
          // Login button
          LoginButton(
            emailController: _emailController, // Pass email controller
            passwordController: _passwordController, // Pass password controller
          ),
          SizedBox(
            height: 10.h, // Vertical spacing
          ),
          // "Sign Up" link
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center alignment
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to sign-up page
                  Navigator.pushReplacementNamed(context, Routes.signUp);
                },
                child: Text(
                  'Don’t have an account? Signup', // Text for the link
                  style: AppTextStyles.fontForLabel, // Custom font style
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
