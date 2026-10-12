import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/main/presentation/views/widgets/reservation_status_filter.dart';

class ReservationsViewBody extends StatelessWidget {
  const ReservationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Text(
            'my Reservations',
            style: AppTextStyle.pageTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15.h),
          const ReservationStatusFilter(),
        ],
      ),
    );
  }
}
