import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class CustomBookingDateAndTime extends StatelessWidget {
  const CustomBookingDateAndTime({
    super.key,
    required this.label,
    required this.dateText,
    this.onChange,
  });

  final String label;
  final String dateText;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyle.body.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: onChange,
                child: Text(
                  'Change',
                  style: AppTextStyle.buttonSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            dateText,
            style: AppTextStyle.sheetTitle.copyWith(
              color: AppColors.textPrimary.withValues(alpha: .8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
