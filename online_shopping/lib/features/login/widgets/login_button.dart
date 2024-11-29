import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your login logic here
        print("Login button tapped");
      },
      child: Container(
        width: 190.w, // Full width
        padding: EdgeInsets.symmetric(vertical: 15.h), // Vertical padding
        decoration: BoxDecoration(
          color: CustomsColros.primaryColor, // Button color
          borderRadius: BorderRadius.circular(15.r), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, // Shadow color
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Text('Login',
              style: AppTextStyles.font30blackTitle.copyWith(
                fontSize: 20.sp,
              )),
        ),
      ),
    );
  }
}
