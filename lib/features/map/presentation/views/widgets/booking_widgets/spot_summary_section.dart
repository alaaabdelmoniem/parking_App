import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_formats.dart';
import 'package:parking/core/utils/functions/get_current_postiones.dart';
import 'package:parking/core/utils/functions/get_distance_and_time.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/Space_Befor_section_title.dart';
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
                              'Enter After',
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

                Text(
                  'PROMO CODE',
                  style: AppTextStyle.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
                const Text('If you have promo code pleae enter it below'),
                SizedBox(height: 20.h),

                Text(
                  'ENTER PROMO CODE',
                  style: AppTextStyle.sectionTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                TextField(
                  cursorColor: AppColors.textSecondary,
                  cursorHeight: 35.h,
                  cursorWidth: 1,

                  decoration: const InputDecoration(
                    isDense: false,
                    contentPadding: EdgeInsets.zero,
                    filled: false,
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSummaryItem(
                        label: 'Parking fee',
                        value: '\$${widget.spotModel.priceForHour}',
                      ),
                      SizedBox(height: 10.h),
                      const CustomSummaryItem(
                        label: 'Tax (8.75%)',
                        value: '\$1.05',
                      ),
                      SizedBox(height: 10.h),
                      const CustomSummaryItem(
                        label: 'Member discount',
                        value: '-\$2.50',
                        valueColor: AppColors.success,
                      ),
                      SizedBox(height: 12.h),
                      const Divider(color: AppColors.border),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: AppTextStyle.cardTitle.copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            '\$${widget.spotModel.priceForDay! * widget.duration}',
                            style: AppTextStyle.monoDisplay.copyWith(
                              color: AppColors.primary,
                              fontSize: 22.sp,
                            ),
                          ),
                        ],
                      ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  sizeStyle: CupertinoButtonSize.medium,
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                  onPressed: () {},
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

class CustomSummaryItem extends StatelessWidget {
  const CustomSummaryItem({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.monoPrice.copyWith(
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class DividerBeforSummaryItem extends StatelessWidget {
  const DividerBeforSummaryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Divider(
          color: AppColors.textBody.withValues(alpha: .1),
          endIndent: 50,
          indent: 50,
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}
