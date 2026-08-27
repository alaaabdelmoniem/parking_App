import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class CustomPrice extends StatelessWidget {
  const CustomPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(
              children: [
                TextSpan(
                  text: r'$20.5',

                  style: AppTextStyle.monoPriceLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: '/hr',
                  style: AppTextStyle.body.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(r'$48/day', style: AppTextStyle.body.copyWith(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
