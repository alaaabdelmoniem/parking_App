import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';

class StatsCardInfo extends StatelessWidget {
  const StatsCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Widget divider() =>
        Container(width: 1, height: 30.h, color: AppColors.border);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Expanded(
            child: _Stat(value: '12', label: 'Bookings'),
          ),
          divider(),
          const Expanded(
            child: _Stat(value: '1', label: 'Active'),
          ),
          divider(),
          const Expanded(
            child: _Stat(value: '\$184', label: 'Spent'),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyle.cardTitle.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppTextStyle.captionSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
