import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/features/reservations/presentation/views/widgets/plusing_dot.dart';
import '../../../../../core/utils/reservation_card_status.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final ReservationCardStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      ReservationCardStatus.upcoming => (
          'Upcoming',
          AppColors.primary,
          AppColors.primary.withValues(alpha: 0.12),
        ),
      ReservationCardStatus.active => (
          'Active',
          AppColors.success,
          AppColors.success.withValues(alpha: 0.12),
        ),
      ReservationCardStatus.completed => (
          'Completed',
          AppColors.textTertiary,
          AppColors.surfaceMuted,
        ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == ReservationCardStatus.active) ...[
            PulsingDot(color: color),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: AppTextStyle.captionSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}