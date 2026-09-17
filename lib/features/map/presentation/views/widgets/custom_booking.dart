
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class CustomBooking extends StatelessWidget {
  const CustomBooking({super.key, required this.text, required this.num});
  final String text;
  final int num;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 23,
          width: 23,
          decoration: const BoxDecoration(
            color: AppColors.primaryPale,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              num.toString(),
              style: AppTextStyle.monoSmall.copyWith(
                color: AppColors.textTertiary,
                fontSize: 13.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Text(text, style: AppTextStyle.body),
      ],
    );
  }
}
