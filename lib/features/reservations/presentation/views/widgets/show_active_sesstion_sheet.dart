import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/theme/app_colors.dart';
import 'package:parking/features/map/data/models/booking_model.dart';
import 'package:parking/features/map/data/models/spot_model.dart';
import 'package:parking/features/reservations/data/repos/reservations_repo_imple.dart';
import 'package:parking/features/reservations/presentation/manager/cubits/update_duration_booking/update_duration_booking_cubit.dart';
import 'package:parking/features/reservations/presentation/views/widgets/active_sesstion_content.dart';

Future<void> showActiveSessionSheet(
  BuildContext context, {
  required String address,
  required Bookingmodel booking,
  required SpotModel spot,
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
      child: BlocProvider(
        create: (context) => UpdateDurationBookingCubit(
          reservationsRepo: ReservationsRepoImple(),
        ),
        child: ActiveSessionContent(
          spot: spot,
          booking: booking,
          address: address,
          onGetDirections: onGetDirections,
          onViewQrCode: onViewQrCode,
        ),
      ),
    ),
  );
}
