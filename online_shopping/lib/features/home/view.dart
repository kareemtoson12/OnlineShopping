import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/services/auth_service.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';
import 'package:online_shopping/features/home/widgets/catigores.dart';
import 'package:online_shopping/features/home/widgets/popular_products.dart';
import 'package:online_shopping/features/home/widgets/search_bar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(290.h),
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
                FutureBuilder<String?>(
                  future: auth.getUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        'Error loading username',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Text(
                        'Hello, ${snapshot.data}!',
                        style: AppTextStyles.font18gray.copyWith(
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Text(
                        'Hello, Guest!',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      );
                    }
                  },
                ),
                SizedBox(height: 10.h),
                searchWidget(),
                SizedBox(height: 10.h),
                Text(
                  'Popular Categories',
                  style: AppTextStyles.font25blackRegular
                      .copyWith(fontSize: 28.dg, color: Colors.white),
                ),
                SizedBox(height: 10.h),
                CategoriesScreen()
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10.dg),
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
                ],
              ),
              // Popular products grid with explicit height
              const Expanded(
                child: ProductListScreen(), // Constraining its height
              ),
            ],
          ),
        ),
      ),
    );
  }
}
