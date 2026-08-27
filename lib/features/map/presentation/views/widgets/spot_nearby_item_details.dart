import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_price.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_rating_and_status.dart';

class SpotNearbyItemDetails extends StatelessWidget {
  const SpotNearbyItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'assets/images/Garage Thumbnail.png',
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Market St Garage',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.cardTitle.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '1.5 mi away · garage',
                        style: AppTextStyle.cardSubtitle,
                      ),
                      SizedBox(height: 11.h),
                      const CustomRatingAndStatus(),
                    ],
                  ),
                ),
                const CustomPrice(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
