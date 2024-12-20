import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/categoryProduct/view.dart';
import 'package:online_shopping/features/home/cubit/home_cubit.dart';

// Stateless widget for displaying categories
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using BlocBuilder to build UI based on the HomeCubit state
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Show a loading spinner when categories are loading
        if (state is HomeCategoriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Display categories when the loading is successful
        else if (state is HomeCategoriesSuccess) {
          final categories = state.categories; // Fetch categories from state

          return SizedBox(
            height: 120.h, // Set height for the categories container
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: categories.length, // Number of categories
              itemBuilder: (context, index) {
                final category = categories[index]; // Current category item
                return GestureDetector(
                  onTap: () {
                    // Navigate to CategoryProductsScreen on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          category: category.name, // Pass category name
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      // Circle-shaped container for category image
                      Container(
                        height: 70.h, // Height of the container
                        width: 70.w, // Width of the container
                        decoration: BoxDecoration(
                          color: CustomsColros.white, // Background color
                          borderRadius: BorderRadius.circular(75.r), // Circle shape
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 9.w), // Horizontal margin
                        padding: EdgeInsets.symmetric(horizontal: 9.w), // Padding inside
                        child: Image.network(
                          category.image, // Display category image
                          height: 50.h, // Height of the image
                          width: 50.w, // Width of the image
                        ),
                      ),
                      SizedBox(height: 10.h), // Spacing between image and text
                      // Category name text
                      Text(
                        category.name, // Display category name
                        style: AppTextStyles.fontForLabel
                            .copyWith(color: Colors.white), // Custom font with white color
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        // Display an error message if category loading fails
        else if (state is HomeCategoriesError) {
          return Center(
            child: Text(
              'Failed to load categories: ${state.errorMessage}', // Display error message
              style: const TextStyle(color: Colors.red), // Red color for error text
            ),
          );
        }
        // Default message for no categories
        else {
          return const Center(
            child: Text('No categories to display.'),
          );
        }
      },
    );
  }
}

// Dummy product data for testing purposes
final List<Map<String, dynamic>> dummyProducts = [
  {
    "name": "Smartphone", // Product name
    "category": "Electronics", // Product category
    "price": 599, // Product price (int instead of double)
    "description": "A high-performance smartphone with 128GB storage.", // Description
    "stock": 20, // Stock availability
  },
  {
    "name": "Laptop", // Product name
    "category": "Electronics", // Product category
    "price": 999, // Product price (int instead of double)
    "description": "A lightweight laptop with a 15-inch display.", // Description
    "stock": 15, // Stock availability
  },
];
