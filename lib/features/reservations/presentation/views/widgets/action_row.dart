import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import '../../../../../core/utils/reservation_card_status.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({
    super.key,
    required this.status,
    required this.onViewQrCode,
    required this.onGetDirections,
    required this.onBookAgain,
  });

  final ReservationCardStatus status;
  final VoidCallback? onViewQrCode;
  final VoidCallback? onGetDirections;
  final VoidCallback? onBookAgain;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ReservationCardStatus.upcoming:
        return SizedBox(
          width: double.infinity,
          height: 40.h,
          child: ElevatedButton.icon(
            onPressed: onViewQrCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textOnDark,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Icons.qr_code_rounded, size: 17.sp),
            label: Text(
              'View QR Code',
              style: AppTextStyle.buttonSmall.copyWith(
                color: AppColors.textOnDark,
              ),
            ),
          ),
        );

      case ReservationCardStatus.active:
        return SizedBox(
          width: double.infinity,
          height: 40.h,
          child: OutlinedButton.icon(
            onPressed: onGetDirections,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Icons.directions_outlined, size: 17.sp),
            label: Text(
              'Get Directions',
              style: AppTextStyle.buttonSmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        );

      case ReservationCardStatus.completed:
        return SizedBox(
          width: double.infinity,
          height: 40.h,
          child: OutlinedButton.icon(
            onPressed: onBookAgain,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Icons.replay_rounded, size: 17.sp),
            label: Text(
              'Book Again',
              style: AppTextStyle.buttonSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        );
    }
  }
}
