import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';

class CustomPrice extends StatelessWidget {
  const CustomPrice({super.key, required this.spotModel});
  final SpotModel spotModel;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
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
                  ),
                ),
                TextSpan(
                  text: '/hr',
                  style: AppTextStyle.body.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${spotModel.priceForDay}/day',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
