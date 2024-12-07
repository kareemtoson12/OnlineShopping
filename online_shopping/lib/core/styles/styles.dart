// styles.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';

// Text Styles
class AppTextStyles {
  static TextStyle font25blackRegular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle font25blacSubTitle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: CustomsColros.white,
  );
  static TextStyle font20blacSubTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle font30blackTitle = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
    color: CustomsColros.white,
  );
  static TextStyle font30RedBlond = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.red,
  );
  static TextStyle font25blod = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.w500,
    color: CustomsColros.white,
  );
  static TextStyle fontForLabel = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle fontForSmallLabel = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle fontForshowCart = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: CustomsColros.primaryColor,
  );
  static TextStyle font18gray = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
  static TextStyle fontForLabelWithPrimaryColor = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: CustomsColros.primaryColor,
  );
}
