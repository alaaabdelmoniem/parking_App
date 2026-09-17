import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/map/presentation/views/widgets/custom_booking.dart';
import 'package:parking/features/map/presentation/views/widgets/date_and_time_section.dart';

class ReserveASpot extends StatelessWidget {
  const ReserveASpot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26.r),
          topRight: Radius.circular(26.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Reserve a Spot',
                    style: AppTextStyle.sheetTitle.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text('City Center Parking', style: AppTextStyle.bodySmall),
                ],
              ),
              IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,

                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: Icon(
                  Icons.close,
                  color: AppColors.textSecondary,
                  size: 22.sp,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),

          SizedBox(height: 10.h),
          FittedBox(
            child: Row(
              children: [
                const CustomBooking(text: 'Date & Time', num: 1),
                SizedBox(width: 6.w),
                Container(
                  height: 1.5,
                  width: 52.w,
                  color: AppColors.textBody.withValues(alpha: .2),
                ),
                SizedBox(width: 6.w),

                const CustomBooking(text: 'Choose Spot', num: 2),
                SizedBox(width: 6.w),
                Container(
                  height: 1.5,
                  width: 52.w,
                  color: AppColors.textBody.withValues(alpha: .2),
                ),
                SizedBox(width: 6.w),

                const CustomBooking(text: 'Review & Pay', num: 3),
                SizedBox(width: 6.w),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          const DateAndTimeSection(),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}
