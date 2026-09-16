
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/core/utils/functions/launch_website_url.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_spot_details_price.dart';

class SpotDetailsViewDetailsSection extends StatelessWidget {
  const SpotDetailsViewDetailsSection({super.key, required this.spotModel, required this.dis});
  final SpotModel spotModel;
  final double dis;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${spotModel.name}- \n${spotModel.type}',

                maxLines: 4,
                overflow: TextOverflow.ellipsis,

                style: AppTextStyle.cardTitle.copyWith(
                  height: 1,
                  color: AppColors.textPrimary,
                  fontSize: 19.sp,
                ),
              ),
              SizedBox(height: 7.h),
              Row(
                children: [
                  Icon(
                    Icons.directions_walk_rounded,
                    color: AppColors.textPrimary,
                    size: 18.sp,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: formatWalkingTime(dis),
                          style: AppTextStyle.cardTitle.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 16.sp,
                          ),
                        ),

                        TextSpan(
                          text: '\t(${formatDistance(dis)})',
                          style: AppTextStyle.cardSubtitle.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(Icons.star, color: AppColors.rating, size: 18.sp),
                  SizedBox(width: 6.w),
                  Text(
                    spotModel.rate.toString(),
                    style: AppTextStyle.body.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(width: 6.w),

                  Text(
                    '(${spotModel.numOfReviews})',
                    style: AppTextStyle.body.copyWith(
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              if (spotModel.website != null || (spotModel.phone != null)) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (spotModel.website != null) ...[
                      GestureDetector(
                        onTap: () => launchWebsite(spotModel.website!),
                        child: Text(
                          spotModel.website!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.body.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                    if (spotModel.phone != null) ...[
                      Text(
                        spotModel.phone!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),

        Expanded(flex: 1, child: CustomSpotDetailsPrice(spotModel: spotModel)),
      ],
    );
  }
}
