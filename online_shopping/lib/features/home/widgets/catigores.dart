import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/categoryProduct/view.dart';
import 'package:online_shopping/features/home/cubit/home_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeCubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeCategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeCategoriesSuccess) {
          final categories = state.categories;

          return SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    /*   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on ${category.name}')),
                    ); */
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsScreen(
                            category: category.name,
                          ),
                        ));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: CustomsColros.white,
                          borderRadius: BorderRadius.circular(75.r),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 9.w),
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Image.network(
                          category.image,
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        category.name,
                        style: AppTextStyles.fontForLabel
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeCategoriesError) {
          return Center(
            child: Text(
              'Failed to load categories: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text('No categories to display.'),
          );
        }
      },
    );
  }
}

final List<Map<String, dynamic>> dummyProducts = [
  {
    "name": "Smartphone",
    "category": "Electronics",
    "price": 599, // Use int instead of double
    "description": "A high-performance smartphone with 128GB storage.",
    "stock": 20,
  },
  {
    "name": "Laptop",
    "category": "Electronics",
    "price": 999, // Use int instead of double
    "description": "A lightweight laptop with a 15-inch display.",
    "stock": 15,
  },
];
