import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class CustomSpotDetailsPrice extends StatelessWidget {
  const CustomSpotDetailsPrice({super.key, required this.spotModel});
  final SpotModel spotModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            children: [
              TextSpan(
                text: '\$${spotModel.priceForHour}',
                style: AppTextStyle.monoPriceLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 21.sp,
                ),
              ),
              TextSpan(
                text: '/hr',
                style: AppTextStyle.body.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            children: [
              TextSpan(
                text: '\$${spotModel.priceForDay}',
                style: AppTextStyle.monoPriceLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: 18.sp,
                ),
              ),
              TextSpan(
                text: '/day',
                style: AppTextStyle.body.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
