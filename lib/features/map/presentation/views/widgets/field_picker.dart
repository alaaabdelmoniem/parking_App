import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.isPlaceholder,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isPlaceholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: AppTextStyle.body.copyWith(
                    color: isPlaceholder
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                    fontSize: 15.sp,
                  ),
                ),
                Icon(icon, size: 18.sp, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
