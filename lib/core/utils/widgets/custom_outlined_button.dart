import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.hight,
    this.radius,
    this.borderColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final double? hight;
  final double? radius;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight ?? 44.h,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: borderColor ?? AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12.r),
          ),
        ),
        icon: Icon(icon, size: 17.sp, color: borderColor),
        label: Text(
          label,
          style: AppTextStyle.buttonSmall.copyWith(
            color: borderColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
