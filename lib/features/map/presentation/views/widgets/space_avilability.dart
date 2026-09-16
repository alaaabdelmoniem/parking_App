import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/widgets/spot_status_info.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class SpaceAvailability extends StatelessWidget {
  const SpaceAvailability({
    super.key,
    required this.spotModel,
    this.totalCap = 100,
  });
  final SpotModel spotModel;
  final int totalCap;
  @override
  Widget build(BuildContext context) {
    var cap = int.tryParse(spotModel.capacity ?? '0') ?? 0;
    var ratio = cap / totalCap;
    var statusInfo = getSpotStatus(
      availableSpots: cap,
      totalCapacity: totalCap,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Space Availability',
              style: AppTextStyle.sectionTitle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 15.sp,
              ),
            ),
            Text(
              '${spotModel.capacity} of $totalCap free',
              style: AppTextStyle.monoPrice.copyWith(color: statusInfo.color),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 7.h,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(statusInfo.color),
          ),
        ),
      ],
    );
  }
}
