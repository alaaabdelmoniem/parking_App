import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_formats.dart';
import 'package:parking/core/utils/functions/format_and_calculate_duration.dart';

class SessionPreviewCard extends StatelessWidget {
  const SessionPreviewCard({
    super.key,
    required this.startTm,
    required this.endTm,
    required this.date,
    required this.totalPrice,
  });
  final TimeOfDay startTm;
  final TimeOfDay endTm;
  final DateTime date;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    var startTime = startTm.format(context);
    var endTime = endTm.format(context);
    var duration = formatDuration(calculateDuration(startTm, endTm));
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryPale,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Session Preview',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$startTime → $endTime',
                  style: AppTextStyle.cardTitle.copyWith(
                    color: AppColors.primaryDark,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${date.day}, ${getShortMonthName(date)}, ${date.year} · $duration',

                  style: AppTextStyle.caption.copyWith(
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$64',
            style: AppTextStyle.monoDisplay.copyWith(
              color: AppColors.primaryDark,
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
