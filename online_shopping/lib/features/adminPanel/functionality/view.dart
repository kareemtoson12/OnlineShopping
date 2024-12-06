import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class Adminfunctionality extends StatelessWidget {
  const Adminfunctionality({super.key});

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
          'Admin functionalities',
          style: AppTextStyles.font30blackTitle.copyWith(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                routsFunctions('Add Products', context, Routes.addProducts),
                SizedBox(
                  height: 15.h,
                ),
                routsFunctions('Edit Products', context, Routes.editProduct),
                SizedBox(
                  height: 15.h,
                ),
                routsFunctions(
                    'delete Products', context, Routes.deleteProduct),
                SizedBox(
                  height: 50.h,
                ),
                routsFunctions('Add Category', context, Routes.addCategory),
                SizedBox(
                  height: 15.h,
                ),
                routsFunctions('Edit Category', context, Routes.editCategory),
                SizedBox(
                  height: 15.h,
                ),
                routsFunctions(
                    'delete Category', context, Routes.deleteCategory),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector routsFunctions(String name, context, rout) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, rout);
      },
      child: Container(
        width: 300.w,
        height: 70.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomsColros.primaryColor),
        child: Center(
          child: Text(
            name,
            style: AppTextStyles.font25blod,
          ),
        ),
      ),
    );
  }
}
