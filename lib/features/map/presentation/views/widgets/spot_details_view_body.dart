import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/amenities_section.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_spot_details_price.dart';
import 'package:parking/features/map/presentation/views/widgets/spots_details_view_images.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotDetailsViewBody extends StatelessWidget {
  const SpotDetailsViewBody({super.key, required this.spotModel});
  final SpotModel spotModel;

  Future<void> launchWebsite(String url) async {
    final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      log('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpotsDetailsPageViewImages(spotModel: spotModel),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                                      text: '0 min ',
                                      style: AppTextStyle.cardTitle.copyWith(
                                        color: AppColors.textPrimary,
                                        fontSize: 16.sp,
                                      ),
                                    ),

                                    TextSpan(
                                      text: '(31 m)',
                                      style: AppTextStyle.cardSubtitle.copyWith(
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.star,
                                color: AppColors.rating,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                spotModel.rate.toString(),
                                style: AppTextStyle.body.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),

                              Text(
                                '(200)',
                                style: AppTextStyle.body.copyWith(
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (spotModel.website != null) ...[
                                GestureDetector(
                                  onTap: () =>
                                      launchWebsite(spotModel.website!),
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
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: CustomSpotDetailsPrice(spotModel: spotModel),
                    ),
                  ],
                ),

                SizedBox(height: 26.h),
                Divider(
                  indent: 50,
                  color: AppColors.textBody.withValues(alpha: .2),
                  endIndent: 50,
                ),
                SizedBox(height: 20.h),

                const AmenitiesSection(),
                SizedBox(height: 24.h),
                Divider(
                  indent: 50,
                  color: AppColors.textBody.withValues(alpha: .2),
                  endIndent: 50,
                ),
                SizedBox(height: 20.h),

                Text(
                  'Location Access Hours',
                  style: AppTextStyle.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text('${spotModel.openingHours}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
