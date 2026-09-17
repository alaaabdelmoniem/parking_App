import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/get_current_postiones.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/Space_Befor_section_title.dart';
import 'package:parking/features/map/presentation/views/widgets/Spot_details_view_details_section.dart';
import 'package:parking/features/map/presentation/views/widgets/amenities_section.dart';
import 'package:parking/features/map/presentation/views/widgets/book_button_section.dart';
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
    return Stack(
      children: [
        SingleChildScrollView(
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
                    SpotDetailsViewDetailsSection(
                      spotModel: widget.spotModel,
                      dis: dis,
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
                    SizedBox(height: MediaQuery.of(context).size.height * .18),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: BookButtonSection(spotModel: widget.spotModel),
        ),
      ],
    );
  }
}
