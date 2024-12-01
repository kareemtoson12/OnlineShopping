import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget searchWidget() {
  return Container(
    height: 60.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search for products...',
        hintStyle: TextStyle(fontSize: 14.sp),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
      ),
    ),
  );
}
