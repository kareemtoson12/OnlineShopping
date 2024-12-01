import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/home/widgets/catigores.dart';
import 'package:online_shopping/features/home/widgets/popular_catigores.dart';
import 'package:online_shopping/features/home/widgets/search_bar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(270.h),
        child: AppBar(
          backgroundColor: CustomsColros.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar Added Here
                searchWidget(),
                SizedBox(height: 10.h),
                Text(
                  'Popular Categories',
                  style: AppTextStyles.font25blackRegular
                      .copyWith(fontSize: 28.dg),
                ),
                SizedBox(height: 01.h),
                CategoriesScreen()
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.dg,
              ),
              //sale off
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset('assets/saleOff.png'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: AppTextStyles.font25blackRegular,
                  ),
                  TextButton(
                    child: Text(
                      'view all',
                      style: AppTextStyles.font18gray,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              //popular products
              ProductGridView(),
            ],
          ),
        ),
      )),
    );
  }
}
