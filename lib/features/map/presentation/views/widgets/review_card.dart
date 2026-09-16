import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review, required this.comment});

  final ReviewDataModel review;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      margin: EdgeInsets.only(bottom: 7.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ...List.generate(
                    review.rating,
                    (_) =>
                        Icon(Icons.star, size: 15.sp, color: AppColors.rating),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${review.rating}/5',
                    style: AppTextStyle.cardTitle.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              Text(
                review.date,
                style: AppTextStyle.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14.sp,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: 4.w),
              Text(
                review.duration,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textBody,
                ),
              ),
              SizedBox(width: 12.w),
              Icon(
                Icons.directions_car_outlined,
                size: 14.sp,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: 4.w),
              Text(
                review.car,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textBody,
                ),
              ),
              if (review.location != null) ...[
                SizedBox(width: 12.w),
                Icon(
                  Icons.location_on_outlined,
                  size: 14.sp,
                  color: AppColors.textTertiary,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    review.location!,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textBody,
                    ),
                  ),
                ),
              ],
            ],
          ),

          if (review.tags.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: review.tags
                  .map(
                    (tag) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyle.pill.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],

          SizedBox(height: 10.h),

          Text(
            comment,
            style: AppTextStyle.body.copyWith(color: AppColors.textBody),
          ),
        ],
      ),
    );
  }
}
