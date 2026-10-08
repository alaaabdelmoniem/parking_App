import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking/core/utils/app_colors.dart';
import 'package:parking/core/utils/app_text_style.dart';
import 'package:parking/core/utils/functions/date_and_time_formats.dart';
import 'package:parking/features/map/data/models/book_model.dart';
import 'package:parking/features/map/presentation/views/widgets/tear_line.dart';
import 'package:parking/features/map/presentation/views/widgets/ticket_card_info_column.dart';
import 'package:qr_flutter/qr_flutter.dart';

const _paymentMethod = 'Apple Pay';
const _paymentStatus = 'Paid';
const _reference = 'PS-3F9A1C7E';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    var duration = bookModel.duration;
    final total = duration * (bookModel.spotModel.priceForHour ?? 0);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
            child: Column(
              children: [
                const _HeaderRow(status: 'UPCOMING'),
                SizedBox(height: 22.h),
                // const _TimeRow(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TimeColumn(
                      label: 'Check-in',
                      time: formatTimeOnly(bookModel.startTime),
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Column(
                          children: [
                            Text(
                              '${bookModel.duration.toString()}h',
                              style: AppTextStyle.caption,
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.textPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(color: AppColors.border),
                                ),
                                Container(
                                  width: 28.w,
                                  height: 28.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.directions_car_rounded,
                                    size: 15.sp,
                                    color: AppColors.textOnDark,
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(color: AppColors.border),
                                ),
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.textPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    _TimeColumn(
                      label: 'Check-out',
                      time: formatTimeOnly(bookModel.endTime),
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                const Divider(color: AppColors.divider),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TicketCardInfoColumn(
                      label: 'Date',
                      value: formatDateOnly(bookModel.startTime),
                    ),
                    TicketCardInfoColumn(
                      label: 'Rate',
                      value:
                          '\$${bookModel.spotModel.priceForHour.toString()}/hr',
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TicketCardInfoColumn(
                      label: 'Payment method',
                      value: _paymentMethod,
                    ),
                    TicketCardInfoColumn(
                      label: 'Payment status',
                      value: _paymentStatus,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const TearLine(),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TicketCardInfoColumn(
                      label: 'Booking reference',
                      value: _reference,
                      mono: true,
                    ),
                    TicketCardInfoColumn(
                      label: 'Total paid',
                      value: '\$$total',
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mono: true,
                      valueColor: AppColors.primary,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: QrImageView(
                    data: bookModel.spotModel.id.toString(),
                    version: QrVersions.auto,
                    size: 180.w,
                    backgroundColor: AppColors.surface,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: AppColors.secondary,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Show this code at the entrance',
                  style: AppTextStyle.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.primaryPale,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            Icons.local_parking_rounded,
            size: 20.sp,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          'ParkSmart',
          style: AppTextStyle.cardTitle.copyWith(color: AppColors.textPrimary),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Text(
            status.toUpperCase(),
            style: AppTextStyle.pill.copyWith(
              color: AppColors.textOnDark,
              fontSize: 10.sp,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _TimeColumn extends StatelessWidget {
  const _TimeColumn({
    required this.label,
    required this.time,
    required this.crossAxisAlignment,
  });

  final String label;
  final String time;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(label, style: AppTextStyle.caption),
        SizedBox(height: 4.h),
        Text(
          time,
          style: AppTextStyle.sectionTitle.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
