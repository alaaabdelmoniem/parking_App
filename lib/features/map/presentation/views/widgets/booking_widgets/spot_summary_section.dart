import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_router.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_and_time_formats.dart';
import 'package:parking/core/utils/functions/get_current_postiones.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/Space_Befor_section_title.dart';
import 'package:parking/features/map/presentation/views/widgets/booking_widgets/reservation_tips.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_distance_and_reviews_row.dart';

class SpotSummarySection extends StatefulWidget {
  const SpotSummarySection({
    super.key,
    required this.spotModel,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });
  final SpotModel spotModel;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;

  @override
  State<SpotSummarySection> createState() => _SpotSummarySectionState();
}

class _SpotSummarySectionState extends State<SpotSummarySection> {
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

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        widget.spotModel.images[1],
                        width: 78.w,
                        height: 78.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 78.w,
                          height: 78.w,
                          color: AppColors.surfaceMuted,
                          child: const Icon(
                            Icons.local_parking,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CustomDistanceAndRiewesRow(
                      spotModel: widget.spotModel,
                      dis: dis,
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                const SpaceBeforSectionTitle(),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter After',
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              formatDateTime(widget.startTime),
                              style: AppTextStyle.sheetTitle.copyWith(
                                color: AppColors.textPrimary.withValues(
                                  alpha: .8,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: VerticalDivider(
                          color: AppColors.textBody.withValues(alpha: .2),
                          thickness: 1,
                          width: 1,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exit Before',
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              formatDateTime(widget.endTime),
                              style: AppTextStyle.sheetTitle.copyWith(
                                color: AppColors.textPrimary.withValues(
                                  alpha: .8,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SpaceBeforSectionTitle(),
                SizedBox(height: 30.h),

                const ReservationTips(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  sizeStyle: CupertinoButtonSize.medium,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                  onPressed: () {
                    GoRouter.of(context).push(
                      AppRouter.kCheckoutView,
                      extra: BookModel(
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        duration: widget.duration,
                        spotModel: widget.spotModel,
                      ),
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: AppTextStyle.buttonSmall.copyWith(
                      color: AppColors.textOnDark,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
