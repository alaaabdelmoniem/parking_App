import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/reservations/presentation/views/widgets/action_row.dart';
import 'package:parking/features/reservations/presentation/views/widgets/status_pill.dart';

enum ReservationCardStatus { upcoming, active, completed }

class ReservationCard extends StatelessWidget {
  const ReservationCard({
    super.key,
    required this.status,
    required this.imageUrl,
    required this.spotName,
    required this.address,
    required this.date,
    required this.timeRange,
    required this.totalPrice,
    this.onTap,
    this.onViewQrCode,
    this.onGetDirections,
    this.onBookAgain,
  });

  final ReservationCardStatus status;
  final String imageUrl;
  final String spotName;
  final String address;

  /// e.g. "Oct 14, 2026"
  final String date;

  /// e.g. "9:00 AM - 11:30 AM"
  final String timeRange;
  final double totalPrice;

  final VoidCallback? onTap;
  final VoidCallback? onViewQrCode;
  final VoidCallback? onGetDirections;
  final VoidCallback? onBookAgain;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    imageUrl,
                    width: 72.w,
                    height: 72.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 72.w,
                      height: 72.w,
                      color: AppColors.surfaceMuted,
                      child: const Icon(
                        Icons.local_parking,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              spotName,
                              style: AppTextStyle.cardTitle.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          StatusPill(status: status),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13.sp,
                            color: AppColors.textTertiary,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              address,
                              style: AppTextStyle.cardSubtitle.copyWith(
                                color: AppColors.textBody,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            const Divider(height: 1, color: AppColors.border),
            SizedBox(height: 12.h),

            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 13.sp,
                  color: AppColors.textTertiary,
                ),
                SizedBox(width: 5.w),
                Text(
                  date,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textBody,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.access_time,
                  size: 13.sp,
                  color: AppColors.textTertiary,
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    timeRange,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textBody,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${totalPrice.toStringAsFixed(2)}',
                        style: AppTextStyle.monoPrice.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            ActionRow(
              status: status,
              onViewQrCode: onViewQrCode,
              onGetDirections: onGetDirections,
              onBookAgain: onBookAgain,
            ),
          ],
        ),
      ),
    );
  }
}
