import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/reservations/presentation/views/widgets/active_sesstion_content.dart';

Future<void> showActiveSessionSheet(
  BuildContext context, {
  required String address,
  required Bookingmodel booking,
  VoidCallback? onExtendTime,
  VoidCallback? onGetDirections,
  VoidCallback? onViewQrCode,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: ActiveSessionContent(
        booking: booking,
        address: address,
        onGetDirections: onGetDirections,
        onViewQrCode: onViewQrCode,
      ),
    ),
  );
}
