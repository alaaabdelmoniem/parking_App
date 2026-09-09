import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class CustomSeeAllTextField extends StatelessWidget {
  const CustomSeeAllTextField({super.key, this.onChanged});
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search parking locations...',
          hintStyle: AppTextStyle.body.copyWith(color: AppColors.textTertiary),
          prefixIcon: Icon(
            Icons.search,
            size: 20.sp,
            color: AppColors.textTertiary,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 20.h,
          ),
        ),
      ),
    );
  }
}