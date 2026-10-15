import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/oppening_houres.dart';
import 'package:parking/core/utils/widgets/custom_outlined_button.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/map/presentation/views/widgets/cuprtino_date_time_picker.dart';
import 'package:parking/features/reservations/presentation/views/widgets/active_sesstion_timer.dart';

class ActiveSessionContent extends StatelessWidget {
  const ActiveSessionContent({
    super.key,
    required this.address,
    this.onExtendTime,
    this.onGetDirections,
    this.onViewQrCode,
    required this.booking,
    required this.spot,
  });

  final String address;
  final SpotModel spot;
  final VoidCallback? onExtendTime;
  final VoidCallback? onGetDirections;
  final VoidCallback? onViewQrCode;
  final Bookingmodel booking;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text(
            booking.spotName,
            style: AppTextStyle.cardTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14.sp,
                color: AppColors.textTertiary,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  address,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Live countdown card
          ActiveSesstionTimer(booking: booking),
          SizedBox(height: 16.h),

          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${booking.totalPrice.toStringAsFixed(2)}',
                  style: AppTextStyle.monoPrice.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 46.h,
            child: ElevatedButton.icon(
              onPressed: () async {
                final hours = OpeningHours.tryParse(spot.openingHours);

                final result = await showCupertinoDateTimePicker(
                  context,
                  title: 'End Time',
                  initialDateTime: booking.endTime,
                  openingHours: hours,
                );
                if (result != null) {
                  // setState(() => _selectedEndDateTime = result);
                  print(result);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Icons.add_alarm, size: 18.sp),
              label: Text(
                'Extend Time',
                style: AppTextStyle.buttonSmall.copyWith(
                  color: AppColors.textOnDark,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  icon: Icons.directions_outlined,
                  label: 'Directions',
                  onPressed: onGetDirections,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomOutlinedButton(
                  icon: Icons.qr_code_rounded,
                  label: 'QR Code',
                  onPressed: onViewQrCode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
