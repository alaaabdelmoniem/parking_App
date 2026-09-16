import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/widgets/spot_status_info.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class CustomRatingAndStatus extends StatelessWidget {
  const CustomRatingAndStatus({
    super.key,
    required this.spotModel,
    required this.maxCap,
  });
  final SpotModel spotModel;
  final int maxCap;
  @override
  Widget build(BuildContext context) {
    var cap = (int.tryParse(spotModel.capacity ?? '0') ?? 0);
    var statusInfo = getSpotStatus(
      availableSpots: cap,
      totalCapacity: cap > 100 ? cap + 10 : 100,
    );
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
              '${statusInfo.label} · ${spotModel.capacity}/$maxCap',
              style: AppTextStyle.pill.copyWith(
                color: statusInfo.color,
                fontSize: 17.sp,
              ),
            ),
          ),
          SizedBox(width: 7.w),
          Icon(Icons.star, color: AppColors.rating, size: 18.sp),
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
