import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/get_current_postiones.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/core/utils/functions/launch_website_url.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/Space_Befor_section_title.dart';
import 'package:parking/features/map/presentation/views/widgets/amenities_section.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_spot_details_price.dart';
import 'package:parking/features/map/presentation/views/widgets/rating_break_down_section.dart';
import 'package:parking/features/map/presentation/views/widgets/see_all_reviews_button.dart';
import 'package:parking/features/map/presentation/views/widgets/space_avilability.dart';
import 'package:parking/features/map/presentation/views/widgets/spots_details_view_images.dart';
class SpotDetailsViewBody extends StatefulWidget {
  const SpotDetailsViewBody({super.key, required this.spotModel});
  final SpotModel spotModel;

  @override
  State<SpotDetailsViewBody> createState() => _SpotDetailsViewBodyState();
}

class _SpotDetailsViewBodyState extends State<SpotDetailsViewBody> {
  @override
  void initState() {
    super.initState();
    getpos();
  }

  Position? currentPosition;

  Future<void> getpos() async {
    currentPosition = await getCurrentLocation();
    if (mounted) setState(() {}); // screen will update when location recieve
    log('work: $currentPosition');
  }

  @override
  Widget build(BuildContext context) {
    double dis = (currentPosition != null)
        ? getDistanceFrom(
            currentPosition!,
            widget.spotModel.lat,
            widget.spotModel.lng,
          )
        : 0;
    var mxava = (int.tryParse(widget.spotModel.capacity ?? '0') ?? 0);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpotsDetailsPageViewImages(spotModel: widget.spotModel),
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
                            '${widget.spotModel.name}- \n${widget.spotModel.type}',

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
                              Icon(
                                Icons.star,
                                color: AppColors.rating,
                                size: 18.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                widget.spotModel.rate.toString(),
                                style: AppTextStyle.body.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),

                              Text(
                                '(${widget.spotModel.numOfReviews})',
                                style: AppTextStyle.body.copyWith(
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),

                          if (widget.spotModel.website != null ||
                              (widget.spotModel.phone != null)) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.spotModel.website != null) ...[
                                  GestureDetector(
                                    onTap: () => launchWebsite(
                                      widget.spotModel.website!,
                                    ),
                                    child: Text(
                                      widget.spotModel.website!,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.body.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                                if (widget.spotModel.phone != null) ...[
                                  Text(
                                    widget.spotModel.phone!,
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

                    Expanded(
                      flex: 1,
                      child: CustomSpotDetailsPrice(
                        spotModel: widget.spotModel,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.h),
                SpaceAvailability(
                  spotModel: widget.spotModel,
                  totalCap: mxava > 100 ? mxava + 10 : 100,
                ),
                SizedBox(height: 7.h),
                const SpaceBeforSectionTitle(),
                const AmenitiesSection(),
                const SpaceBeforSectionTitle(),
                Text(
                  'Location Access Hours',
                  style: AppTextStyle.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text('${widget.spotModel.openingHours}'),

                const SpaceBeforSectionTitle(),
                Text(
                  'Reviews',
                  style: AppTextStyle.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 17.h),
                RatingBreakdownSection(spotModel: widget.spotModel),
                SizedBox(height: 5.h),

                const SeeAllReviewsButton(),
                const SpaceBeforSectionTitle(),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
