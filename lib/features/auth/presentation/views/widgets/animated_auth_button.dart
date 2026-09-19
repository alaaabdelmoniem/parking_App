
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';

class AnimatedAuthButton extends StatefulWidget {
  const AnimatedAuthButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  State<AnimatedAuthButton> createState() => _AnimatedAuthButtonState();
}

class _AnimatedAuthButtonState extends State<AnimatedAuthButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 26.w),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            widget.text,
            style: AppTextStyle.buttonSmall.copyWith(
              color: AppColors.textOnDark,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
