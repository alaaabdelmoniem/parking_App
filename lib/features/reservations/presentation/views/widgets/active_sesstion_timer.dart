import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/core/theme/app_text_style.dart';
import 'package:parking/core/utils/functions/date_and_time_formats.dart';
import 'package:parking/features/map/data/models/booking_model.dart';

class ActiveSesstionTimer extends StatefulWidget {
  const ActiveSesstionTimer({super.key, required this.booking});
  final Bookingmodel booking;
  @override
  State<ActiveSesstionTimer> createState() => _ActiveSesstionTimerState();
}

class _ActiveSesstionTimerState extends State<ActiveSesstionTimer> {
  Timer? _timer;
  late Duration _remaining;

  Duration get _total =>
      widget.booking.endTime.difference(widget.booking.startTime);

  @override
  void initState() {
    super.initState();
    _remaining = _computeRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _remaining = _computeRemaining());
    });
  }

  Duration _computeRemaining() {
    final left = widget.booking.endTime.difference(DateTime.now());
    return left.isNegative ? Duration.zero : left;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSeconds = _total.inSeconds;
    final progress = totalSeconds <= 0
        ? 1.0
        : (1 - _remaining.inSeconds / totalSeconds).clamp(0.0, 1.0);
    // Warn when under 15 minutes are left.
    final isEnding = _remaining.inMinutes < 15;
    final accent = isEnding ? AppColors.warning : AppColors.success;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            isEnding ? 'Ending soon' : 'Time remaining',
            style: AppTextStyle.bodySmall.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            formatTimer(_remaining),
            style: AppTextStyle.monoPriceLarge.copyWith(
              color: AppColors.textPrimary,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 14.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6.h,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(accent),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Started ${formatTimeOnly(widget.booking.startTime)}',
                style: AppTextStyle.captionSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'Ends ${formatTimeOnly(widget.booking.endTime)}',
                style: AppTextStyle.captionSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
