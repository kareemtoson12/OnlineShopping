import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': 'assets/electronics.png', 'title': 'Electronics'},
    {'icon': 'assets/dress.png', 'title': 'Clothes'},
    {'icon': 'assets/handyman.png', 'title': 'Furniture'},
    {'icon': 'assets/sneakers.png', 'title': 'Shoes'},
  ];

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h, // Adjust height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${category['title']}')),
              );
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomsColros.white,
                      borderRadius: BorderRadius.circular(75.dg)),
                  margin: EdgeInsets.symmetric(horizontal: 9.w),
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  width: 70.w, // Adjust width of each item
                  child: Image.asset(
                    category['icon'],
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(category['title'],
                    style: AppTextStyles.fontForLabel
                        .copyWith(color: Colors.white)),
              ],
            ),
          );
        },
      ),
    );
  }
}
