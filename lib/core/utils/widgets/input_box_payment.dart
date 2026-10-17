
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';

class InputBoxPayment extends StatelessWidget {
  const InputBoxPayment({super.key, 
    required this.controller,
    required this.hint,
    required this.formatters,
    required this.onChanged,
    this.suffix,
    this.isLast = false,
  });

  final TextEditingController controller;
  final String hint;
  final List<TextInputFormatter> formatters;
  final ValueChanged<String> onChanged;
  final Widget? suffix;
  final bool isLast; // last field submits the keyboard instead of "next"

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      inputFormatters: formatters,
      onChanged: onChanged,
      style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.body.copyWith(color: AppColors.textTertiary),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
    );
  }
}