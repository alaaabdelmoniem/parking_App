import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class CustomRatingAndStatus extends StatelessWidget {
  const CustomRatingAndStatus({super.key, required this.spotModel});
  final SpotModel spotModel;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: .09),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Text(
              'Filling up · 23/120',
              style: AppTextStyle.pill.copyWith(
                color: AppColors.warning,
                fontSize: 17.sp,
              ),
            ),
          ),
          SizedBox(width: 7.w),
          Icon(Icons.star, color: AppColors.rating, size: 18.r),
          SizedBox(width: 1.w),
          Text(
            '${spotModel.rate}',
            style: AppTextStyle.body.copyWith(
              color: AppColors.rating,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(width: 7.w),
          Text('(200)', style: AppTextStyle.body.copyWith(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
