import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGridView extends StatelessWidget {
  final List<String> productImages = [
    'assets/products/product_24.png',
    'assets/products/product_20.png',
    'assets/products/product_8.png',
    'assets/products/product_8.png',
    'assets/products/product_8.png',
    'assets/products/product_8.png',
  ];

  ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: productImages.length,
        itemBuilder: (context, index) {
          final imagePath = productImages[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on product: $imagePath')),
              );
            },
            child: Container(
              margin: EdgeInsets.all(5.dg),
              padding: EdgeInsets.symmetric(horizontal: 2.dg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5.r,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
