import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class RatingBreakdownSection extends StatelessWidget {
  const RatingBreakdownSection({super.key, required this.spotModel});
  final SpotModel spotModel;
  static const Map<int, int> _breakdown = {5: 85, 4: 6, 3: 3, 2: 2, 1: 4};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: AppColors.rating, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              '${spotModel.rate}',
              style: AppTextStyle.cardTitle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Container(width: 1, height: 14.h, color: AppColors.border),
            SizedBox(width: 8.w),
            Text(
              '3.1K ratings',
              style: AppTextStyle.body.copyWith(color: AppColors.textBody),
            ),
            SizedBox(width: 6.w),
            Icon(
              Icons.info_outline,
              size: 16.sp,
              color: AppColors.textTertiary,
            ),
          ],
        ),

        SizedBox(height: 16.h),

        ..._breakdown.entries.map(
          (entry) => Padding(
            padding: EdgeInsets.only(bottom: 8.h, right: 4.w),
            child: Row(
              children: [
                Text(
                  '${entry.key}',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: entry.value / 100,
                      minHeight: 7.h,
                      backgroundColor: AppColors.border,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: 32.w,
                  child: Text(
                    '${entry.value}%',
                    textAlign: TextAlign.end,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textBody,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
